if !has('nvim')
    set fileformats=unix,dos,mac " Set newline detection format
    set fileformat=unix " always use unix line endings
    set autoindent
    set smartindent
    set smarttab
    set tabstop=4
    set softtabstop=0
    set shiftwidth=4
    set expandtab

    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1

    set listchars=eol:¬,tab:\|\ ,trail:~,extends:>,precedes:<,nbsp:·
    set list
endif
