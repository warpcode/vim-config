set autoread
set hidden
set splitright              " Splitting creates buffer to the right
set splitbelow
let no_buffers_menu=1

" Buffer nav
noremap <leader>bl :buffers<CR>
noremap <leader>bp :bp<CR>
noremap <leader>bn :bn<CR>
noremap <leader>bc :bd<CR>
noremap <leader>bq :bp <BAR> bd #<cr>

" Split
noremap <Leader>sh :<C-u>split<CR>
noremap <Leader>sv :<C-u>vsplit<CR>
