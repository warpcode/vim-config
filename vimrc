set nocompatible
filetype off
let mapleader=' ' " Spave character

if has('nvim')
    let g:vim_home=expand('~/.config/nvim')
    let g:vim_source=fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')
else
    let g:vim_home=expand('~/.vim')
    let g:vim_source=fnamemodify(resolve(expand('~/.vimrc')), ':h')
endif

let g:vim_node_bin = g:vim_source . '/node_modules/.bin'

let &runtimepath.=',' . g:vim_source
let &runtimepath.=',' . g:vim_source. '/after'

if has('lua') || has('nvim')
    lua require ('warpcode.setup')
endif

filetype plugin indent on
