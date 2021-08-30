" Shows trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" show indent guides
if has('nvim')
    Plug 'lukas-reineke/indent-blankline.nvim'
else
    Plug 'Yggdroot/indentLine'
endif

" Syntax Highlighting
" Plug 'sheerun/vim-polyglot'

if has('nvim')
    " Neovim Tree shitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
endif
