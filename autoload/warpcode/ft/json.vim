function warpcode#ft#json#format() abort
    if warpcode#plugin#coc#runFormat()
        return 1
    endif

    if executable('python')
        silent! %!python -m json.tool
        return 1
    endif

    return 0
endfunction
