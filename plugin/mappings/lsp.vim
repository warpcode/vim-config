
" Override K to show documentation in preview window.
nnoremap <silent> K :call warpcode#lsp#hover_documentation()<CR>

nmap <silent> [d :call warpcode#lsp#diagnostic_prev()<CR>
nmap <silent> ]d :call warpcode#lsp#diagnostic_next()<CR>

" " Symbol renaming.
nmap <leader>lrn :call warpcode#lsp#rename()<CR>

