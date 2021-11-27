function! warpcode#buffers#selection() abort
    execute warpcode#buffers#selection_cmd()
endfunction

function! warpcode#buffers#selection_cmd() abort
    if warpcode#packages#is_module_loaded('telescope.nvim')
        return ":lua require('telescope.builtin').buffers()\<CR>"
    endif

    if warpcode#packages#is_module_loaded('fzf.vim')
        return ":Buffers\<CR>"
    endif

    return ":buffers\<CR>:b\<space>"
endfunction

function! warpcode#buffers#get_all_buffer_ids()
    return map(copy(getbufinfo()), 'v:val.bufnr')
endfunction

function! warpcode#buffers#get_listed_buffers()
    return filter(copy(getbufinfo()), 'v:val.listed')
endfunction

function! warpcode#buffers#get_listed_buffer_ids()
    return map(warpcode#buffers#get_listed_buffers(), 'v:val.bufnr')
endfunction
