" Shows trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" show indent guides
Plug 'Yggdroot/indentLine'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

if has('nvim')
    " Neovim Tree shitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
endif
