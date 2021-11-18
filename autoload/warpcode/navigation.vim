
function! warpcode#navigation#buffers() abort
    execute warpcode#navigation#buffers_cmd()
endfunction

function! warpcode#navigation#buffers_cmd() abort
    if exists(':Telescope')
        return ":lua require('telescope.builtin').buffers()\<CR>"
    endif

    if exists(':Buffers')
        return ":Buffers\<CR>"
    endif

    return ":buffers\<CR>:b\<space>"
endfunction

function! warpcode#navigation#file_explorer() abort
    execute warpcode#navigation#file_explorer_cmd()
endfunction

function! warpcode#navigation#file_explorer_cmd() abort
    if warpcode#packages#is_module_loaded('nerdtree')
        return ":NERDTreeToggle\<CR>"
    endif

    return ":Lexplore\<CR>"
endfunction

function! warpcode#navigation#find_files()
    execute warpcode#navigation#find_files_cmd()
endfunction

function! warpcode#navigation#find_files_cmd()
    if exists(':Telescope')
        return ":Telescope git_files\<CR>"
    endif

    if exists(':FZF')
        return ":FZF\<CR>"
    endif

    return ":find "
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
