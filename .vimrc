" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.
" Run vim +PlugInstall +qall to install
set nocompatible               " Be iMproved

" Basic Config {{{
    " Abbreviations {{{
        " Common abbreviation for typos
        cnoreabbrev W! w!
        cnoreabbrev Q! q!
        cnoreabbrev Qall! qall!
        cnoreabbrev Wq wq
        cnoreabbrev Wa wa
        cnoreabbrev wQ wq
        cnoreabbrev WQ wq
        cnoreabbrev W w
        cnoreabbrev Q q
        cnoreabbrev Qall qall
    " }}}

    " Autocomplete {{{
        set wildmode=longest,list,full
        set wildmenu
        set completeopt=menu,menuone,preview
        " set complete-=i

        " Setup the ignore list
        set wildignore+=*.swp,tags                      " Ignore commong VIM files
        set wildignore+=*/tmp/*                         " Ignore temporary directories
        set wildignore+=*.png,*.jpg,*.jpeg,*.gif        " Ignore images
        set wildignore+=*.avi,*.mp4,*.mkv,*.mov         " Ignore videos
        set wildignore+=*.mp3,*.aac,*.m4a,*.mka,*.wav   " Ignore audio
        set wildignore+=*.zip,*.rar,*.7z,*.gz           " Ignore compressed archives
        set wildignore+=.DS_Store                       " Ignore MacOS DS_Store files
        set wildignore+=.git,.hg,.svn                   " Ignore version control directories
        set wildignore+=*.o,*.so                        " Ignore compiled objects (eg for C)
        set wildignore+=*.pyc,__pycache__               " Ignore common python objects
    " }}}

    " Backup {{{
        set backup
        set backupdir-=.
        set backupdir=.backup//,~/.backup//,/tmp//
        set backupskip=/tmp/*,/private/tmp/*
        set writebackup
    " }}}

    " Buffers {{{
        set autoread
        set hidden
        set splitright              " Splitting creates buffer to the right
        set splitbelow
        let no_buffers_menu=1

        " Buffer nav
        noremap <leader>bp :bp<CR>
        noremap <leader>bn :bn<CR>
        noremap <leader>bc :bd<CR>

        " Split
        noremap <Leader>h :<C-u>split<CR>
        noremap <Leader>v :<C-u>vsplit<CR>
    " }}}

    " Colours {{{
        syntax on
        set t_Co=256
        let g:solarized_termcolors=256

        if !exists('g:not_finish_vimplug')
            set background=dark
            " colorscheme molokai
        endif

        augroup vimrc-sync-fromstart
            autocmd!
            " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
            autocmd BufEnter * :syntax sync maxlines=200
        augroup END
    " }}}

    " Copy/Paste/Cut {{{
        if has('unnamedplus')
            set clipboard=unnamed,unnamedplus
        endif

    " Copy/paste/cut to system clipboard
        noremap YY "+y<CR>
        noremap <leader>p "+gP<CR>
        noremap XX "+x<CR>

        if has('macunix')
            " pbcopy for OSX copy/paste
            vmap <C-x> :!pbcopy<CR>
            vmap <C-c> :w !pbcopy<CR><CR>
        endif
    " }}}

    " Cursor {{{
        set cursorline              " Highlight the line the cursor is on

        augroup vimrc-remember-cursor-position
            autocmd!
            " Remember cursor position
            autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
        augroup END
    " }}}

    " Encoding {{{
        set encoding=utf-8
        set fileencoding=utf-8
        set fileencodings=utf-8
        set bomb
        "set binary
    " }}}

    " File Managers {{{
        " NETRW {{{
            let g:netrw_banner = 1
            let g:netrw_liststyle = 3
            let g:netrw_browsesplit = 4
            let g:netre_altv = 1
            let g:netrw_winsize = 25
            let g:netrw_list_hide = &wildignore
            " augroup ProjectDrawer
                " autocmd!
                " autocmd VimEnter * :Vexplore
            " augroup END
        " }}}
    " }}}

    " Indentation {{{
        set autoindent
        set smartindent
        set smarttab
        set tabstop=4
        set softtabstop=0
        set shiftwidth=4
        set expandtab
    " }}}

    " Leader {{{
        let mapleader=','
    " }}}

    " Misc {{{
        set fileformats=unix,dos,mac
        set backspace=indent,eol,start
    " }}}

    " Movement {{{
        " Preseve visual mode when indenting
        vmap < <gv
        vmap > >gv

        " highlight last inserted text
        nnoremap gV `[v`]

        " move vertically by visual line
        nnoremap j gj
        nnoremap k gk

        " Switching windows
        noremap <C-j> <C-w>j
        noremap <C-k> <C-w>k
        noremap <C-l> <C-w>l
        noremap <C-h> <C-w>h

        " Move visual block
        vnoremap J :m '>+1<CR>gv=gv
        vnoremap K :m '<-2<CR>gv=gv
    " }}}

    " Scrolling {{{
        set nowrap              " wrap overlong lines
        set scrolljump=1      " scroll one line at a time
        set scrolloff=8         "Start scrolling when we're 8 lines away from margins
        set sidescrolloff=15
        set sidescroll=1
    " }}}

    " Shell {{{
        if exists('$SHELL')
            set shell=$SHELL
        else
            set shell=/bin/sh
        endif

        if exists(':terminal')
            nnoremap <silent> <leader>sh :terminal<CR>
        endif
    " }}}

    " Status Bar {{{
        set laststatus=2
        " set statusline=[%n]\ %<%.99f\ %h%w%m%r%{CallFunction('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
        " set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
        " set statusline=%!MyStatusLine()
        function! MyStatusLine()
            let statusline = ""
            " Filename (F -> full, f -> relative)
            let statusline .= "%F %y"
            " Buffer flags
            let statusline .= "%( %h%1*%m%*%r%w%) "
            " File format and type
            let statusline .= "(%{&ff}%(\/%Y%))"
            " Left/right separator
            let statusline .= "%="
            " Line & column
            let statusline .= "(%l/%L, %c%V, %P) "
            " Character under cursor (decimal)
            " let statusline .= "dec:%03.3b "
            " Character under cursor (hexadecimal)
            " let statusline .= "hex:0x%02.2B "

            " Caps lock status display
            if exists('*CapsLockStatusline')
                let statusline .= call('CapsLockStatusline', [])
            endif

            " Git status
            if exists('*fugitive#statusline')
                let statusline .= call('fugitive#statusline', [])
            endif

            " Syntax check status
            if exists('*SyntasticStatuslineFlag')
                let statusline .= call('SyntasticStatuslineFlag', [])
            endif

            return statusline
        endfunction
    " }}}

    " Swap {{{
        set directory=.swp//,~/.swp//,/tmp//
        " set noswapfile
    " }}}

    " UI Config {{{
        " Set the window title
        set title
        set titleold="Terminal"
        set titlestring=%F          " Set terminal title to the name of the file

        set laststatus=2
        set lazyredraw
        set linebreak
        set ruler
        set showcmd
        set showmatch
        set showmode

        set number
        set norelativenumber

        set list
        if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
            let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
            let &fillchars = "vert:\u259a,fold:\u00b7"
        else
            set listchars=tab:>\ ,trail:-,extends:>,precedes:<
        endif

        set guifont=Monospace\ 10
        if has("gui_running")
            if has("gui_mac") || has("gui_macvim")
                set guifont=Menlo:h12
                set transparency=7
            endif
       endif

        " Disable visualbell
        set noerrorbells visualbell t_vb=
        if has('autocmd')
             autocmd GUIEnter * set visualbell t_vb=
        endif
    " }}}

    " Undo {{{
        set undodir=.undo//,~/.undo//,/tmp//
        set history=500
        set undolevels=1000
        if exists("&undofile")
            set undofile
        endif
    " }}}
" }}}
