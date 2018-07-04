
syntax on
set t_Co=256
let g:solarized_termcolors=256

if !exists('g:not_finish_vimplug')
    set background=dark
    colorscheme Tomorrow-Night
endif

augroup VimrcColours
    autocmd!
    " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
    autocmd BufEnter * :syntax sync maxlines=200
augroup END
