-- Get the folder where this init.lua lives
-- local base_dir = (function()
--     local init_path = debug.getinfo(1, "S").source
--     return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
-- end)()


vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.vim_home = vim.fn.stdpath('config')
vim.g.vim_source = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.stdpath('config') .. '/init.lua'), ':h')

-- Add the config to the rtp
-- This for some reason double loads the config
-- vim.cmd [[ packadd vim-config ]]
if not vim.tbl_contains(vim.opt.rtp:get(), vim.g.vim_source) then
    vim.opt.rtp:prepend(vim.g.vim_source)
    vim.opt.rtp:append(vim.g.vim_source .. '/after')
end

-- Load in plugins if available
pcall(function()
    vim.cmd [[ packadd packer.nvim ]]
    require 'packer'.init {
        display = {
            open_fn = function()
                return require "packer.util".float { border = 'rounded' }
            end,
        }
    }

    return require 'packer'.startup(function(use)
        -- Allow packer to manage itself
        use 'wbthomason/packer.nvim'

        -- Dependencies
        use {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-lua/popup.nvim' },
            { "williamboman/mason.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        }

        -- Autocompletion
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-calc' },
                { 'hrsh7th/cmp-cmdline' },
                { 'hrsh7th/cmp-emoji' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },
                { 'hrsh7th/cmp-omni' },
                { 'hrsh7th/cmp-path' },
                { 'tzachar/cmp-tabnine',     run = './install.sh', },
                { 'ray-x/cmp-treesitter' },
            }
        }

        -- DAP
        use {
            { 'mfussenegger/nvim-dap' },
            { 'rcarriga/nvim-dap-ui' },
            { 'theHamsta/nvim-dap-virtual-text' },
        }

        -- File Browser
        use {
            { 'scrooloose/nerdtree' },
            { 'Xuyuanp/nerdtree-git-plugin' },
            { 'jistr/vim-nerdtree-tabs' },
        }

        -- Git
        use {
            { 'tpope/vim-fugitive' },
            { 'airblade/vim-gitgutter' },
            { 'junegunn/gv.vim' }, -- Git commit explorer/viewer
            { 'lewis6991/gitsigns.nvim' }
        }

        -- LSP
        use {
            { "neovim/nvim-lspconfig" },
            { "onsails/lspkind-nvim" },
            { "glepnir/lspsaga.nvim" },
            { "ray-x/lsp_signature.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
        }

        -- Snippets
        use {
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'honza/vim-snippets' },
        }

        -- Telescope
        use {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
            { 'nvim-telescope/telescope-dap.nvim' },
        }

        -- Treesitter
        use {
            { 'nvim-treesitter/nvim-treesitter' },
            { 'nvim-treesitter/playground' },
            -- {'p00f/nvim-ts-rainbow'},
        }

        -- UI
        use 'lukas-reineke/indent-blankline.nvim'
        use {
            -- Fonts
            { 'ryanoasis/vim-devicons' },
            { 'nvim-tree/nvim-web-devicons' },

            -- Log
            { 'rcarriga/nvim-notify' }, -- Override notify method

            -- Status line
            { 'vim-airline/vim-airline' },
            { 'vim-airline/vim-airline-themes' },

            -- Themes
            { 'RRethy/nvim-base16' },
        }

        -- Utilities
        use 'tpope/vim-abolish'
        use 'sudormrfbin/cheatsheet.nvim'
        use 'tpope/vim-surround'
        use 'bronson/vim-trailing-whitespace'
        use 'vim-utils/vim-man'
        -- use 'Raimondi/delimitMate'
        use 'numToStr/Comment.nvim' -- better than 'tpope/vim-commentary'
        use 'mbbill/undotree'
        use 'simrat39/symbols-outline.nvim'
    end)
end)

require('warpcode').setup()
