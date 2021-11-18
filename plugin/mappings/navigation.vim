" Buffers
nnoremap <expr> <leader>bb warpcode#navigation#buffers_cmd()
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>

" File Explorer
nnoremap <expr> <leader>t warpcode#navigation#file_explorer_cmd()
nnoremap <leader>nw :Lexplore<CR>

" File Finder
nnoremap <silent><expr> <leader>ff warpcode#navigation#find_files_cmd()
" command! -nargs=1 FindFile call warpcode#search#findFiles(<q-args>)

