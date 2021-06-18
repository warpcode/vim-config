if has('unnamedplus')
    " Ensure we can access the system clipboard at the +/* register
    set clipboard^=unnamed,unnamedplus
endif

" When pasting, send the highlighted text to a black hole register
" This stops the replaced text from going into the normal clipboard registers
vnoremap <leader>p "_dP

" Delete text and send to the black hole register
" This stops the deleted text going into the normal clipboard registers
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Yank entire buffer to system clipboard
" And then return to the last cursor position
nnoremap <leader>Y gg"+yG<C-o>
