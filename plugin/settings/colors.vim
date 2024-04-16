syntax on
set t_Co=256
set background=dark
set termguicolors

" " Default to whatever theme is in our default file
colorscheme warpcode-default

if has("nvim")
    hi SignColumn guibg=none
endif

if !has('nvim')
    augroup WARPCODE_COLOURS
        autocmd!
        " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
        autocmd BufEnter * :syntax sync maxlines=200
    augroup END
endif
