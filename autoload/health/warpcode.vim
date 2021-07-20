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

  call health#report_start('warpcode#filteypes#php')
  call s:require(executable("php"), 'Has php installed')
  call s:require(executable("phpcs"), 'Has PHP code sniffer (phpcs) installed')
  call s:require(executable("phpcbf"), 'Has PHP code sniffer (phpcbf) installed')
endfunction
