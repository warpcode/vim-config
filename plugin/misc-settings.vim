" Disable the annoying bongs
set noerrorbells

" Set behaviour of backpace
set backspace=indent,eol,start

" Set default encoding
set encoding=utf-8

" Backup
" if isdirectory(vim_home . '/backup') == 0
"     execute "silent !mkdir -p \"" .  vim_home . "/backup\" > /dev/null 2>&1"
" endif

" set backupdir-=.
" set backupdir+=.
" set backupdir-=~/
" set backupdir^=~/.vim/backup/
" set backupdir^=./.vim-backup/
" set backup
set nobackup

" Swap
" if isdirectory(vim_home . '/swap') == 0
"     execute "silent !mkdir -p \"" .  vim_home . "/swap\" > /dev/null 2>&1"
" endif

" set directory=./.vim-swap//
" set directory+=~/.vim/swap//
" set directory+=~/tmp//
" set directory+=.
set noswapfile

" Reload config
nnoremap <leader><CR> :so $MYVIMRC<CR>
