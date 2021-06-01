if !has('nvim')
    if isdirectory(vimhome . '/swap') == 0
        execute "silent !mkdir -p \"" .  vimhome . "/swap\" > /dev/null 2>&1"
    endif

    set directory=./.vim-swap//
    set directory+=~/.vim/swap//
    set directory+=~/tmp//
    set directory+=.
    " set noswapfile
endif
