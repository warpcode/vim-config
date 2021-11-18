function! warpcode#plugin#coc#ready() abort
    try
        return coc#rpc#ready()
    catch /.*/
        return 0
    endtry
endfunction



function! warpcode#plugin#coc#add_lsp(name, config) abort
    try
        " let lsps = get(g:coc_user_config, 'languageserver', {})
        let lsps = {}
        let lsps[a:name] = a:config
        call coc#config('languageserver', lsps)
    catch /.*/
        return 0
    endtry

    return 1
endfunction
