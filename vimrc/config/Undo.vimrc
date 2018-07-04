set history=500
set undolevels=1000

" This is only present in 7.3+
if exists('+undofile')
    if isdirectory(vimhome . '/undo') == 0
        execute "silent !mkdir -p \"" .  vimhome . "/undo\" > /dev/null 2>&1"
    endif

    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif
