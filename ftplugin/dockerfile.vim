if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if filereadable(g:vim_home . "/node_modules/.bin/docker-langserver")
    call warpcode#plugin#coc#addLsp('dockerfile', {
    \       "command": g:vim_home . "/node_modules/.bin/docker-langserver",
    \       "args": ["--stdio"],
    \       "filetypes": ["dockerfile"]
    \   }
    \)
endif

