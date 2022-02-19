local result = require 'packer.result'
local async = require 'packer.async'.sync

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec(
    [[
    augroup Packer
        autocmd!
        autocmd BufWritePost */plugins/init.lua PackerCompile"
    augroup end
    ]],
    false
)

-- if packer == nil then
--     packer = require 'packer'
--     packer.init { disable_commands = true }
-- end

-- local use = packer.use
-- packer.reset()
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use(vim.g.vim_source .. '/modules/node')
    use(vim.g.vim_source .. '/modules/php')

    -- Completion
    -- use 'github/copilot.vim'
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require('warpcode.plugins.cmp')
        end,
        run = function()
            vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/node" && npm i\' | redraw', false)
            vim.api.nvim_exec('exe \'!cd "' .. vim.g.vim_source .. '/modules/php" && php ' .. vim.g.vim_source .. '/bin/composer.phar install\' | redraw', false)
        end,
        requires = {
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-calc'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-emoji'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-omni'},
            {'hrsh7th/cmp-path'},
            {'ray-x/cmp-treesitter'},
            {
                'tzachar/cmp-tabnine',
                run = './install.sh',
            },
            {'saadparwaiz1/cmp_luasnip'},
        }
    }

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

    use {
        'onsails/lspkind-nvim',
        config = function()
            require('warpcode.plugins.lspkind')
        end,
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
    use {
        'scrooloose/nerdtree',
        requires = {
            { 'jistr/vim-nerdtree-tabs'},
            { 'Xuyuanp/nerdtree-git-plugin'},
        },
    }

    -- lsp
    use 'neovim/nvim-lspconfig'
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

     -- Status bar
     use {
         'vim-airline/vim-airline',
         requires = {
             {'vim-airline/vim-airline-themes'},
         },
     }

     -- Themes
     use 'chriskempson/base16-vim'
     use 'flazz/vim-colorschemes'
     use {
        'gruvbox-community/gruvbox',
        config = function()
            vim.api.nvim_exec([[colorscheme gruvbox]], false)
        end,
     }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('warpcode.plugins.treesitter')
        end,
    }

    -- use 'nvim-treesitter/playground'
    -- use 'p00f/nvim-ts-rainbow'

    -- UI
    use 'bronson/vim-trailing-whitespace'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'Yggdroot/indentLine'
    use 'ryanoasis/vim-devicons'

    -- Utils
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'tpope/vim-commentary'
    use 'Raimondi/delimitMate'
    use 'tpope/vim-surround'
    use 'vim-utils/vim-man'
    use 'mbbill/undotree'
    use 'sudormrfbin/cheatsheet.nvim'

    -- Version Control
    if vim.fn.executable('git') == 1 then
        use 'tpope/vim-fugitive'
        use 'airblade/vim-gitgutter'
        use 'junegunn/gv.vim'
    end
end)
