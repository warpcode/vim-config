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
                config = function()
                    require('warpcode.plugins.cmp_tabnine')
                end,
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
        config = function()
            vim.api.nvim_exec([[
                let g:NERDTreeChDirMode=2
                let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
                let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
                let g:NERDTreeShowBookmarks=1
                let g:nerdtree_tabs_focus_on_files=1
                let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
                let g:NERDTreeWinSize = 40
                let g:NERDTreeShowHidden=1
                " Show ignored icon next to ignored files. This can be intensive with a lot of files
                let g:NERDTreeGitStatusShowIgnored = 1
                " List of icons for file statuses
                let g:NERDTreeGitStatusIndicatorMapCustom = {
                            \ "Modified"  : "✹",
                            \ "Staged"    : "✚",
                            \ "Untracked" : "✭",
                            \ "Renamed"   : "➜",
                            \ "Unmerged"  : "═",
                            \ "Deleted"   : "✖",
                            \ "Dirty"     : "✗",
                            \ "Clean"     : "✔︎",
                            \ 'Ignored'   : '☒',
                            \ "Unknown"   : "?"
                            \ }

                " NERDTree - Quit vim when all other windows have been closed.
                au BufEnter *
                            \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
                            \ b:NERDTreeType == "primary") |
                            \   q |
                            \ endif
            ]], false)
        end,
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
        config = function()
            vim.api.nvim_exec([[
                " General Options
                " let g:airline_theme = 'gruvbox'
                let g:hybrid_custom_term_colors = 1
                let g:airline_exclude_preview = 0
                let g:airline_detect_modified=1
                let g:airline_focuslost_inactive = 1
                let g:airline_skip_empty_sections = 1
                let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
                let g:airline_stl_path_style = 'short'

                " Symbols
                if !exists('g:airline_symbols')
                    let g:airline_symbols = {}
                endif

                let g:airline_left_sep = '▶'
                let g:airline_left_alt_sep = '»'
                let g:airline_right_sep = '◀'
                let g:airline_right_alt_sep = '«'
                let g:airline_symbols.branch = '⎇'
                let g:airline_symbols.colnr = ' ㏇:'
                let g:airline_symbols.crypt = '🔒'
                let g:airline_symbols.dirty='⚡'
                let g:airline_symbols.linenr = '㏑'
                let g:airline_symbols.maxlinenr = '☰ '
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.paste = '∥'
                let g:airline_symbols.readonly = '⭤'
                let g:airline_symbols.spell = 'Ꞩ'
                let g:airline_symbols.whitespace = 'Ξ'

                " File type overrides
                let g:airline_filetype_overrides = {
                \ 'coc-explorer':  [ 'CoC Explorer', '' ],
                \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
                \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
                \ 'gundo': [ 'Gundo', '' ],
                \ 'help':  [ 'Help', '%f' ],
                \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
                \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
                \ 'startify': [ 'startify', '' ],
                \ 'vim-plug': [ 'Plugins', '' ],
                \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
                \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
                \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
                \ }
            ]], false)
        end,
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
    use {
        'Yggdroot/indentLine',
        config = function()
            vim.api.nvim_exec([[
                let g:indentLine_char_list = ['|', '¦', '┆', '┊']
                let g:indentLine_enabled = 1
                let g:indentLine_concealcursor = 'inc'
                let g:indentLine_conceallevel = 0
                let g:indentLine_faster = 1
            ]], false)
        end,
    }
    use 'ryanoasis/vim-devicons'

    -- Utils
    use 'nvim-lua/plenary.nvim'
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
