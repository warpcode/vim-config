function! warpcode#util#detectFileInParents(filename) abort
    " We need to search for the first instance of the file working up the tree from our file
    let current_dir = expand('%:p:h')
    let fullpath = fnamemodify(current_dir, ':p') . a:filename
    while !filereadable(fullpath)
        let current_dir_prev = current_dir
        let current_dir = fnamemodify(current_dir, ':h')

        if current_dir_prev == current_dir
            " we've hit the same path twice so return empty
            return ''
        endif

        let fullpath = fnamemodify(current_dir, ':p') . a:filename
    endwhile

    if filereadable(fullpath)
        return fullpath
    endif

    return ''
endfunction

function! warpcode#util#emptyRegisters() abort
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfunction

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
