syntax on
set t_Co=256
set background=dark
set termguicolors

if warpcode#has#colorscheme('gruvbox')
    " If gruvbox is installed, use that
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_invert_selection = '0'

    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    colorscheme gruvbox
else
    " Default to whatever theme is in our default file
    colorscheme warpcode-default
endif

" highlight ColorColumn ctermbg=0 guibg=grey
hi SignColumn guibg=none
" hi CursorLineNR guibg=None
" highlight Normal guibg=none
" " highlight LineNr guifg=#ff8659
" " highlight LineNr guifg=#aed75f
" highlight LineNr guifg=#5eacd3
" highlight netrwDir guifg=#5eacd3
" highlight qfFileName guifg=#aed75f
" hi TelescopeBorder guifg=#5eacd

if !has('nvim')
    augroup WARPCODE_COLOURS
        autocmd!
        " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
        autocmd BufEnter * :syntax sync maxlines=200
    augroup END
endif
