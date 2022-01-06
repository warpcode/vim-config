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

    if fullpath ~= '' then
        return fullpath
    end
    
    -- If it's not in the above paths, search the system path
    if vim.fn.executable(exe_name) == 1 then
        return exe_name
    end

    -- Empty string denotes no executable was found
    return ''
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

    return ''
end

M.find_first_path_in_parents = function(paths, _base_path)
    -- Ensure we get the full path to traverse
    local base_path = vim.fn.fnamemodify(_base_path or '/', ':p')
    base_path = M.remove_trailing_slash(base_path)

    -- Search this current path for one of the provided files
    for _, path in pairs(paths) do
        path = M.remove_trailing_slash(path)
        local fullpath = base_path .. '/' .. path

        if base_path == '/' then
            fullpath = base_path .. path
        end

        if vim.fn.filereadable(fullpath) == 1 then
            return fullpath
        elseif vim.fn.isdirectory(fullpath) == 1 then
            return fullpath .. '/'
        end
    end

    -- File not found and we are at relative or absolute root, return empty string
    if base_path == '/' then
        return ''
    end

    -- strip of the current path segment and search the next parent
    base_path = M.dirname(base_path)
    return M.find_first_path_in_parents(paths, base_path)
end

M.remove_trailing_slash = function (path)
    if path ~= '/' and string.sub(path, -1, -1) == "/" then
        path = string.sub(path, 1, -2)
    end

    return path
end
return M
