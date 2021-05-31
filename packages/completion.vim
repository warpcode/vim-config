if has('nvim')
    Plug 'SirVer/ultisnips'
else
    Plug 'ervandew/supertab'
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer' }
    " Ultisnps
    if v:version >= 704
        Plug 'SirVer/ultisnips'
    endif

endif

" Snippet Collections
Plug 'honza/vim-snippets'
