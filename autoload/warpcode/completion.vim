function warpcode#completion#complete() abort
    if pumvisible()
        return "\<C-n>"
    endif

    if warpcode#util#prevChrIsSpace()
        return "\<TAB>"
    endif

    if warpcode#plugin#coc#loaded()
        return coc#refresh()
    endif

    return "\<TAB>"
endfunction
