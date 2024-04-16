if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

" Add $ as part of the keyword search
setlocal iskeyword+=$

" Change the default comment string
setlocal commentstring=//\ %s

" Polyglot settings
let php_sql_query = 1
let php_html_in_strings = 1

" autocmd BufEnter * EnableBlameLine

"  " autoclose of delimiter
" autocmd BufEnter,BufNewFile,BufRead *.php call s:FTbtm()
" function! s:FTbtm()
"     echo "ISPHP"
" endfunction
"

" command! -nargs=0 Format :call warpcode#ft#all#format('php')
