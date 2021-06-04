if !has('nvim')
    function! s:setEsLint()
        let g:eslint_config_name = '.eslintrc.json'

        " We need to search for the first instance of the file working up the tree from our file
        let g:eslint_current_dir = expand('%:p:h')
        let g:eslint_lint_file = fnamemodify(g:eslint_current_dir, ':p') . g:eslint_config_name
        while !filereadable(g:eslint_lint_file)
            let g:eslint_current_dir_prev = g:eslint_current_dir
            let g:eslint_current_dir = fnamemodify(g:eslint_current_dir, ':h')

            if g:eslint_current_dir_prev == g:eslint_current_dir
                break
            endif

            let g:eslint_lint_file = fnamemodify(g:eslint_current_dir, ':p') . g:eslint_config_name
        endwhile

        if filereadable(g:eslint_lint_file)
            let g:syntastic_javascript_eslint_exe = '$(cd "' . g:eslint_current_dir . '"; npm bin)/eslint'
            let g:syntastic_javascript_eslint_args='-f compact  -c ' . g:eslint_lint_file
        else
            let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
            let g:syntastic_javascript_eslint_args='-f compact'
        endif
        let g:syntastic_javascript_eslint_generic = 1
        let g:syntastic_javascript_checkers = ['eslint']
        let g:syntastic_javascript_eslint_exec='/bin/ls' " seems to be required to work
    endfunction


    augroup VimrcFileTypeJs
        autocmd!

        autocmd FileType javascript call s:setEsLint()
    augroup END
endif
