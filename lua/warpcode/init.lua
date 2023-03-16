require('warpcode.globals')
require('warpcode.plugins').init {
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
    'vcs-gitsigns',
}
require('warpcode.projects')
require('warpcode.statusline')
