
" Preseve visual mode when indenting
vmap < <gv
vmap > >gv

" highlight last inserted text
nnoremap gV `[v`]

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
