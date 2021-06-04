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

" Enable absolute numbers on the selected line but relative on other lines
set number
set relativenumber

augroup WARPCODE_BUFFER_FOCUS_NUMBER_TOGGLE
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
