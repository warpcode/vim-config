
function warpcode#lsp#format() abort
    try
        if warpcode#plugin#coc#ready() && CocHasProvider('format') == v:true
            return CocAction('format')
        endif
    catch /.*/
    endtry

    if has('nvim')
        lua vim.lsp.buf.formatting_sync()
        return
    endif

    " If all else fails, run vim's native way of formatting
    call warpcode#util#run_command_preserve_cursor('normal gg=G')
endfunction

function warpcode#lsp#format_selected() abort
    try
        if warpcode#plugin#coc#ready()
            exe "norm \<Plug>(coc-format-selected)"
            return
        endif
    catch /.*/
    endtry

    if has('nvim')
        lua vim.lsp.buf.range_formatting()
        return
    endif

    " If all else fails, run vim's native way of formatting
    call warpcode#util#run_command_preserve_cursor('normal ==')
endfunction

function warpcode#lsp#hover() abort
    try
        if warpcode#plugin#coc#ready() && CocHasProvider('highlight') == v:true
            return CocActionAsync('highlight')
        endif
    catch /.*/
    endtry

    try
        if has('nvim')
            lua vim.lsp.buf.document_highlight()
            return
        endif
    catch /.*/
    endtry
endfunction

function warpcode#lsp#hover_clear() abort
    if has('nvim')
        lua vim.lsp.buf.clear_references()
        return
    endif
endfunction
