local plugin_loc = 'warpcode.plugins.'

-- List plugins that must be installed, these can then have dependencies
local plugins_list = {
    'packer',

    -- Completion
    -- use 'github/copilot.vim'
    'cmp',
    'snippets',

    -- Debugger
    -- 'nvim-dap-vscode-php-debug',
    -- 'nvim-dap',
    -- 'nvim-dap-ui',
    -- 'nvim-dap-virtual-text',

    -- File Managers
    'nerdtree',

    -- lsp
    'lsp',
    'symbols-outline',

    -- Telescope
    'telescope',

    -- Themes
    'themes',

    -- UI
    'airline',
    'devicons',
    'indent-blankline',
    'trailing-whitespace',

    -- Utils
    'abolish',
    'cheatsheet',
    'commentary',
    'delimitmate',
    'man',
    'notify',
    'plenary',
    'popup',
    'surround',
    'treesitter',
    'undotree',

    -- Version Control
    'vcs-fugitive',
    'vcs-gitgutter',
    'vcs-gv',
}

vim.cmd [[packadd packer.nvim]]
local packer_group = vim.api.nvim_create_augroup('packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'PackerCompile',
    pattern = '*/plugins/*.lua',
    group = packer_group
})

local packer_ok, packer = pcall(require, 'packer')

if not packer then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require"packer.util".float { border = 'rounded' }
        end,
    }
}

return packer.startup(function()
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
