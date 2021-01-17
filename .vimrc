set nocompatible
filetype off
let mapleader='\'

if has('nvim')
    let vimhome=expand('~/.config/nvim')
    let vimSrc=fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')
else
    let vimhome=expand('~/.vim')
    let vimSrc=fnamemodify(resolve(expand('~/.vimrc')), ':h')
endif

let vimIncludes=vimSrc."/vimrc"

" Add the repository to the runtime path
let &runtimepath=escape(vimSrc, '\,').','.&runtimepath

exec "source ".vimIncludes."/functions.vimrc"
exec "source ".vimIncludes."/vimPlug.vimrc"

filetype plugin indent on

for f in split(glob(vimIncludes.'/config/*.vimrc'), '\n')
    exe 'source' f
endfor
