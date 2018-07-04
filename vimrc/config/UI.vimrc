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

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif
