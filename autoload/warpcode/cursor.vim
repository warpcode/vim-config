function! warpcode#cursor#highlight() abort
    try
        return CocActionAsync('highlight')
    catch /.*/
    endtry

    return ""
endfunction
