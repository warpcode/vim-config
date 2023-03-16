local M = {}
local filetype_callbacks = {
    require 'luasnip.extras.filetype_functions'.from_pos_or_filetype,
}

---Register a new callback used to detect
---additional filetypes for the current buffer
---@param callback function
M.register_filetype_callback = function(callback)
    vim.list_extend(filetype_callbacks, { callback })
end

---Return the filetypes for the current buffer
---@return table
M.get_filetypes = function()
    local ft = {}

    for _, callback in pairs(filetype_callbacks) do
        local filetypes = callback() or {}

        if type(filetypes) ~= 'table' then
            filetypes = { filetypes }
        end

        vim.list_extend(ft, filetypes)
    end

    return ft
end

---Get the list of snipmate snippets paths
---@return table
M.get_snipmate_snippets_paths = function()
    local plugins = { "vim-snippets" }
    local paths = {
        vim.g.vim_source .. '/snippets'
    }
    for _, plug in ipairs(plugins) do
        local path = require 'warpcode.plugins'.get_plugin_path(plug) or ''
        if path ~= '' and vim.fn.isdirectory(path .. '/snippets') ~= 0 then
            table.insert(paths, path .. '/snippets')
        end
    end

    return paths
end

---Get the list of vscode snippets paths
---@return table
M.get_vscode_snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {
        vim.g.vim_source
    }
    for _, plug in ipairs(plugins) do
        local path = require 'warpcode.plugins'.get_plugin_path(plug) or ''
        if path ~= '' and vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end

    return paths
end

---Initialise the snippets
M.load_snippets = function()
    local snippets_snipmate_paths = M.get_snipmate_snippets_paths()
    local snippets_vscode_paths = M.get_vscode_snippets_paths()

    -- Load snipmate style snippets
    if #snippets_snipmate_paths > 0 then
        -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
        -- are stored in `ls.snippets._`.
        -- We need to tell luasnip that "_" contains global snippets:
        require 'luasnip'.filetype_extend("all", { "_" })

        require("luasnip.loaders.from_snipmate").load({
            paths = snippets_snipmate_paths
        })
    end

    -- Load vscode style snippets
    if #snippets_vscode_paths > 0 then
        require("luasnip.loaders.from_vscode").load({
            paths = snippets_vscode_paths,
            include = nil, -- Load all languages
            exclude = {}
        })
    end
end

return M
