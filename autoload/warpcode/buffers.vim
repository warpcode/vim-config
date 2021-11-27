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
