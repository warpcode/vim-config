" Show blame info below the statusline instead of using virtual text
let g:blameLineUseVirtualText = 1

" Specify the highlight group used for the virtual text ('Comment' by default)
let g:blameLineVirtualTextHighlight = 'Conceal'

" Change format of virtual text ('%s' by default)
let g:blameLineVirtualTextFormat = '%s'

" Customize format for git blame (Default format: '%an | %ar | %s')
let g:blameLineGitFormat = ' -- %an | %ar | %s'
" Refer to 'git-show --format=' man pages for format options)
