function! warpcode#windows#loclist_toggle()
    if warpcode#windows#loclist_visible()
        lclose
    else
        lopen
    endif
endfunction

function! warpcode#windows#loclist_visible()
    return get(getloclist(0, {'winid':0}), 'winid', 0) > 0
endfunction

function! warpcode#windows#quickfix_toggle()
    if warpcode#windows#quickfix_visible()
        cclose
    else
        copen
    endif
endfunction

function! warpcode#windows#quickfix_visible()
    return get(getqflist({'winid':0}), 'winid', 0) > 0
endfunction
