" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.
" Run vim +PlugInstall +qall to install

" Vim Plug Setup {{{
    if has('vim_starting')
        set nocompatible               " Be iMproved
    endif

    if has('nvim')
        let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
    else
        let vimplug_exists=expand('~/.vim/autoload/plug.vim')
    endif

    if !filereadable(vimplug_exists)
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            execute "q!"
        endif
        echo "Installing Vim-Plug to ".vimplug_exists."..."
        echo ""

        if has('nvim')
            silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
            silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        endif
        let g:not_finish_vimplug = "yes"

        autocmd VimEnter * PlugInstall
    endif

    if has('nvim')
        call plug#begin(expand('~/.config/nvim/plugged'))
    else
        call plug#begin(expand('~/.vim/plugged'))
    endif
" }}}

" Packages {{{
    " Autocomplete {{{
        " Deoplete {{{
            if has('nvim')
                Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
            else
                Plug 'Shougo/deoplete.nvim'
                Plug 'roxma/nvim-yarp'
                Plug 'roxma/vim-hug-neovim-rpc'
            endif
        " }}}
    " }}}

    " Colours {{{
        " Plug 'vim-scripts/CSApprox'         " Enabled gui colourschemes to run in terminal
        Plug 'flazz/vim-colorschemes'       " Huge collection of colour schemes
    " }}}

    " Cursor {{{
        Plug 'terryma/vim-multiple-cursors'	    " Sublime like multi select
    " }}}

    " File Managers {{{
        " NERDTree {{{
            Plug 'scrooloose/nerdtree'		        " File browser
            Plug 'jistr/vim-nerdtree-tabs'		    " Tab support for nerdtree
            Plug 'Xuyuanp/nerdtree-git-plugin'	    " Git support for nerdtree
        " }}}
    " }}}

    " File Types {{{
        " CSV {{{
            Plug 'chrisbra/csv.vim'     " CSV Viewer.
        " }}}
    " }}}

    " Formatting {{{
        " Delimiters {{{
            Plug 'Raimondi/delimitMate'               " Auto close quotes etc
            Plug 'tpope/vim-surround'                 " Change encapsulating chars (ie ')
        " }}}

        " Whitespace {{{
            Plug 'Yggdroot/indentLine'                " Show indentation guides
            Plug 'bronson/vim-trailing-whitespace'    " Shows trailing whitespace
        " }}}
    " }}}

    " Fuzzy Finders {{{
        " CtrlP {{{
            Plug 'ctrlpvim/ctrlp.vim'
        " }}}

        " FZF {{{
            if isdirectory('/usr/local/opt/fzf')
                Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
            else
                Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
                Plug 'junegunn/fzf.vim'
            endif
        " }}}
    " }}}

    " Git {{{
        Plug 'tpope/vim-fugitive'		        " Git helpers
        Plug 'airblade/vim-gitgutter'		    " Shows git diff in the gutter
    " }}}

    " Movement {{{
        " Plug 'easymotion/vim-easymotion'
        " Plug 'haya14busa/vim-easyoperator-line'
        " Plug 'haya14busa/vim-easyoperator-phrase'
    " }}}

    " Programming Languages {{{
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

        " C {{{
            "Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
            "Plug 'ludwig/split-manpage.vim'
        " }}}

        " Elixir {{{
            "Plug 'elixir-lang/vim-elixir'
            "Plug 'carlosgaldino/elixir-snippets'
        " }}}

        " Elm {{{
            "Plug 'elmcast/elm-vim'
        " }}}

        " Erlang {{{
            "Plug 'jimenezrick/vimerl'
        " }}}

        " Go {{{
            Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
        " }}}

        " Haskell {{{
            "Plug 'eagletmt/neco-ghc'
            "Plug 'dag/vim2hs'
            "Plug 'pbrisbin/vim-syntax-shakespeare'
        " }}}

        " HTML {{{
            Plug 'gorodinskiy/vim-coloresque'
            Plug 'hail2u/vim-css3-syntax'
            Plug 'mattn/emmet-vim'
            Plug 'tpope/vim-haml'
        " }}}

        " Javascript {{{
            Plug 'pangloss/vim-javascript'
            "" Plug 'jelera/vim-javascript-syntax'
        " }}}

        " Lisp {{{
            "Plug 'vim-scripts/slimv.vim'
        " }}}

        " Lua {{{
            "Plug 'xolox/vim-lua-ftplugin'
            "Plug 'xolox/vim-lua-inspect'
        " }}}

        " Ocaml {{{
            "Plug 'def-lkb/ocp-indent-vim'
        " }}}

        " Perl {{{
            "Plug 'vim-perl/vim-perl'
            "Plug 'c9s/perlomni.vim'
        " }}}

        " PHP {{{
            Plug 'shawncplus/phpcomplete.vim'
            Plug 'stanangeloff/php.vim'
            Plug 'arnaud-lb/vim-php-namespace'
        " }}}

        " Python {{{
            "Plug 'davidhalter/jedi-vim'
            "Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}"
        " }}}

        " Ruby {{{
            "Plug 'tpope/vim-rails'
            "Plug 'tpope/vim-rake'
            "Plug 'tpope/vim-projectionist'
            "Plug 'thoughtbot/vim-rspec'
            "Plug 'ecomba/vim-ruby-refactoring'
        " }}}

        " Rust {{{
            "Plug 'racer-rust/vim-racer'
            "Plug 'rust-lang/rust.vim'
        " }}}

        " Scala {{{
            "if has('python')
            "    " sbt-vim
            "    Plug 'ktvoelker/sbt-vim'
            "endif
            "Plug 'derekwyatt/vim-scala'
        " }}}
    " }}}

    " Sessions {{{
        "Plug 'xolox/vim-misc'
        "Plug 'xolox/vim-session'
    " }}}

    " Shell Intergration {{{
        if v:version >= 703
            if !exists(':terminal')
                Plug 'Shougo/vimshell.vim'
            endif
        endif
    " }}}

    " Snippets {{{
        " Ultisnps {{{
            if v:version >= 704
                Plug 'SirVer/ultisnips'                                     " Snippets manager
            endif
        " }}}

        " Snippet Collections {{{
            Plug 'honza/vim-snippets'                                       " Common Snippets
        " }}}
    " }}}

    " Status Bar {{{
        " Airline {{{
            Plug 'vim-airline/vim-airline'
            Plug 'vim-airline/vim-airline-themes'
        " }}}
    " }}}

    " Tags {{{
        " Tagbar {{{
            Plug 'majutsushi/tagbar'	        	" Tag outline viewer
        " }}}
    " }}}

    " Utilities {{{
        Plug 'Shougo/vimproc.vim', { 'do': 'make'}
        "Plug 'vim-scripts/grep.vim'
        "Plug 'ryanoasis/vim-devicons'
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

        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
        inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
    " }}}

    " Backup & Swap {{{
        " set backup
        " set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
        " set backupskip=/tmp/*,/private/tmp/*
        " set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
        " set writebackup
        set nobackup
        set nowb

        set noswapfile
    " }}}

    " Leader {{{
        let mapleader=','
    " }}}

    " Buffers {{{
        set autoread
        set history=500
        set undolevels=1000
        set hidden
        if exists("&undofile")
            set undofile
        endif
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
            colorscheme molokai
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

        highlight Cursor guifg=white guibg=black
        highlight iCursor guifg=white guibg=steelblue
        set guicursor=n-v-c:block-Cursor
        set guicursor+=i:ver100-iCursor
        set guicursor+=n-v-c:blinkon0

        " allows cursor to change to a line in tmux mode
        if exists('$TMUX')
            let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
            let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        else
            let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
            let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
        endif

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
            let g:netrw_banner = 0
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

    " File Types {{{
        " TXT {{{
            augroup vimrc-wrapping
                autocmd!
                autocmd BufRead,BufNewFile *.txt set wrap|set wm=2|set textwidth=79
            augroup END
        " }}}#
    " }}}

    " Folding {{{
        set foldenable
        set foldlevelstart=0
        set foldnestmax=10
    " }}}

    " GUI Options {{{
        set guioptions=egmrti
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

    " Misc {{{
        set fileformats=unix,dos,mac
        set backspace=indent,eol,start
    " }}}

    " Modelines {{{
        set modeline
        set modelines=2
    " }}}

    " Mouse {{{
        set mouse=vni
        set mousemodel=popup

        if !has('gui_running') && $DISPLAY == '' || !has('gui')
            set mouse=
        endif
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

    " Programming Languages {{{
        " All {{{
        " }}}

        " C {{{
            augroup vimrc-cplusplus
                autocmd!
                autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
                autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
            augroup END
        " }}}

        " Elixir {{{
        " }}}

        " Elm {{{
        " }}}

        " Erlang {{{
        " }}}

        " Go {{{
        " }}}

        " Haskell {{{
        " }}}

        " HTML {{{
             augroup vimrc-html
                 autocmd!
                 " for html files, 2 spaces
                 autocmd Filetype html setlocal ts=2 sw=2 expandtab
             augroup END
        " }}}

        " Javascript {{{
             augroup vimrc-javascript
                 autocmd!
                 autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
             augroup END
        " }}}

        " Lisp {{{
        " }}}

        " Lua {{{
        " }}}

        " Make/Cmake {{{
            augroup vimrc-make-cmake
                autocmd!
                autocmd FileType make setlocal noexpandtab
                autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
            augroup END
        " }}}

        " Ocaml {{{
            " let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
            " execute "set rtp+=" . g:opamshare . "/merlin/vim"
        " }}}

        " Perl {{{
        " }}}

        " PHP {{{
        " }}}

        " Python {{{
             let python_highlight_all = 1
             augroup vimrc-python
                 autocmd!
                 autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
                             \ formatoptions+=croq softtabstop=4
                             \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
             augroup END
        " }}}

        " Ruby {{{
            "let g:rubycomplete_buffer_loading = 1
            "let g:rubycomplete_classes_in_global = 1
            "let g:rubycomplete_rails = 1

             augroup vimrc-ruby
                 autocmd!
                 autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
                 autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
             augroup END
        " }}}

        " Rust {{{
        " }}}

        " Scala {{{
        " }}}
    " }}}

    " Scrolling {{{
        set nowrap              " wrap overlong lines
        set scrolljump=1      " scroll one line at a time
        set scrolloff=8         "Start scrolling when we're 8 lines away from margins
        set sidescrolloff=15
        set sidescroll=1
    " }}}

    " Search {{{
        set path+=**  " Helps using the find command for project searching
        set hlsearch
        set incsearch
        set ignorecase
        set smartcase
        set grepprg=grep\ -IrsnH
       " The Silver Searcher
        if executable('ag')
            set grepprg=ag\ --nogroup\ --nocolor
        endif
        " ripgrep
        if executable('rg')
            set grepprg=rg\ --vimgrep
        endif
        " Search mappings: These will make it so that going to the next one in a
        " search will center on the line it's found in.
        nnoremap n nzzzv
        nnoremap N Nzzzv

        " Whilst in command mode, after doing a search, am extra Carriage return turns
        " off highlighting
        nnoremap <CR> :noh<CR><CR>
    " }}}

    " Session {{{
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

        set gfn=Monospace\ 10
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
" }}}

