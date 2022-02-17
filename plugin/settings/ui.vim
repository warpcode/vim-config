set title
set titleold="Terminal"
set titlestring=%F          " Set terminal title to the name of the file

set laststatus=2
set lazyredraw
set redrawtime=10000
set linebreak
set ruler
set showcmd
set showmatch
set showmode
set signcolumn=yes
set colorcolumn=80,120

" Enable absolute numbers on the selected line but relative on other lines
set number
set relativenumber

" Whitespace
set listchars=eol:¬,tab:\|\ ,trail:~,extends:>,precedes:<,nbsp:·
set list

augroup WARPCODE_BUFFER_FOCUS_NUMBER_TOGGLE
  autocmd!
  " Auto set line numbers when changing buffers
  autocmd BufEnter,FocusGained,InsertLeave * if index(['help', 'nerdtree'], &filetype) >= 0 | set nonu nornu | else | set number relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if index(['help', 'nerdtree'], &filetype) >= 0 | set nonu nornu | else | set number norelativenumber | endif
augroup END
