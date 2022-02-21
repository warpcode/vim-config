local plugin_loc = 'warpcode.plugins.'

-- List plugins that must be installed, these can then have dependencies
local plugins_list = {
    'packer',

    -- Completion
    'cmp',

    -- File Managers
    'nerdtree',

    -- lsp
    'lspconfig',

    -- Themes
    'theme_base16',
    'theme_gruvbox',
    'theme_vim_colorschemes',

    -- UI
    'airline',
    'devicons',

    -- Utils
    'plenary',
    'treesitter',
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

        local plugin_tbl = {plugin.source}

        local map = {
            'config',
            'setup',
            'run',
        }

        for _, v in pairs(map) do
            if plugin[v] then
                plugin_tbl[v] = plugin[v]
            end
        end

        if plugin.requires then
            plugin_tbl.requires = {}
            for _, child in pairs(plugin.requires) do
                plugin_tbl.requires[#plugin_tbl.requires + 1] = create_plugin_tbl(child)
            end
        end

        return plugin_tbl
    end

    for _, v in pairs(plugins_list) do
        local plugin = create_plugin_tbl(v)

        use(plugin)
    end

    use(vim.g.vim_source .. '/modules/node')
    use(vim.g.vim_source .. '/modules/php')

    -- Completion
    -- use 'github/copilot.vim'

    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('warpcode.plugins.luasnip')
        end,
        requires = {
            {'rafamadriz/friendly-snippets'},
            {'honza/vim-snippets'},
            {vim.g.vim_source .. '/modules/snippets'},
        }
    }

    -- commented out, causing errors
    -- use {
    --     'simrat39/symbols-outline.nvim',
    --     config = function()
    --         require('warpcode.plugins.symbols-outline')
    --     end,
    -- }

    -- File Managers
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('warpcode.plugins.telescope')
        end,
        requires = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
            },
        }
    }

    -- lsp
    use {
        'tami5/lspsaga.nvim',
        config = function()
            require('warpcode.plugins.lspsaga')
        end,
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('warpcode.plugins.lsp_signature')
        end,
    }

    -- UI
    use 'bronson/vim-trailing-whitespace'
    use 'lukas-reineke/indent-blankline.nvim'

    -- Utils
    use 'nvim-lua/popup.nvim'
    use 'tpope/vim-commentary'
    use 'Raimondi/delimitMate'
    use 'tpope/vim-surround'
    use 'vim-utils/vim-man'
    use {
        'mbbill/undotree',
        config = function()
            vim.api.nvim_exec([[
                let g:undotree_HighlightChangedWithSign = 0
                let g:undotree_WindowLayout             = 4
                let g:undotree_SetFocusWhenToggle       = 1

                nnoremap <Leader>u :UndotreeToggle<CR>
            ]], false)
        end,
    }
    use 'sudormrfbin/cheatsheet.nvim'

    -- Version Control
    if vim.fn.executable('git') == 1 then
        use 'tpope/vim-fugitive'
        use 'airblade/vim-gitgutter'
        use 'junegunn/gv.vim'
    end
end)
