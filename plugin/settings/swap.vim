" Swap
" if isdirectory(vim_home . '/swap') == 0
"     execute "silent !mkdir -p \"" .  vim_home . "/swap\" > /dev/null 2>&1"
" endif

" set directory=./.vim-swap//
" set directory+=~/.vim/swap//
" set directory+=~/tmp//
" set directory+=.
set noswapfile
