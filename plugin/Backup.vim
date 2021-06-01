if !has('nvim')
    if isdirectory(vimhome . '/backup') == 0
        execute "silent !mkdir -p \"" .  vimhome . "/backup\" > /dev/null 2>&1"
    endif

    set backupdir-=.
    set backupdir+=.
    set backupdir-=~/
    set backupdir^=~/.vim/backup/
    set backupdir^=./.vim-backup/
    set backup
endif

