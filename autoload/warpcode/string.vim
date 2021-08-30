function! warpcode#string#escapeVimCommands(string) abort
    return escape(a:string, "\"\'/.*+?|()[]{}<>\#")
endfunction

function! warpcode#string#escapeVimRegex(string) abort
    return escape(a:string, "\\/.$*")
endfunction
