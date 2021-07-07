function warpcode#ft#all#formatGeneric() abort
    execute 'normal gg=G'
    return 1
endfunction


function! warpcode#ft#all#format(...) abort
    if warpcode#plugin#coc#ready() == 1
        if CocHasProvider('format') == v:true
            call CocAction('format')
            return 1
        endif
    endif

    if a:0 > 0
        " If we have an argument, check if we have a custom formatter
        try
            execute 'call warpcode#ft#'.a:1.'#format()'
            return 1
        catch /.*/
        endtry
    endif

    call warpcode#ft#all#formatGeneric()
    return 1
endfunction
