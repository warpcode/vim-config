return function()
    vim.api.nvim_exec([[
        " General Options
        " let g:airline_theme = 'gruvbox'
        let g:hybrid_custom_term_colors = 1
        let g:airline_exclude_preview = 0
        let g:airline_detect_modified=1
        let g:airline_focuslost_inactive = 1
        let g:airline_skip_empty_sections = 1
        let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
        let g:airline_stl_path_style = 'short'

        " Symbols
        if !exists('g:airline_symbols')
        let g:airline_symbols = {}
        endif

        let g:airline_left_sep = '▶'
        let g:airline_left_alt_sep = '»'
        let g:airline_right_sep = '◀'
        let g:airline_right_alt_sep = '«'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.colnr = ' ㏇:'
        let g:airline_symbols.crypt = '🔒'
        let g:airline_symbols.dirty='⚡'
        let g:airline_symbols.linenr = '㏑'
        let g:airline_symbols.maxlinenr = '☰ '
        let g:airline_symbols.notexists = 'Ɇ'
        let g:airline_symbols.paste = '∥'
        let g:airline_symbols.readonly = '⭤'
        let g:airline_symbols.spell = 'Ꞩ'
        let g:airline_symbols.whitespace = 'Ξ'

        " File type overrides
        let g:airline_filetype_overrides = {
        \ 'coc-explorer':  [ 'CoC Explorer', '' ],
        \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
        \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
        \ 'gundo': [ 'Gundo', '' ],
        \ 'help':  [ 'Help', '%f' ],
        \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
        \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
        \ 'startify': [ 'startify', '' ],
        \ 'vim-plug': [ 'Plugins', '' ],
        \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
        \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
        \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
        \ }
    ]], false)
end
