if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

setlocal commentstring=\"\ %s

" Reload config
nnoremap <buffer> <leader><CR> :so %<CR>
