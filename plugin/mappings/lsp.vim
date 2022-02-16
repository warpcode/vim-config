
" Override K to show documentation in preview window.
nnoremap <expr> K   index(['vim','help'], &filetype) >= 0 ?
                    \ ":execute 'h ' . expand('<cword>')<CR>" :
                    \ warpcode#plugin#coc#ready() && CocHasProvider('doHover') == v:true ?
                        \ CocActionAsync('doHover') :
                        \ ":execute '!' . &keywordprg . ' ' . expand('<cword>')<CR>"


" Symbol renaming.
nmap <expr> <leader>lrn warpcode#plugin#coc#ready() ? ':exe "norm \<Plug>(coc-rename)"<CR>' : ""

