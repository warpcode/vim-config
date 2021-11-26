
" Override K to show documentation in preview window.
nnoremap <silent> K :call warpcode#lsp#hover_documentation()<CR>

" " Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g :call warpcode#lsp#diagnostic_prev()<CR>
nmap <silent> ]g :call warpcode#lsp#diagnostic_next()<CR>

" " Symbol renaming.
nmap <leader>lrn <Plug>(coc-rename)

