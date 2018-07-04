set nocursorline              " disable the cursor line

augroup vimrc-remember-cursor-position
    autocmd!
    " Remember cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
