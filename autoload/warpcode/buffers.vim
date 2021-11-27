function! warpcode#buffers#selection() abort
    if warpcode#packages#is_module_loaded('telescope.nvim')
        lua require('telescope.builtin').buffers()
        return
    endif

    if warpcode#packages#is_module_loaded('fzf.vim')
        Buffers
        return
    endif

    buffers
    call inputsave()
    let content = input('Buffer: ')
    call inputrestore()
    exe "b " . content
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
