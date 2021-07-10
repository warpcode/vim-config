set autoread
set hidden
set splitright              " Splitting creates buffer to the right
set splitbelow
let no_buffers_menu=1

" Buffer nav
nnoremap <expr> <leader>bb warpcode#buffers#show()
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>
