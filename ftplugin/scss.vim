if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal iskeyword+=@-@

nnoremap <buffer> <leader>cp :<C-u>call CocAction('colorPresentation')<CR>
" only works on Mac or have python gtk module installed.
nnoremap <buffer> <leader>cc :<C-u>call CocAction('pickColor')<CR>
