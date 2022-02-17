function! warpcode#ft#all#format_generic() abort
    call warpcode#util#run_command_preserve_cursor('normal gg=G')
    return 1
endfunction

function! warpcode#ft#all#format(...) abort
    if a:0 > 0
        " If we have an argument, check if we have a custom formatter
        try
            execute 'let didFormat =  warpcode#ft#'.a:1.'#format()'
            echo didFormat
            if didFormat == 1
                return 1
            endif
        catch /.*/
        endtry
    endif

    if len(&filetype) && (a:0 == 0 || a:1 != &filetype)
        " If we have an argument, check if we have a custom formatter
        try
            execute 'let didFormat =  warpcode#ft#'.&filetype.'#format()'
            echo didFormat
            if didFormat == 1
                return 1
            endif
        catch /.*/
        endtry
    endif

    call warpcode#ft#all#format_generic()
    return 1
endfunction
