let g:coc_data_home = g:vim_home . '/coc/'

" let g:coc_global_extensions = [
"     \ 'coc-css',
"     \ 'coc-json',
"     \ 'coc-git',
"     \ 'coc-html',
"     \ 'coc-phpls',
"     \ 'coc-prettier',
"     \ 'coc-snippets',
"     \ 'coc-texlab',
"     \ 'coc-sh',
"     \ 'coc-vimlsp'
"     \ ]


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ warpcode#ui#prevChrIsSpace() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')
