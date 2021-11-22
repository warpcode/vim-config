function! warpcode#lsp#action(name) abort

endfunction

function! warpcode#lsp#code_action() abort
    if warpcode#plugin#coc#ready()

    endif
endfunction

function warpcode#lsp#code_action_range() abort
    
endfunction

function warpcode#lsp#declaration() abort
    
endfunction

function warpcode#lsp#definition() abort
    
endfunction

function warpcode#lsp#references() abort
    
endfunction

function warpcode#lsp#implementation() abort
    
endfunction

function warpcode#lsp#hover_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h ' . expand('<cword>')
        return
    endif

    if (warpcode#plugin#coc#ready())
        call CocActionAsync('doHover')
        return
    endif

    if (has('nvim'))
        lua vim.lsp.buf.hover()
        return
    endif

    execute '!' . &keywordprg . " " . expand('<cword>')
endfunction

function warpcode#lsp#hover() abort
    try
        if warpcode#plugin#coc#ready()
            return CocActionAsync('highlight')
        endif
    catch /.*/
    endtry
endfunction

function warpcode#lsp#signature_help() abort
    
endfunction

function warpcode#lsp#diagnostic_next() abort
    try
        if warpcode#plugin#coc#ready()
            exe "norm \<Plug>(coc-diagnostic-next)"
            return
        endif
    catch /.*/
    endtry

   if has('nvim')
       lua vim.lsp.diagnostic.goto_next()
       return
    endif 
endfunction

function warpcode#lsp#diagnostic_prev() abort
    try
        if warpcode#plugin#coc#ready()
            exe "norm \<Plug>(coc-diagnostic-prev)"
            return
        endif
    catch /.*/
    endtry

   if has('nvim')
       lua vim.lsp.diagnostic.goto_prev()
       return
    endif 
endfunction

function warpcode#lsp#rename() abort
    try
        if warpcode#plugin#coc#ready()
            exe "norm \<Plug>(coc-rename)"
            return
        endif
    catch /.*/
    endtry

   if has('nvim')
       lua vim.lsp.buf.rename()
       return
    endif 
endfunction
