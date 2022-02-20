local wbuf = require 'warpcode.utils.buffers'
local M = {}

M.dirname = function (str)
    return str:match("(.*/)")
end

M.find_exe_path = function (exe_name)
    local search_paths = {}

    -- TODO project versions?

    -- vim config versions
    search_paths[#search_paths + 1] = vim.g.vim_source .. '/modules/node/node_modules/.bin/'
    search_paths[#search_paths + 1] = vim.g.vim_source .. '/modules/node/bin/'
    search_paths[#search_paths + 1] = vim.g.vim_source .. '/modules/php/vendor/bin/'
    search_paths[#search_paths + 1] = vim.g.vim_source .. '/modules/php/bin/'
    search_paths[#search_paths + 1] = vim.g.vim_source .. '/bin/'


    local fullpath = M.find_file_in_paths(exe_name, search_paths)

    if fullpath ~= nil then
        return fullpath
    end

    -- If it's not in the above paths, search the system path
    if vim.fn.executable(exe_name) == 1 then
        return exe_name
    end

    -- Empty string denotes no executable was found
    return nil
end

M.find_file_in_paths = function (filename, paths)
    for _, path in pairs(paths or {}) do
        if string.sub(path, -1, -1) ~= "/" then
            path = path .. '/'
        end

        if vim.fn.filereadable(path .. filename) == 1 then
            return path .. filename
        end
    end

    return nil
end

M.get_file_buf_or_cwd = function (buf)
    file = vim.api.nvim_buf_get_name(wbuf.get_bufnr())

    if not file or file == '' then
        file = vim.fn.getcwd()
    end

    return file
end

M.root_pattern = function (_files, _base_path, _match_all)
    if not _files then
        -- no files to match. abort
        return nil
    end

    local base_path = M.remove_trailing_slash(_base_path or '/')
    if vim.fn.filereadable(base_path) == 1 then
        -- Detected a file as the base path so strip the filename
        base_path = vim.fn.fnamemodify(base_path, ':h')
        base_path = M.remove_trailing_slash(base_path)
    end

    local matches = 0
    for _, file in pairs(_files) do
        file = M.remove_trailing_slash(file)

        local fullpath = M.add_trailing_slash(base_path) .. file
        local is_file = vim.fn.filereadable(fullpath) == 1
        local is_dir = not is_file and vim.fn.isdirectory(fullpath) == 1

        if is_file or is_dir then
            matches = matches + 1

            if not _match_all then
                -- If we don't need to match all, just return the current base_path
                return M.add_trailing_slash(base_path)
            end
        end
    end

    if _match_all and matches > 0 and #_files == matches then
        -- Matched all files, return the path
        return M.add_trailing_slash(base_path)
    end

    -- Some files were not found and we're at root so return nil
    if base_path == '/' then
        return nil
    end

    -- strip of the current path segment and search the next parent
    base_path = M.dirname(base_path)
    return M.root_pattern(_files, base_path, _match_all)
end

--- Find a root directory by the name of the root directory
---@param _name string
---@param _base_path string
---@param _full_match boolean
---@return string|nil
M.root_pattern_by_parent_name = function (_name, _base_path, _full_match)
    if not _name or _name == '' then
        -- Nothing sent to match
        return nil
    end

    local base_path = M.remove_trailing_slash(_base_path or '/')

    if base_path == '/' or base_path == '' then
        return nil
    end

    local split_path = vim.split(base_path, '/')
    local last_segment = split_path[#split_path]

    if _full_match and _name == last_segment then
        return M.add_trailing_slash(base_path)
    elseif not _full_match and string.match(last_segment, _name) then
        return M.add_trailing_slash(base_path)
    end

    -- strip of the current path segment and search the next parent
    base_path = M.dirname(base_path)
    return M.root_pattern_by_parent_name(_name, base_path, _full_match)
end

M.remove_trailing_slash = function (path)
    if path ~= '/' and string.sub(path, -1, -1) == "/" then
        path = string.sub(path, 1, -2)
    end

    return path
end

M.add_trailing_slash = function (path)
    path = path or '/'

    if path == '/' then
        return path
    end

    if string.sub(path, -1, -1) ~= "/" then
        path = path .. '/'
    end

    return path
end

return M
