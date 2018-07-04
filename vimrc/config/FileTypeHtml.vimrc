" Don't allow emmet to be available everywhere
let g:user_emmet_install_global = 0

augroup VimrcFileTypeHtml
    autocmd!
    
    " Restrict the filetypes emmet can be used in
    autocmd FileType php,html,css,scss EmmetInstall
augroup END
