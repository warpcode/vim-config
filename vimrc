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

let g:vim_node_bin=g:vim_home . '/node_modules/.bin'

" Setup Plug
let vimplug_exists=expand(g:vim_home . '/autoload/plug.vim')
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

if isdirectory(g:vim_home . '/plugged') == 0
    execute "silent !mkdir -p \"" .  g:vim_home . "/plugged\" > /dev/null 2>&1"
endif

" Setup plugins
call plug#begin(expand(g:vim_home . '/plugged'))

for f in split(glob(g:vim_source.'/packages/*.vim'), '\n')
    exe 'source' f
endfor

call plug#end()

filetype plugin indent on
