if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

nmap <buffer> <c-a> <cr>:wincmd W<cr>
