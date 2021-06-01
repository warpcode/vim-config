if !has('nvim')
    set guifont=Monospace\ 9
    if has("gui_running")
        if has("gui_mac") || has("gui_macvim")
            set guifont=Menlo:h12
            set transparency=7
        endif
    endif
endif
