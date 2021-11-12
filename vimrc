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

" set packpath^=~/.vim§
packadd vim-config

" Themes
call warpcode#packages#add('chriskempson/base16-vim')
call warpcode#packages#add('flazz/vim-colorschemes')
call warpcode#packages#add('gruvbox-community/gruvbox')

" Completion
" call warpcode#packages#add('neoclide/coc.nvim', { 'branch': 'release' })
" call warpcode#packages#add('neoclide/coc-css', { 'do': '!' . g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-eslint', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-json', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-highlight', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-html', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('xiyaowong/coc-sumneko-lua', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('marlonfan/coc-phpls', {'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('josa42/coc-sh', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-tsserver', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('iamcco/coc-vimlsp', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('iamcco/coc-diagnostic', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-emmet', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-lists', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('neoclide/coc-snippets', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile' })
" call warpcode#packages#add('honza/vim-snippets')

" File Managers
call warpcode#packages#add('junegunn/fzf', {'do': {-> fzf#install()}})
call warpcode#packages#add('junegunn/fzf.vim')
call warpcode#packages#add('scrooloose/nerdtree', {'do': 'NERDTreeToggle'})
call warpcode#packages#add('jistr/vim-nerdtree-tabs')
call warpcode#packages#add('Xuyuanp/nerdtree-git-plugin')

" ft-css
call warpcode#packages#add('hail2u/vim-css3-syntax')

" ft-html
call warpcode#packages#add('mattn/emmet-vim')

" Status bar
call warpcode#packages#add('vim-airline/vim-airline')
call warpcode#packages#add('vim-airline/vim-airline-themes')

" UI
call warpcode#packages#add('bronson/vim-trailing-whitespace')
call warpcode#packages#add('lukas-reineke/indent-blankline.nvim', {'disable_vim': 1})
call warpcode#packages#add('Yggdroot/indentLine', {'disable_nvim': 1})
call warpcode#packages#add('sheerun/vim-polyglot')
call warpcode#packages#add('nvim-treesitter/nvim-treesitter', {'do':':TSUpdate | TSInstall all', 'disable_vim': 1})
call warpcode#packages#add('nvim-treesitter/nvim-treesitter', {'disable_vim': 1})
call warpcode#packages#add('nvim-treesitter/playground', {'disable_vim': 1})

" Utils
call warpcode#packages#add('tpope/vim-commentary')
" Autoclose delimiters
call warpcode#packages#add('Raimondi/delimitMate')
" Change encapsulating quotes
call warpcode#packages#add('tpope/vim-surround')
" View man pages in vim
call warpcode#packages#add('vim-utils/vim-man')
" Visual way to explore vim's undo tree
call warpcode#packages#add('mbbill/undotree')

" Version Control
call warpcode#packages#add('tpope/vim-fugitive', { 'disable': !executable('git') })
call warpcode#packages#add('airblade/vim-gitgutter', { 'disable': !executable('git') })
call warpcode#packages#add('junegunn/gv.vim', { 'disable': !executable('git') })
call warpcode#packages#add('tveskag/nvim-blame-line', { 'disable': !executable('git') })

call warpcode#packages#run()

filetype plugin indent on
