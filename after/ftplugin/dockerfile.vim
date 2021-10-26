if exists("b:did_ftplugin_warpcode")
    finish
endif
let b:did_ftplugin_warpcode = 1

if filereadable(g:vim_node_bin . "/docker-langserver")
    call warpcode#plugin#coc#addLsp('dockerfile', {
    \       "command": g:vim_node_bin . "/docker-langserver",
    \       "args": ["--stdio"],
    \       "filetypes": ["dockerfile"]
    \   }
    \)
endif
