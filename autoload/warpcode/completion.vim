function warpcode#completion#complete() abort
    if pumvisible()
        return "\<C-n>"
    endif

    if warpcode#util#prevChrIsSpace()
        return "\<TAB>"
    endif

    try
        return coc#refresh()
    catch /.*/
    endtry

    return "\<TAB>"
endfunction
