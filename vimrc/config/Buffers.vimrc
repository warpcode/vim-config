set autoread
set hidden
set splitright              " Splitting creates buffer to the right
set splitbelow
let no_buffers_menu=1

" Buffer nav
noremap <leader>bp :bp<CR>
noremap <leader>bn :bn<CR>
noremap <leader>bc :bd<CR>
noremap <leader>bq :bp <BAR> bd #<cr>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
