let g:gruvbox_italic='1'
let g:gruvbox_italicize_strings='1'
let g:gruvbox_invert_selection='0'

fun! TurnOnTheLights()
  let g:gruvbox_contrast_dark='soft'
  set background=light
  colorscheme gruvbox
endfun

fun! TurnOffTheLights()
  let g:gruvbox_contrast_dark='hard'
  set background=dark
  colorscheme gruvbox
endfun

call TurnOffTheLights()
