" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.
" Run vim +PlugInstall +qall to install
set nocompatible               " Be iMproved

" Basic Config {{{
	" Abbreviations {{{
        " Common abbreviation for typos
        cnoreabbrev W! w!
        cnoreabbrev Q! q!
        cnoreabbrev Qall! qall!
        cnoreabbrev Wq wq
        cnoreabbrev Wa wa
        cnoreabbrev wQ wq
        cnoreabbrev WQ wq
        cnoreabbrev W w
        cnoreabbrev Q q
        cnoreabbrev Qall qall
    " }}}

	" Leader {{{
			let mapleader=','
    " }}}
" }}}
