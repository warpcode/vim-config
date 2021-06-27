set title
set titleold="Terminal"
set titlestring=%F          " Set terminal title to the name of the file

set laststatus=2
set lazyredraw
set redrawtime=10000
set linebreak
set ruler
set showcmd
set showmatch
set showmode
set signcolumn=yes
set colorcolumn=80,120

" Enable absolute numbers on the selected line but relative on other lines
set number
set relativenumber

" Whitespace
set listchars=eol:¬,tab:\|\ ,trail:~,extends:>,precedes:<,nbsp:·
set list

" Resize verticle pane split incrementally
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Maximise verticle split
nnoremap <Leader>rp :resize 100<CR>

augroup WARPCODE_BUFFER_FOCUS_NUMBER_TOGGLE
  autocmd!
  " Auto set line numbers when changing buffers
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" highlight last inserted text
nnoremap gV `[v`]

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Override K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
