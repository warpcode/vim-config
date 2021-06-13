" disable the cursor line
set nocursorline

augroup WARPCODE_REMEMBER_CURSOR_POS
    autocmd!
    " Remember cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END