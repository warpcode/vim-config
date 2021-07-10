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
