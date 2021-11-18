function! warpcode#search#find_files_show()
    if exists(':Telescope')
        return ":Telescope git_files\<CR>"
    endif

    if exists(':FZF')
        return ":FZF\<CR>"
    endif

    return ":find "
endfunction

function! warpcode#search#find_files_show_run()
    execute warpcode#search#find_files_show()
endfunction

function! warpcode#search#find_files(filename)
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
