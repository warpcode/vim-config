function! s:require(condition, message)
  if a:condition
    call health#report_ok(a:message)
  else
    call health#report_error(a:message)
  endif
endfunction

function! health#warpcode#check() abort
  call health#report_start('warpcode')
  call s:require(executable("curl"), 'Has curl installed')
  call s:require(executable("rg"), 'Has ripgrep installed')
  call s:require(executable("make"), 'Has make installed')
  call s:require(executable("npm"), 'Has npm installed')
  call s:require(executable("php"), 'Has php installed')
endfunction

