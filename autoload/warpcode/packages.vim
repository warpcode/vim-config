" Wrapper around the package manager(s)
" to provide a consistent interface and common functionality that 
" may not always be available.
" Written in viml for maximum compatibility
if !exists('g:vim_home')
    echoerr('g:vim_home is not set')
endif

if !isdirectory(g:vim_home)
    echoerr('g:vim_home is not a valid directory')
endif

let s:package_manager = 'vim-plug'
let s:packages = {}
let s:pre_callback = {}
let s:post_callback = {}
let s:run_install = 0

function! s:get_install_path() abort
    if s:package_manager == 'minpac'
        return g:vim_home . '/pack/minpac/opt/minpac'
    else
        return g:vim_home . '/autoload/plug.vim'
    end
endfunction

function! s:install_path_exists() abort
    return empty(glob(s:get_install_path())) < 1
endfunction

function! s:install_package_manager() abort
    if s:install_path_exists()
        " If already installed, skip it
        return 1
    end

    let install_path = s:get_install_path()

    echo "Installing package manager: " . s:package_manager
    if s:package_manager == 'minpac'
        if executable('git')
            exe 'silent !git clone https://github.com/k-takata/minpac.git "' . install_path . '"' | redraw
        else
            echoerr("You have to install git or first install minpac yourself!")
        end
    else
        if executable('curl')
            exe 'silent !curl -fLo "' . install_path . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' | redraw
        else
            echoerr("You have to install curl or first install vim-plug yourself!")
        end
    end

    if !s:install_path_exists()
        echoerr('Package manager "' . s:package_manager . '" failed to install')
        return 0
    end

    let s:run_install = 1

    return 1
endfunction

function! s:load_packages() abort
    let k = keys(s:packages)
    for i in k
        let options = s:packages[i]

        if has_key(options, 'disable_nvim') && options['disable_nvim'] && has('nvim')
            " If disabled, don't process it
            continue
        endif

        if has_key(options, 'disable_vim') && options['disable_vim'] && !has('nvim')
            " If disabled, don't process it
            continue
        endif

        if has_key(options, 'disable') && options['disable']
            " If disabled, don't process it
            continue
        endif

        if has_key(options, 'config') && type(options['config']) == v:t_func
            " Grab configs to run after loading the plugins
            " TODO check for lazy load hooks like on filetype or on command to
            " also lazy load the config
            let s:post_callback[i] = options['config']
            unlet options['config']
        endif


        if has_key(options, 'pre_config') && type(options['pre_config']) == v:t_func
            " Execute any pre load callbacks
            call call(options['pre_config'], [])
            unlet options['pre_config']
        endif

        if s:package_manager == 'minpac'
            call minpac#add(i, options)
        else
            Plug i, options
        end
    endfor
endfunction

function! s:get_plugin_name(name) abort
    let new_name = matchstr(a:name, '[/\\]\zs[^/\\]\+$')
    let new_name = substitute(new_name, '\C\.git$', '', '')

    return new_name
endfunction

function! warpcode#packages#install() abort
    if s:package_manager == 'minpac'
        call minpac#update()
    else
        PlugUpdate
    end
endfunction

function! warpcode#packages#add(...) abort
    if type(a:1) != v:t_string
        return
    end

    let options = {}

    if a:0 > 1
        if type(a:2) == v:t_dict
            let options = a:2
        endif
    end

    let s:packages[a:1] = options
endfunction

function! warpcode#packages#run() abort
    if !s:install_package_manager()
        return
    end

    if s:package_manager == 'minpac'
        packadd minpac
        call minpac#init()
        " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        call s:load_packages()
    else
        call plug#begin(g:vim_home . '/plugged')
        call s:load_packages()
        call plug#end()
    end

    if s:run_install
        call warpcode#packages#install()
    end
endfunction

