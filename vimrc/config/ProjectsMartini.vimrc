function! s:detectMartini()
    let isMartini = DetectFileInParents('initMartini.sh')

    if isMartini == ""
        return
    endif

    if match(&filetype, '\v<javascript>') != 1
        UltiSnipsAddFiletypes javascript-martini
        UltiSnipsAddFiletypes javascript-jquery
    endif

    if match(&filetype, '\v<html>') != 1
        UltiSnipsAddFiletypes html-martini
    endif

    if match(&filetype, '\v<php>') != 1
        UltiSnipsAddFiletypes php-martini
    endif
endfunction

augroup VimrcProjectsMartini
    autocmd!
    autocmd FileType * call s:detectMartini()
augroup END
