if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal commentstring=\"\ %s

" Reload config
nnoremap <buffer> <leader><CR> :so %<CR>
