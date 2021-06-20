function! warpcode#fs#detectFileInParents(filename) abort
    " We need to search for the first instance of the file working up the tree from our file
    let current_dir = expand('%:p:h')
    let fullpath = fnamemodify(current_dir, ':p') . a:filename
    while !filereadable(fullpath)
        let current_dir_prev = current_dir
        let current_dir = fnamemodify(current_dir, ':h')

        if current_dir_prev == current_dir
            break
        endif

        let fullpath = fnamemodify(current_dir, ':p') . a:filename
    endwhile


    if filereadable(fullpath)
        return fullpath
    endif

    return ''
endfunction
