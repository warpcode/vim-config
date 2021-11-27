" Buffers
nnoremap <leader>bb :call warpcode#buffers#selection()<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>

" File Explorer
nnoremap <leader>t :call warpcode#navigation#file_explorer()<CR>
nnoremap <leader>nw :Lexplore<CR>

" File Finder
nnoremap <leader>ff :call warpcode#navigation#find_files()<CR>
" command! -nargs=1 FindFile call warpcode#search#findFiles(<q-args>)

" move vertically by visual line (ie will go into a wrapped line that's
" visually on the next line)
nnoremap j gj
nnoremap k gk

