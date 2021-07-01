set autoread
set hidden
set splitright              " Splitting creates buffer to the right
set splitbelow
let no_buffers_menu=1

" Buffer nav
nnoremap <leader>bl :buffers<CR>:b<space>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>

" Split
nnoremap <Leader>sh :<C-u>split<CR>
nnoremap <Leader>sv :<C-u>vsplit<CR>
