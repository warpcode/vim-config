if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

autocmd filetype netrw nmap <buffer> <c-a> <cr>:wincmd W<cr>
