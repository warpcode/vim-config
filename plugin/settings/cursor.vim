" disable the cursor line
set nocursorline
set updatetime=1000

augroup WARPCODE_CURSOR
    autocmd!
    " Remember cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " On cursor hold, run the highlight function
    autocmd CursorHold * silent call warpcode#cursor#highlight()
augroup END
