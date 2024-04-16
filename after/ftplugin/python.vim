if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=8
setlocal colorcolumn=79
setlocal formatoptions+=croq
setlocal softtabstop=4
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
