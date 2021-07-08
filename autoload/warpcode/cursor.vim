function! warpcode#cursor#highlight() abort
    try
        call CocActionAsync('highlight')
    catch /.*/
    endtry
endfunction
