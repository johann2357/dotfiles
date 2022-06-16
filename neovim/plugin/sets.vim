" dynamic stuff
fun! ToggleWinbar()
  echo(&winbar)
  if len(&winbar) == 0
    set winbar=%=%R\ %M\ %f
  else
    set winbar=
  endif
endfun
