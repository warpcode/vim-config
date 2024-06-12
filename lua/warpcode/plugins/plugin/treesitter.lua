return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/playground',
        { 'p00f/nvim-ts-rainbow' },
    'nvim-treesitter/nvim-treesitter-context',
    'p00f/nvim-ts-rainbow',
    },
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            'awk',
            'bash',
            'c',
            'c_sharp',
            'cpp',
            'css',
            'csv',
            'dockerfile',
            'html',
            'javascript',
            'jsdoc',
            'json',
            'json5',
            'jsonc',
            'lua',
            'luadoc',
            'make',
            'markdown',
            'php',
            'phpdoc',
            'python',
            'regex',
            'scss',
            'sql',
            'svelte',
            'terraform',
            'tmux',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'vue',
            'xml',
            'yaml',
        },
        auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = {
            enable = true,
            disable = { 'ruby' }
        },
        -- rainbow = {
        --     enable = true,
        --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
        --     -- colors = {}, -- table of hex strings
        --     -- termcolors = {} -- table of colour name strings
        -- }
    },
    config = function(_, opts)
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
}
