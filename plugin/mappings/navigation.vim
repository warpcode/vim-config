" Buffers
nnoremap <leader>bb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>bq :bp <BAR> bd #<cr>

" File Explorer
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>nw :Lexplore<CR>

" File Finder
nnoremap <leader>ff :lua require('warpcode.plugins.telescope').project_files()<CR>
" command! -nargs=1 FindFile call warpcode#search#findFiles(<q-args>)

" move vertically by visual line (ie will go into a wrapped line that's
" visually on the next line)
nnoremap j gj
nnoremap k gk

