function! warpcode#search#findFilesShow()
    if exists(':FZF')
        return ":FZF\<CR>"
    endif

    return ":find "
endfunction

function! warpcode#search#findFilesShowRun()
    execute warpcode#search#findFilesShow()
endfunction

function! warpcode#search#findFiles(filename)
    let error_file=tempname()
    silent! exe 'silent !find .
                \| grep -Pis "'.a:filename.'" -- -
                \| xargs file
                \| sed "s/:/:1:/" > '.error_file
                \| redraw!
    setl errorformat=%f:%l:%m
    exe "cfile! ". error_file
    copen
    call delete(error_file)
endfun
