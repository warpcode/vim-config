if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

setlocal iskeyword+=@-@

nnoremap <buffer> <leader>cp :<C-u>call CocAction('colorPresentation')<CR>
" only works on Mac or have python gtk module installed.
nnoremap <buffer> <leader>cc :<C-u>call CocAction('pickColor')<CR>

" Tabs
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=4
setlocal softtabstop=2
