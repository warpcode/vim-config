function! warpcode#plugin#coc#loaded() abort
    return exists('g:did_coc_loaded')
endfunction

function! warpcode#plugin#coc#ready() abort
    if warpcode#plugin#coc#loaded() != 1
        return 0
    endif

    return coc#rpc#ready()
endfunction

function! warpcode#plugin#coc#runFormat() abort
    if warpcode#plugin#coc#ready() != 1
        return 0
    endif

    if CocHasProvider('format') == v:false
        return 0
    endif

    call CocAction('format')
    return 1
endfunction
