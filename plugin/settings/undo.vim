set history=500
set undolevels=1000

" This is only present in 7.3+
if exists('+undofile')
    let target_path = expand(g:vim_home . '/undo')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
