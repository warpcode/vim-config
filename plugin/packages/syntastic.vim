" Synastic settings for syntax checking
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" let g:syntastic_phpcs_disable = 1
" let g:syntastic_phpmd_disable = 1
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=PSR2 -n'
let g:ultisnips_php_scalar_types = 1

let g:syntastic_python_checkers=['python', 'flake8']
let python_highlight_all = 1
