if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

if exists(':terminal')
    nnoremap <silent> <leader>sh :terminal<CR>
else
    if v:version >= 703
        nnoremap <silent> <leader>sh :VimShellCreate<CR>
        let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
        let g:vimshell_prompt =  '$ '
    endif
endif


