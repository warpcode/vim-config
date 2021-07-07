function! warpcode#plugin#coc#ready() abort
    try
        return coc#rpc#ready()
    catch /.*/
        return 0
    endtry
endfunction

