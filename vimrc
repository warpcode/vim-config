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

let g:vim_node_bin = g:vim_source . '/modules/node/node_modules/.bin'

" set packpath^=~/.vim§
packadd vim-config

let s:new_config = 0

" Themes
" call warpcode#packages#add('chriskempson/base16-vim')
" call warpcode#packages#add('flazz/vim-colorschemes')
call warpcode#packages#add('gruvbox-community/gruvbox', {'config': { -> execute('colorscheme gruvbox')}})

if s:new_config && has('nvim')
    " Completion
    call warpcode#packages#add('hrsh7th/cmp-nvim-lsp', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/cmp-buffer', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/cmp-path', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/cmp-cmdline', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/nvim-cmp', {'disable_vim': 1})
    call warpcode#packages#add('onsails/lspkind-nvim', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/cmp-vsnip', {'disable_vim': 1})
    call warpcode#packages#add('hrsh7th/vim-vsnip', {'disable_vim': 1})
    " call warpcode#packages#add('tzachar/cmp-tabnine', {'do': './install.sh', 'disable_vim': 1})
    call warpcode#packages#add('simrat39/symbols-outline.nvim', {'disable_vim': 1})

    " lsp
    " call warpcode#packages#add('williamboman/nvim-lsp-installer', {'disable_vim': 1})
else
    " Completion
    call warpcode#packages#add('neoclide/coc.nvim', { 'branch': 'release'})
    call warpcode#packages#add('neoclide/coc-css', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-eslint', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-json', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-highlight', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-html', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('xiyaowong/coc-sumneko-lua', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('marlonfan/coc-phpls', {'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('josa42/coc-sh', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-tsserver', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('iamcco/coc-vimlsp', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('iamcco/coc-diagnostic', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'}, {'disable_nvim': 1})
    call warpcode#packages#add('neoclide/coc-emmet', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-lists', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
    call warpcode#packages#add('neoclide/coc-snippets', { 'do': g:vim_node_bin . '/yarn install --frozen-lockfile'})
end

" File Managers
call warpcode#packages#add('junegunn/fzf', {'do': {-> fzf#install()}, 'disable_nvim': 1})
call warpcode#packages#add('junegunn/fzf.vim', {'disable_nvim': 1})
call warpcode#packages#add('nvim-lua/plenary.nvim', {'disable_vim': 1})
call warpcode#packages#add('nvim-telescope/telescope.nvim', {'disable_vim': 1})
call warpcode#packages#add('nvim-telescope/telescope-fzf-native.nvim', {'disable_vim': 1, 'do': 'make'})
call warpcode#packages#add('scrooloose/nerdtree')
call warpcode#packages#add('jistr/vim-nerdtree-tabs')
call warpcode#packages#add('Xuyuanp/nerdtree-git-plugin')

" ft-css
" call warpcode#packages#add('hail2u/vim-css3-syntax')

" ft-html
" call warpcode#packages#add('mattn/emmet-vim')

" lsp
call warpcode#packages#add('neovim/nvim-lspconfig', {'disable_vim': 1})
call warpcode#packages#add('glepnir/lspsaga.nvim', {'disable_vim': 1})
call warpcode#packages#add('jose-elias-alvarez/null-ls.nvim', {'disable_vim': 1})

" Status bar
call warpcode#packages#add('vim-airline/vim-airline')
call warpcode#packages#add('vim-airline/vim-airline-themes')

" UI
call warpcode#packages#add('bronson/vim-trailing-whitespace')
call warpcode#packages#add('lukas-reineke/indent-blankline.nvim', {'disable_vim': 1})
call warpcode#packages#add('Yggdroot/indentLine', {'disable_nvim': 1})

" Snippets
call warpcode#packages#add('rafamadriz/friendly-snippets', {'disable_vim': 1})
call warpcode#packages#add('honza/vim-snippets', {'disable_nvim': 1})

" Utils
call warpcode#packages#add('tpope/vim-commentary')
call warpcode#packages#add('Raimondi/delimitMate')
call warpcode#packages#add('tpope/vim-surround')
call warpcode#packages#add('vim-utils/vim-man')
call warpcode#packages#add('mbbill/undotree')
call warpcode#packages#add('nvim-treesitter/nvim-treesitter', {'disable_vim': 1})
call warpcode#packages#add('nvim-treesitter/playground', {'disable_vim': 1})

" Version Control
call warpcode#packages#add('tpope/vim-fugitive', { 'disable': !executable('git') })
call warpcode#packages#add('airblade/vim-gitgutter', { 'disable': !executable('git') })
call warpcode#packages#add('junegunn/gv.vim', { 'disable': !executable('git') })
call warpcode#packages#add('tveskag/nvim-blame-line', { 'disable': !executable('git') })

call warpcode#packages#run()

filetype plugin indent on

if has('nvim')
    lua require('warpcode')
endif
