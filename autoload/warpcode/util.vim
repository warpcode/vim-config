function! warpcode#util#getSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction


function! warpcode#util#prevChrIsSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
