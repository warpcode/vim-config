if !has('nvim')
    set grepprg=grep\ -IrsnH\ --
    let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

    " The Silver Searcher
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
        let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
    endif

    " ripgrep
    if executable('rg')
        set grepprg=rg\ --vimgrep
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    endif

    "cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
endif
