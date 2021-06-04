if has('nvim')
    " LSP plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'simrat39/symbols-outline.nvim'
else
    Plug 'ervandew/supertab'
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer' }
endif

if has('nvim') || v:version >= 704
    Plug 'SirVer/ultisnips'
endif
" Snippet Collections
Plug 'honza/vim-snippets'
