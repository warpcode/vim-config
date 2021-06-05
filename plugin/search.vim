set path+=**  " Helps using the find command for project searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set wildmode=longest,list,full
set wildmenu

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
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*

" Whilst in command mode, after doing a search, an extra Carriage return turns
" off highlighting
nnoremap <CR> :noh<CR><CR>
