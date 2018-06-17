" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.
" Run vim +PlugInstall +qall to install

" Required {{{
    " Be iMproved
    set nocompatible
    filetype off
    let mapleader=','

    if has('nvim')
        let vimhome=expand('~/.config/nvim')
    else
        let vimhome=expand('~/.vim')
    endif
" }}}

" Vim Plug Setup {{{
    let vimplug_exists=expand(vimhome . '/autoload/plug.vim')

    if !filereadable(vimplug_exists)
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            execute "q!"
        endif
        echo "Installing Vim-Plug to ".vimplug_exists."..."
        echo ""

        execute "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        let g:not_finish_vimplug = "yes"

        autocmd VimEnter * PlugInstall
    endif

    if isdirectory(vimhome . '/plugged') == 0
        execute "silent !mkdir -p \"" .  vimhome . "/plugged\" > /dev/null 2>&1"
    endif

    call plug#begin(expand(vimhome . '/plugged'))
" }}}

" Packages {{{
    " Autocomplete {{{
        " Snippet Collections {{{
            Plug 'honza/vim-snippets'
        " }}}

        " Ultisnps {{{
            if v:version >= 704
                Plug 'SirVer/ultisnips'
            endif
        " }}}
    " }}}

    " File Managers/Finders {{{
        " FZF {{{
            if isdirectory('/usr/local/opt/fzf')
                Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
            else
                Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
                Plug 'junegunn/fzf.vim'
            endif
        " }}}

        " NERDTree {{{
            Plug 'scrooloose/nerdtree'
            Plug 'jistr/vim-nerdtree-tabs'
            Plug 'Xuyuanp/nerdtree-git-plugin'
        " }}}
    " }}}

    " File Types {{{
        " All {{{
            " Comments {{{
                Plug 'tpope/vim-commentary'               " Auto comment out code
            " }}}

            " Syntax Checking {{{
                Plug 'scrooloose/syntastic'
            " }}}

            " Syntax Highlighting {{{
                Plug 'sheerun/vim-polyglot'
            " }}}
        " }}}
    " }}}

    " Version Control {{{
        " Git {{{
            Plug 'tpope/vim-fugitive' " Git helpers
            Plug 'airblade/vim-gitgutter' " Shows git diff in the gutter
        " }}}
    " }}}

    " UI {{{
        " Colours {{{
            Plug 'vim-scripts/CSApprox' " Enabled gui colourschemes to run in terminal
            Plug 'flazz/vim-colorschemes' " Huge collection of colour schemes
        " }}}

        " Status Bar {{{
            " Airline {{{
                Plug 'vim-airline/vim-airline'
                Plug 'vim-airline/vim-airline-themes'
            " }}}
        " }}}
    " }}}
" }}}

" Vim Plug Setup Complete {{{
    call plug#end()
    filetype plugin indent on
