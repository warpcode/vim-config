" This is a playground of intersting configs to try

" https://github.com/sudormrfbin/cheatsheet.nvim

" " tpope/surround abent way of doing surrounds
" vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
" vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
" vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
" vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
" vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>

" " - Go on top of a word you want to change
" " - Press cn or cN
" " - Type the new word you want to replace it with
" " - Smash that dot '.' multiple times to change all the other occurrences of the word
" " It's quicker than searching or replacing. It's pure magic.
" nnoremap cn *``cgn
" nnoremap cN *``cgN

" " type in word/characters that i want to replace all instances
" nnoremap S :%s///g<Left><Left><Left>

" " Use this instead of touching Esc key
" inoremap jk <Esc>
" inoremap kj <Esc>

" " edit command
" cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" map <leader>ew :e %%
" map <leader>es :sp %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

" " Whitespaces and indentation
" function! Preserve(command)
" 	" Preparation: save last search, and cursor position.
" 	let _s=@/
" 	let l = line(".")
" 	let c = col(".")
" 	" Do the business:
" 	execute a:command
" 	" Clean up: restore previous search history, and cursor position
" 	let @/=_s
" 	call cursor(l, c)
" endfunction
" nnoremap <silent>_$ :call Preserve("%s/\\s\\+$//e")<CR>
" nnoremap <silent>_= :call Preserve("normal gg=G")<CR>


" " Great remaps! For the n/N centering, the only issue is that the first one your search goes to won't be centered. I found a solution for that on StackOverflow:
" function! CenterSearch()
"   let cmdtype = getcmdtype()
"   if cmdtype == '/' || cmdtype == '?'
"     return "\<enter>zz"
"   endif
"   return "\<enter>"
" endfunction

" cnoremap <silent> <expr> <enter> CenterSearch()

" " For vimmers who have wrap enabled:
" nnoremap <expr> j v:count ? v:count > 5 ? "m'" . v:count . 'j' : 'j' : 'gj'

" " Save only when changes are made
" nnoremap <F10> :up<CR>

" " Shows the changes made since last save
" nnoremap <Leader>C :w !diff % -<CR>

" " Quick word spelling corrections:
" " First corrects the word under the cursor with the first suggestion (for me, it is almost always correct one).
" " Second corrects previous misspelled word in the line with the first suggestion without leaving the insert mode.
" nmap \\ z=1<cr><cr>
" imap <C-\> <Esc>[sz=1<cr>A

" " Search and replace all for word under cursor.
" noremap <S-s> #:%s/<C-r>+//g<left><left>



