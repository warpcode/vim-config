if !has('nvim')
    " Set the window title

    " Disable visualbell
    set noerrorbells visualbell t_vb=
    if has('autocmd')
        autocmd GUIEnter * set visualbell t_vb=
    endif
endif