" }}}

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
        set completeopt+=noselect
        set completeopt+=noinsert
        " set complete-=i

        " Setup the ignore list
        set wildignore+=*.swp,tags                      " Ignore common VIM files
        set wildignore+=*/tmp/*                         " Ignore temporary directories
        set wildignore+=*.png,*.jpg,*.jpeg,*.gif        " Ignore images
        set wildignore+=*.avi,*.mp4,*.mkv,*.mov         " Ignore videos
        set wildignore+=*.mp3,*.aac,*.m4a,*.mka,*.wav   " Ignore audio
        set wildignore+=*.zip,*.rar,*.7z,*.gz           " Ignore compressed archives
        set wildignore+=.DS_Store                       " Ignore MacOS DS_Store files
        set wildignore+=.git,.hg,.svn                   " Ignore version control directories
        set wildignore+=*.o,*.so                        " Ignore compiled objects (eg for C)
        set wildignore+=*.pyc,__pycache__               " Ignore common python objects


        " better key bindings for UltiSnipsExpandTrigger
        let g:UltiSnipsExpandTrigger = "<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " }}}

    " Backup {{{
        if isdirectory(vimhome . '/backup') == 0
            execute "silent !mkdir -p \"" .  vimhome . "/backup\" > /dev/null 2>&1"
        endif

        set backupdir-=.
        set backupdir+=.
        set backupdir-=~/
        set backupdir^=~/.vim/backup/
        set backupdir^=./.vim-backup/
        set backup
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

    " File Managers/Finders {{{
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

        " FZF {{{
            let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

            " The Silver Searcher
            if executable('ag')
                let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
            endif

            " ripgrep
            if executable('rg')
                let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
                command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
            endif

            "cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
            nnoremap <silent> <leader>f :FZF -m<CR>
            noremap <silent> <leader>b :Buffers<CR>"
        " }}}

        " NERDTree {{{
            let g:NERDTreeChDirMode=2
            let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
            let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
            let g:NERDTreeShowBookmarks=1
            let g:nerdtree_tabs_focus_on_files=1
            let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
            let g:NERDTreeWinSize = 40
            let g:NERDTreeShowHidden=1
            " Show ignored icon next to ignored files. This can be intensive with a lot of files
            let g:NERDTreeShowIgnoredStatus = 1
            " List of icons for file statuses
            let g:NERDTreeIndicatorMapCustom = {
                        \ "Modified"  : "✹",
                        \ "Staged"    : "✚",
                        \ "Untracked" : "✭",
                        \ "Renamed"   : "➜",
                        \ "Unmerged"  : "═",
                        \ "Deleted"   : "✖",
                        \ "Dirty"     : "✗",
                        \ "Clean"     : "✔︎",
                        \ 'Ignored'   : '☒',
                        \ "Unknown"   : "?"
                        \ }

            " NERDTree - Quit vim when all other windows have been closed.
            au BufEnter *
              \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
              \ b:NERDTreeType == "primary") |
              \   q |
              \ endif

            " Toggle NERDTREE
            nnoremap <leader>t :NERDTreeToggle<CR>

            "" Show hidden files
            "autocmd StdinReadPre * let s:std_in=1
            "" When given a directory, open nerdtree and empty buffer. Focus on empty buffer
            "autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
            "" When given a file, open nerdtree and focus on file buffer
            "autocmd VimEnter * if argc() == 1 && !isdirectory(argv()[0]) && !exists("s:std_in") | NERDTree | wincmd p | endif
            "" When args are empty, open nerdtree and empty buffer. Focus on Nerdtree
            "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        " }}}
    " }}}

    " File Types {{{
        " All {{{
            let g:polyglot_disabled = ['elm', 'python']

            let g:syntastic_always_populate_loc_list=1
            let g:syntastic_error_symbol='✗'
            let g:syntastic_warning_symbol='⚠'
            let g:syntastic_style_error_symbol = '✗'
            let g:syntastic_style_warning_symbol = '⚠'
            let g:syntastic_auto_loc_list=1
            let g:syntastic_aggregate_errors = 1
            let g:syntastic_check_on_open = 1
            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
        " }}}

        " Go {{{
            let g:syntastic_go_checkers = ['golint', 'govet']
        " }}}

        " Ocaml {{{
            " let g:syntastic_ocaml_checkers = ['merlin']
        " }}}

        " PHP {{{
            " let g:syntastic_phpcs_disable = 1
            " let g:syntastic_phpmd_disable = 1
            " let g:syntastic_php_checkers = ['php', 'phpcs']
            let g:syntastic_php_phpcs_args = '--standard=PSR2 -n'
        " }}}

        " Python {{{
            let g:syntastic_python_checkers=['python', 'flake8']
        " }}}
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

    " Swap {{{
        if isdirectory(vimhome . '/swap') == 0
            execute "silent !mkdir -p \"" .  vimhome . "/swap\" > /dev/null 2>&1"
        endif

        set directory=./.vim-swap//
        set directory+=~/.vim/swap//
        set directory+=~/tmp//
        set directory+=.
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

        set guifont=Monospace\ 9
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


        " Colours {{{
            syntax on
            set t_Co=256
            let g:solarized_termcolors=256

            if !exists('g:not_finish_vimplug')
                set background=dark
                colorscheme Tomorrow-Night
            endif

            augroup vimrc-sync-fromstart
                autocmd!
                " The PC is fast enough, do syntax highlight syncing from start unless 200 lines
                autocmd BufEnter * :syntax sync maxlines=200
            augroup END
        " }}}

        " Status Bar {{{
            let g:airline_theme = 'tomorrow'
            let g:airline#extensions#syntastic#enabled = 1
            let g:airline#extensions#branch#enabled = 1
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tagbar#enabled = 1
            let g:airline#extensions#virtualenv#enabled = 1
            let g:airline_skip_empty_sections = 1
            " let g:airline_powerline_fonts = 1
            let g:hybrid_custom_term_colors = 1


            if !exists('g:airline_symbols')
                let g:airline_symbols = {}
            endif

            if !exists('g:airline_powerline_fonts')
                let g:airline#extensions#tabline#left_sep = ' '
                let g:airline#extensions#tabline#left_alt_sep = '|'
                let g:airline_left_sep          = '▶'
                let g:airline_left_alt_sep      = '»'
                let g:airline_right_sep         = '◀'
                let g:airline_right_alt_sep     = '«'
                let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
                let g:airline#extensions#readonly#symbol   = '⊘'
                let g:airline#extensions#linecolumn#prefix = '¶'
                let g:airline#extensions#paste#symbol      = 'ρ'
                let g:airline_symbols.linenr    = '␊'
                let g:airline_symbols.branch    = '⎇'
                let g:airline_symbols.paste     = 'ρ'
                let g:airline_symbols.paste     = 'Þ'
                let g:airline_symbols.paste     = '∥'
                let g:airline_symbols.whitespace = 'Ξ'
            else
                let g:airline#extensions#tabline#left_sep = ''
                let g:airline#extensions#tabline#left_alt_sep = ''

                " powerline symbols
                let g:airline_left_sep = ''
                let g:airline_left_alt_sep = ''
                let g:airline_right_sep = ''
                let g:airline_right_alt_sep = ''
                let g:airline_symbols.branch = ''
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.linenr = ''
            endif
        " }}}
    " }}}

    " Undo {{{
        set history=500
        set undolevels=1000
        " This is only present in 7.3+
        if exists('+undofile')
            if isdirectory(vimhome . '/undo') == 0
                execute "silent !mkdir -p \"" .  vimhome . "/undo\" > /dev/null 2>&1"
            endif

            set undodir=./.vim-undo//
            set undodir+=~/.vim/undo//
            set undofile
        endif
    " }}}

    " Whitespace & Formatting {{{
        " Indentation {{{
            set autoindent
            set smartindent
            set smarttab
            set tabstop=4
            set softtabstop=0
            set shiftwidth=4
            set expandtab
        " }}}
    " }}}
" }}}
