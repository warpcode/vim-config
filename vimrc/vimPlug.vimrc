
let vimplug_exists=expand(vimhome . '/autoload/plug.vim')

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

if isdirectory(vimhome . '/plugged') == 0
    execute "silent !mkdir -p \"" .  vimhome . "/plugged\" > /dev/null 2>&1"
endif

call plug#begin(expand(vimhome . '/plugged'))

for f in split(glob(vimIncludes.'/packagesPlug/*.vimrc'), '\n')
    exe 'source' f
endfor

call plug#end()
