function! warpcode#buffers#show() abort
    if exists(':Buffers')
        return ":Buffers\<CR>"
    endif

    return ":buffers\<CR>:b\<space>"
endfunction

function! warpcode#buffers#showRun() abort
    execute warpcode#buffers#show()
endfunction
