if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

setlocal nonumber

nmap <buffer> <c-a> <cr>:wincmd W<cr>
