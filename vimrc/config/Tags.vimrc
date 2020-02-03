let g:gutentags_enabled = 0
let g:gutentags_ctags_executable = 'ctags-exuberant'
let g:gutentags_trace = 0
let g:gutentags_project_root = ['.git', '.svn', '.root', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
" let g:gutentags_cache_dir = '.git'
" if isdirectory('.git') == 0
"     " let s:vim_tags = expand('~/.cache/tags')
"     let g:gutentags_cache_dir = '.git'
" endif
let g:gutentags_file_list_command = {
    \  'markers': {
        \  '.git': 'git ls-files',
        \  '.hg': 'hg files',
    \  }
\  }
" set statusline+=%{gutentags#statusline()}
