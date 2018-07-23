let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_eslint_generic = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec='/bin/ls' " seems to be required to work
let g:syntastic_javascript_eslint_args='-f compact'
