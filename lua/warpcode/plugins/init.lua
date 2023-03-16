local plugin_loc = 'warpcode.plugins.'
local M = {}

---Get the plugin name from a given path
---@param path string
---@return string
M.get_plugin_name_from_path = function(path)
    local new_name = vim.fn.matchstr(path, '[/\\\\]\\zs[^/\\\\]\\+$')
    return vim.fn.substitute(new_name, '\\C\\.git$', '', '')
end

---Get the path for an installed plugin
---@param plugin string
---@return string|nil
M.get_plugin_path = function(plugin)
    for _, p in pairs(vim.api.nvim_list_runtime_paths()) do
        if M.get_plugin_name_from_path(p) == plugin then
            return p
        end
    end

    return nil
end

---Initialise packer and the plugins
---@param plugins_list table
M.init = function(plugins_list)
    vim.cmd [[packadd packer.nvim]]
    local packer_group = vim.api.nvim_create_augroup('packer', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
        command = 'PackerCompile',
        pattern = '*/plugins/*.lua',
        group = packer_group
    })

    require 'packer'.init {
        display = {
            open_fn = function()
                return require "packer.util".float { border = 'rounded' }
            end,
        }
    }

    return require 'packer'.startup(function()
        local function get_plugin(name)
            local ok, plugin = pcall(require, plugin_loc .. name)

            if not ok then
                return nil
            end

            return plugin
        end

        local function create_plugin_tbl(name)
            local plugin = get_plugin(name)

            if not plugin or not plugin.source or plugin.source == '' then
                error('Could not find plugin: ' .. name)
            end

            local plugin_source = plugin[1] or nil
            plugin_source = plugin_source or plugin.source
            plugin.source = nil
            plugin[1] = plugin_source

            if not plugin[1] or plugin[1] == '' then
                error('Plugin source not specified : ' .. name)
            end

            return plugin
        end

        for _, v in pairs(plugins_list) do
            local plugin = create_plugin_tbl(v)
            use(plugin)
        end
    end)
end

return M
