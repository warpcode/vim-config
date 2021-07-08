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

function warpcode#completion#trigger() abort
    try
        return coc#refresh()
    catch /.*/
    endtry

    return ""
endfunction

function warpcode#completion#select() abort
    if pumvisible()
        try
            " Make <CR> auto-select the first completion item
            return coc#_select_confirm()
        catch /.*/
        endtry
    endif

    return ""
endfunction

function warpcode#completion#iOnEnter() abort
    try
        " Notify coc.nvim to format on enter
        call coc#on_enter()
    catch /.*/
    endtry

    return ""
endfunction
