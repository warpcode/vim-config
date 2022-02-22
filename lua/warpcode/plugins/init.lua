local plugin_loc = 'warpcode.plugins.'

-- List plugins that must be installed, these can then have dependencies
local plugins_list = {
    'packer',

    'local_node',
    'local_php',
    'local_snippets',

    -- Completion
    -- use 'github/copilot.vim'
    'cmp',
    'cmp-buffer',
    'cmp-calc',
    'cmp-cmdline',
    'cmp-emoji',
    'cmp-nvim-lsp',
    'cmp-nvim-lua',
    'cmp-omni',
    'cmp-path',
    'cmp-treesitter',
    'cmp-tabnine',
    'cmp-luasnip',
    'luasnip',
    'friendly-snippets',
    'vim-snippets',

    -- File Managers
    'nerdtree',
    'nerdtree-tabs',
    'nerdtree-git',
    'telescope',
    'telescope-fzf',

    -- lsp
    'lsp-config',
    'lsp-kind',
    'lsp-null-ls',
    'lsp-saga',
    'lsp-signature',

    -- Themes
    'theme-base16',
    'theme-gruvbox',
    'theme-vim-colorschemes',

    -- UI
    'airline',
    'airline-themes',
    'devicons',
    'indent-blankline',
    'trailing-whitespace',

    -- Utils
    'cheatsheet',
    'commentary',
    'delimitmate',
    'man',
    'notify',
    'plenary',
    'popup',
    'surround',
    'treesitter',
    'treesitter-playground',
    -- 'treesitter-rainbow',
    'undotree',

    -- Version Control
    'vcs-fugitive',
    'vcs-gitgutter',
    'vcs-gv',
}

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec(
    [[
    augroup Packer
        autocmd!
        autocmd BufWritePost */plugins/*.lua PackerCompile
    augroup end
    ]],
    false
)

return require('packer').startup(function()
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
