" NETRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browsesplit = 4
let g:netrw_altv = 1
let g:netrw_winsize = -40
let g:netrw_list_hide = &wildignore


augroup WARPCODE_NETRW
    autocmd!
    autocmd filetype netrw nmap <c-a> <cr>:wincmd W<cr>
augroup END

nnoremap <leader>nw :Lexplore<CR>
