function! s:require(condition, message)
  if a:condition
    call health#report_ok(a:message)
  else
    call health#report_error(a:message)
  endif
endfunction

function! health#warpcode#check() abort
  call health#report_start('Warpcode')
  call s:require(executable("curl"), 'Has curl installed')
endfunction
