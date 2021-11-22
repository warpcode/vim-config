" Resize verticle pane split incrementally
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Maximise verticle split
nnoremap <Leader>rp :resize 100<CR>

" Switching windows
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-h> <C-w>h
noremap <A-w> <C-w>w

" highlight last inserted text
nnoremap gV `[v`]

" Move visual block
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv
inoremap <c-j> <esc>:m .+1<CR>==gi
inoremap <c-k> <esc>:m .-2<CR>==gi
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
