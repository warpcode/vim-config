" disable the cursor line
set nocursorline
set updatetime=1000

augroup WARPCODE_CURSOR
    autocmd!
    " Remember cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " On cursor hold, run the highlight function
    " TODO replace autoload functions with direct mappings
    " autocmd CursorHold * silent if warpcode#plugin#coc#ready() | call CocActionAsync('highlight') |  elseif has('nvim') | exe 'lua vim.lsp.buf.document_highlight()' | endif 
    " autocmd CursorHoldI * silent if warpcode#plugin#coc#ready() | call CocActionAsync('highlight') |  elseif has('nvim') | exe 'lua vim.lsp.buf.document_highlight()' | endif
    " autocmd CursorMoved * silent if has('nvim') | exe 'lua vim.lsp.buf.clear_references()' | endif 
    " autocmd CursorMovedI * silent if has('nvim') | exe 'lua vim.lsp.buf.clear_references()' | endif 
augroup END
