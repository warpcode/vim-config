set fileformats=unix,dos,mac
set fileformat=unix
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab


" Preseve visual mode when indenting
vmap < <gv
vmap > >gv


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call warpcode#ft#all#format()
