
set path+=**  " Helps using the find command for project searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,preview
set completeopt+=noselect
set completeopt+=noinsert
" set complete-=i

" Setup the ignore list
set wildignore+=*.swp,tags                      " Ignore common VIM files
set wildignore+=*/tmp/*                         " Ignore temporary directories
set wildignore+=*.png,*.jpg,*.jpeg,*.gif        " Ignore images
set wildignore+=*.avi,*.mp4,*.mkv,*.mov         " Ignore videos
set wildignore+=*.mp3,*.aac,*.m4a,*.mka,*.wav   " Ignore audio
set wildignore+=*.zip,*.rar,*.7z,*.gz           " Ignore compressed archives
set wildignore+=.DS_Store                       " Ignore MacOS DS_Store files
set wildignore+=.git,.hg,.svn                   " Ignore version control directories
set wildignore+=*.o,*.so                        " Ignore compiled objects (eg for C)
set wildignore+=*.pyc,__pycache__               " Ignore common python objects


set grepprg=grep\ -IrsnH
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

" ripgrep
if executable('rg')
    set grepprg=rg\ --vimgrep
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

"cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>f :FZF -m<CR>
noremap <silent> <leader>b :Buffers<CR>

" Whilst in command mode, after doing a search, an extra Carriage return turns
" off highlighting
nnoremap <CR> :noh<CR><CR>
