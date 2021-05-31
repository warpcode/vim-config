set nocompatible
filetype off
let mapleader='\'

if has('nvim')
    let vim_home=expand('~/.config/nvim')
    let vim_source=fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')
else
    let vim_home=expand('~/.vim')
    let vim_source=fnamemodify(resolve(expand('~/.vimrc')), ':h')
endif

let vim_includes=vim_source."/vimrc"

" Add the repository to the runtime path
let &runtimepath=escape(vim_source, '\,').','.&runtimepath

" Setup Plug
let vimplug_exists=expand(vim_home . '/autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "cq!"
    endif
    echo "Installing Vim-Plug to ".vimplug_exists."..."
    echo ""

    execute "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

if isdirectory(vim_home . '/plugged') == 0
    execute "silent !mkdir -p \"" .  vim_home . "/plugged\" > /dev/null 2>&1"
endif

" exec "source ".vim_includes."/functions.vimrc"

" Setup plugins
call plug#begin(expand(vim_home . '/plugged'))

for f in split(glob(vim_source.'/packages/*.vim'), '\n')
    exe 'source' f
endfor

call plug#end()

if !has('nvim')
    for f in split(glob(vim_includes.'/config/*.vimrc'), '\n')
        exe 'source' f
    endfor
endif

filetype plugin indent on
