" Disable some polyglot highlighting
let g:polyglot_disabled = ['elm', 'python']

" Synastic settings for syntax checking
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
