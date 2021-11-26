
" @TODO
"   -- See `:help vim.lsp.*` for documentation on any of the below functions
"   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
"   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
"   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
"   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
"   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

function! warpcode#lsp#action(name) abort

endfunction

function! warpcode#lsp#code_action() abort
    if warpcode#plugin#coc#ready()

    endif
endfunction

function warpcode#lsp#code_action_range() abort

endfunction

function warpcode#lsp#declaration() abort
    if (has('nvim'))
        lua vim.lsp.buf.declaration()
        return
    endif
endfunction

" Go to the definition of the class/method/func etc
function warpcode#lsp#definition() abort
    if (has('nvim'))
        lua vim.lsp.buf.definition()
        return
    endif
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

function warpcode#lsp#hover_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h ' . expand('<cword>')
        return
    endif

    if warpcode#plugin#coc#ready() && CocHasProvider('doHover') == v:true
        call CocActionAsync('doHover')
        return
    endif

    if (has('nvim'))
        lua vim.lsp.buf.hover()
        return
    endif

    execute '!' . &keywordprg . " " . expand('<cword>')
endfunction

function warpcode#lsp#implementation() abort
    if has('nvim')
        lua vim.lsp.buf.implementation()
        return
    endif
endfunction

function warpcode#lsp#signature_help() abort
    if has('nvim')
        lua vim.lsp.buf.signature_help()
        return
    endif
endfunction

function warpcode#lsp#references() abort
    if has('nvim')
        lua vim.lsp.buf.references()
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
