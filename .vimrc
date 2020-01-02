set nocompatible
filetype off
let mapleader='\'

if has('nvim')
    let vimhome=expand('~/.config/nvim')
else
    let vimhome=expand('~/.vim')
endif

let vimSrc=fnamemodify(resolve(expand('~/.vimrc')), ':h')
let vimIncludes=vimSrc."/vimrc"

" Add the repository to the runtime path
let &runtimepath=escape(vimSrc, '\,').','.&runtimepath

exec "source ".vimIncludes."/functions.vimrc"
exec "source ".vimIncludes."/vimPlug.vimrc"

filetype plugin indent on

for f in split(glob(vimIncludes.'/config/*.vimrc'), '\n')
    exe 'source' f
endfor

for f in split(glob(vimIncludes.'/packagesConfig/*.vimrc'), '\n')
    exe 'source' f
endfor
