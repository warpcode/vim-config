if !has('nvim')
    augroup VimrcFileTypeCss
        autocmd!

        " Allow hyphen as part of the keyword
        autocmd FileType css,scss setlocal iskeyword+=-
    augroup END
endif
