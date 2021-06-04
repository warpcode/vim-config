if !has('nvim')

    " NERDTree
    let g:NERDTreeChDirMode=2
    " let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
    let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
    let g:NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_focus_on_files=1
    let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
    let g:NERDTreeWinSize = 40
    let g:NERDTreeShowHidden=1
    " Show ignored icon next to ignored files. This can be intensive with a lot of files
    let g:NERDTreeGitStatusShowIgnored = 1
    " List of icons for file statuses
    " let g:NERDTreeIndicatorMapCustom = {
    "             \ "Modified"  : "✹",
    "             \ "Staged"    : "✚",
    "             \ "Untracked" : "✭",
    "             \ "Renamed"   : "➜",
    "             \ "Unmerged"  : "═",
    "             \ "Deleted"   : "✖",
    "             \ "Dirty"     : "✗",
    "             \ "Clean"     : "✔︎",
    "             \ 'Ignored'   : '☒',
    "             \ "Unknown"   : "?"
    "             \ }

    " NERDTree - Quit vim when all other windows have been closed.
    au BufEnter *
                \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
                \ b:NERDTreeType == "primary") |
                \   q |
                \ endif

    " Toggle NERDTREE
    nnoremap <leader>t :NERDTreeToggle<CR>
endif
