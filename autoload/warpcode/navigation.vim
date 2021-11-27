

function! warpcode#navigation#file_explorer() abort
    if warpcode#packages#is_module_loaded('nerdtree')
        NERDTreeToggle
        return
    endif

    Lexplore
endfunction

function! warpcode#navigation#find_files()
    if warpcode#packages#is_module_loaded('telescope.nvim')
        lua require('warpcode.packages.telescope').project_files()
        return
    endif

    if warpcode#packages#is_module_loaded('fzf.vim')
        FZF
        return
    endif

    call inputsave()
    let content = input('Find: ')
    call inputrestore()
    exe "find " . content
endfunction

" function! warpcode#navigation#find_files(filename)
"     let error_file=tempname()
"     silent! exe 'silent !find .
"                 \| grep -Pis "'.a:filename.'" -- -
"                 \| xargs file
"                 \| sed "s/:/:1:/" > '.error_file
"                 \| redraw!
"     setl errorformat=%f:%l:%m
"     exe "cfile! ". error_file
"     copen
"     call delete(error_file)
" endfun
