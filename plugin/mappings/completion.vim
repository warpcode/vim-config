" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB> warpcode#completion#complete()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> warpcode#completion#trigger()
else
    inoremap <silent><expr> <c-@> warpcode#completion#trigger()
endif

" Take over <CR> for completion checking
" inoremap <silent><expr> <cr> pumvisible() ? warpcode#completion#select() : "\<C-g>u\<CR>\<C-r>=warpcode#completion#iOnEnter()\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? warpcode#completion#select() : "\<C-g>u\<CR>"