" Plugins {{{
    " Autocomplete {{{
        " Deoplete {{{
            " Shougo/deoplete.nvim {{{
                let g:deoplete#enable_at_startup = 1
                let g:deoplete#enable_smart_case = 1
            " }}}
        " }}}
    " }}}

    " Colours {{{
        " vim-scripts/CSApprox {{{
            if !has("gui_running")
                let g:CSApprox_loaded = 1
            endif
        " }}}
    " }}}

    " File Managers {{{
        " scrooloose/nerdtree {{{
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
            nnoremap <leader><Space> :NERDTreeToggle<CR>

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
        " CSV {{{
            " chrisbra/csv.vim {{{

            " }}}
        " }}}
    " }}}

    " Formatting {{{
        " Delimiters {{{
            "Raimondi/delimitMate {{{
            " }}}

            " tpope/vim-surround {{{
            " }}}
        " }}}

        " Whitespace {{{
            " Yggdroot/indentLine {{{
                let g:indentLine_enabled = 1
                let g:indentLine_concealcursor = 0
                let g:indentLine_char = '┆'
                let g:indentLine_faster = 1
            " }}}

             " bronson/vim-trailing-whitespace {{{
             " }}}
        " }}}
    " }}}

    " Fuzzy Finders {{{
        " ctrlpvim/ctrlp.vim {{{
            " The Silver Searcher
            if executable('ag')
                let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
                let g:ctrlp_use_caching = 0
            endif
            " ripgrep
            if executable('rg')
                let g:ctrlp_user_command = 'rg %s --files --color=never -- glob ""'
                let g:ctrlp_use_caching = 0
            endif
        " }}}

        " junegunn/fzf.vim {{{
            " fzf.vim
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
            nnoremap <silent> <leader>e :FZF -m<CR>
            noremap <silent> <leader>b :Buffers<CR>
        " }}}
    " }}}

    " Git {{{
        " tpope/vim-fugitive {{{
            noremap <Leader>ga :Gwrite<CR>
            noremap <Leader>gc :Gcommit<CR>
            noremap <Leader>gsh :Gpush<CR>
            noremap <Leader>gll :Gpull<CR>
            noremap <Leader>gs :Gstatus<CR>
            noremap <Leader>gb :Gblame<CR>
            noremap <leader>gl :Glog<CR><CR><CR>:copen<CR>
            noremap <Leader>gd :Gvdiff<CR>
            noremap <Leader>gr :Gremove<CR>

            nnoremap <Leader>go :.Gbrowse<CR>                   " Open current line on GitHub
        " }}}

        " airblade/vim-gitgutter {{{

        " }}}
    " }}}

    " Programming Languages {{{
        " All {{{
            " Comments {{{
                " tpope/vim-commentary {{{
                "
                " }}}
            " }}}

            " Syntax Checking {{{
                " scrooloose/syntastic {{{
                    let g:syntastic_always_populate_loc_list=1
                    let g:syntastic_error_symbol='✗'
                    let g:syntastic_warning_symbol='⚠'
                    let g:syntastic_style_error_symbol = '✗'
                    let g:syntastic_style_warning_symbol = '⚠'
                    let g:syntastic_auto_loc_list=1
                    let g:syntastic_aggregate_errors = 1
                    let g:syntastic_check_on_open = 1

                    let g:syntastic_go_checkers = ['golint', 'govet']
                    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

                    let g:syntastic_ocaml_checkers = ['merlin']

                    let g:syntastic_python_checkers=['python', 'flake8']
                " }}}
            " }}}

            " Syntax Highlighting {{{
                " sheerun/vim-polyglot {{{
                    let g:polyglot_disabled = ['elm', 'python']
                " }}}
            " }}}
        " }}}

        " C {{{
            " vim-scripts/c.vim {{{
            "
            " }}}

            " ludwig/split-manpage.vim {{{
            "
            " }}}
        " }}}

        " Elixir {{{
            " elixir-lang/vim-elixir {{{
            "
            " }}}

            " carlosgaldino/elixir-snippets {{{
            " }}}
        " }}}

        " Elm {{{
            " elmcast/elm-vim {{{
                "let g:elm_setup_keybindings = 0
                "let g:elm_format_autosave = 1
                "let g:elm_syntastic_show_warnings = 1
            " }}}
        " }}}

        " Erlang {{{
            " jimenezrick/vimerl {{{
                "" erlang
                "let erlang_folding = 1
                "let erlang_show_errors = 1
            " }}}
        " }}}

        " Go {{{
            " fatih/vim-go {{{
                " run :GoBuild or :GoTestCompile based on the go file
                function! s:build_go_files()
                    let l:file = expand('%')
                    if l:file =~# '^\f\+_test\.go$'
                        call go#test#Test(0, 1)
                    elseif l:file =~# '^\f\+\.go$'
                        call go#cmd#Build(0)
                    endif
                endfunction

                let g:go_list_type = "quickfix"
                let g:go_fmt_command = "goimports"
                let g:go_fmt_fail_silently = 1

                let g:go_highlight_types = 1
                let g:go_highlight_fields = 1
                let g:go_highlight_functions = 1
                let g:go_highlight_methods = 1
                let g:go_highlight_operators = 1
                let g:go_highlight_build_constraints = 1
                let g:go_highlight_structs = 1
                let g:go_highlight_generate_tags = 1
                let g:go_highlight_space_tab_error = 0
                let g:go_highlight_array_whitespace_error = 0
                let g:go_highlight_trailing_whitespace_error = 0
                let g:go_highlight_extra_types = 1

                autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

                " augroup completion_preview_close
                "     autocmd!
                "     if v:version > 703 || v:version == 703 && has('patch598')
                "         autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
                "     endif
                " augroup END

                augroup go

                    au!
                    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
                    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
                    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
                    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

                    au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
                    au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
                    au FileType go nmap <Leader>db <Plug>(go-doc-browser)

                    au FileType go nmap <leader>r  <Plug>(go-run)
                    au FileType go nmap <leader>t  <Plug>(go-test)
                    au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
                    au FileType go nmap <Leader>i <Plug>(go-info)
                    au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
                    au FileType go nmap <C-g> :GoDecls<cr>
                    au FileType go nmap <leader>dr :GoDeclsDir<cr>
                    au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
                    au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
                    au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
                augroup END
            " }}}
        " }}}

        " Haskell {{{
            " eagletmt/neco-ghc {{{
                "let g:necoghc_enable_detailed_browse = 1
                "autocmd Filetype haskell setlocal omnifunc=necoghc#omnifunc
            " }}}

            " dag/vim2hs {{{
                "let g:haskell_conceal_wide = 1
                "let g:haskell_multiline_strings = 1
            " }}}

            " pbrisbin/vim-syntax-shakespeare {{{
            " }}}
        " }}}

        " HTML {{{
            " gorodinskiy/vim-coloresque {{{
            " }}}
            " hail2u/vim-css3-syntax {{{
            " }}}
            " mattn/emmet-vim {{{
                let g:user_emmet_install_global = 0
                augroup vimrc-emmet
                    autocmd!
                    autocmd FileType php,html,css EmmetInstall
                augroup END
            " }}}
            " tpope/vim-haml {{{
            " }}}
        " }}}

        " Javascript {{{
            " pangloss/vim-javascript {{{
                let g:javascript_enable_domhtmlcss = 1
            " }}}
            " jelera/vim-javascript-syntax {{{
            " }}}
        " }}}

        " Lisp {{{
            " vim-scripts/slimv.vim {{{
            " }}}
        " }}}

        " Lua {{{
            " xolox/vim-lua-ftplugin {{{
            " }}}
            " xolox/vim-lua-inspect {{{
            " }}}
        " }}}

        " Ocaml {{{
            " def-lkb/ocp-indent-vim {{{
            " }}}
        " }}}

        " Perl {{{
            " vim-perl/vim-perl {{{
            " }}}
            " c9s/perlomni.vim {{{
            " }}}
        " }}}

        " PHP {{{
            " shawncplus/phpcomplete.vim {{{
            " }}}
            " stanangeloff/php.vim {{{
            " }}}
            " arnaud-lb/vim-php-namespace {{{
            " }}}
        " }}}

        " Python {{{
            " davidhalter/jedi-vim {{{
                "" jedi-vim
                "let g:jedi#popup_on_dot = 0
                "let g:jedi#goto_assignments_command = "<leader>g"
                "let g:jedi#goto_definitions_command = "<leader>d"
                "let g:jedi#documentation_command = "K"
                "let g:jedi#usages_command = "<leader>n"
                "let g:jedi#rename_command = "<leader>r"
                "let g:jedi#show_call_signatures = "0"
                "let g:jedi#completions_command = "<C-Space>"
                "let g:jedi#smart_auto_mappings = 0
            " }}}

            " raimon49/requirements.txt.vim {{{
            " }}}
        " }}}

        " Ruby {{{
            " tpope/vim-rails {{{
            " }}}
            " tpope/vim-rake {{{
            " }}}
            " tpope/vim-projectionist {{{
            " }}}
            " thoughtbot/vim-rspec {{{
                "map <Leader>t :call RunCurrentSpecFile()<CR>
                "map <Leader>s :call RunNearestSpec()<CR>
                "map <Leader>l :call RunLastSpec()<CR>
                "map <Leader>a :call RunAllSpecs()<CR>
            " }}}

            " ecomba/vim-ruby-refactoring {{{
                "nnoremap <leader>rap  :RAddParameter<cr>
                "nnoremap <leader>rcpc :RConvertPostConditional<cr>
                "nnoremap <leader>rel  :RExtractLet<cr>
                "vnoremap <leader>rec  :RExtractConstant<cr>
                "vnoremap <leader>relv :RExtractLocalVariable<cr>
                "nnoremap <leader>rit  :RInlineTemp<cr>
                "vnoremap <leader>rrlv :RRenameLocalVariable<cr>
                "vnoremap <leader>rriv :RRenameInstanceVariable<cr>
                "vnoremap <leader>rem  :RExtractMethod<cr>

                "if has('nvim')
                "    runtime! macros/matchit.vim
                "else
                "    packadd! matchit
                "endif
            " }}}
        " }}}

        " Rust {{{
            " racer-rust/vim-racer {{{
                "au FileType rust nmap gd <Plug>(rust-def)
                "au FileType rust nmap gs <Plug>(rust-def-split)
                "au FileType rust nmap gx <Plug>(rust-def-vertical)
                "au FileType rust nmap <leader>gd <Plug>(rust-doc)
            " }}}

            " rust-lang/rust.vim {{{
            " }}}
        " }}}

        " Scala {{{
            " ktvoelker/sbt-vim {{{
            " }}}
            " derekwyatt/vim-scala {{{
            " }}}
        " }}}
    " }}}

    " Sessions {{{
        " xolox/vim-misc {{{
        "
        " }}}

        " xolox/vim-session {{{
            "" session management
            "if has('nvim')
            "    let g:session_directory = "~/.config/nvim/session"
            "else
            "    let g:session_directory = "~/.vim/session"
            "endif
            "let g:session_autoload = "no"
            "let g:session_autosave = "no"
            "let g:session_command_aliases = 1

            nnoremap <leader>so :OpenSession<Space>
            nnoremap <leader>ss :SaveSession<Space>
            nnoremap <leader>sd :DeleteSession<CR>
            nnoremap <leader>sc :CloseSession<CR>
        " }}}
    " }}}

    " Shell Intergration {{{
        " Shougo/vimshell.vim {{{
            if v:version >= 703
                if !exists(':terminal')
                    nnoremap <silent> <leader>sh :VimShellCreate<CR>
                    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
                    let g:vimshell_prompt =  '$ '
                endif
            endif
        " }}}
    " }}}

    " Snippets {{{
        " SirVer/ultisnips {{{
            let g:UltiSnipsExpandTrigger="<tab>"
            let g:UltiSnipsJumpForwardTrigger="<tab>"
            let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

            inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        " }}}

        " honza/vim-snippets {{{
        " }}}
    " }}}

    " Status Bar {{{
        " vim-airline/vim-airline {{{
            let g:airline_theme = 'molokai'
            let g:airline#extensions#syntastic#enabled = 1
            let g:airline#extensions#branch#enabled = 1
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tagbar#enabled = 1
            let g:airline_skip_empty_sections = 1
            " let g:airline_powerline_fonts = 1
            let g:hybrid_custom_term_colors = 1
            "" let g:hybrid_reduced_contrast = 1
            let g:airline#extensions#virtualenv#enabled = 1

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
        " vim-airline/vim-airline-themes {{{
        " }}}
    " }}}

    " Tags {{{
        " majutsushi/tagbar {{{
            let g:tagbar_autofocus = 1
            let g:tagbar_autoclose=2

            " Language specific config
            "let g:tagbar_type_ruby = {
            "            \ 'kinds' : [
            "            \ 'm:modules',
            "            \ 'c:classes',
            "            \ 'd:describes',
            "            \ 'C:contexts',
            "            \ 'f:methods',
            "            \ 'F:singleton methods'
            "            \ ]
            "            \ }

            " Key Maps
            "map <C-m> :TagbarToggle<CR>
            "nmap <silent> <F4> :TagbarToggle<CR>
        " }}}
    " }}}

    " Utilities {{{
        " terryma/vim-multiple-cursors {{{
        " }}}
        " vim-scripts/grep.vim {{{
            "nnoremap <silent> <leader>f :Rgrep<CR>
            "let Grep_Default_Options = '-IR'
            "let Grep_Skip_Files = '*.log *.db'
            "let Grep_Skip_Dirs = '.git node_modules'
        " }}}
    " }}}

" }}}
