
augroup WARPCODE_BUFFER_FOCUS_NUMBER_TOGGLE
  autocmd!
  " Auto set line numbers when changing buffers
  autocmd BufEnter,FocusGained,InsertLeave * if index(['help', 'nerdtree', 'netrw'], &filetype) >= 0 | set nonu nornu | else | set number relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if index(['help', 'nerdtree', 'netrw'], &filetype) >= 0 | set nonu nornu | else | set number norelativenumber | endif
augroup END
