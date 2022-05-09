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
  hi SignColumn guibg=none
  hi CursorLineNR guibg=none
  highlight Normal guibg=none
endfun

call TurnOffTheLights()

" Custom colors
hi GruvboxPurpleItalic guifg=#d3869b ctermfg=214 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi GruvboxBlueItalic guifg=#83a598 ctermfg=109 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi GruvboxWhiteBold guifg=#f2e5bc ctermfg=228 guibg=NONE ctermbg=NONE gui=bold cterm=bold

" TS stuff
" White
hi! link TSConstant GruvboxWhiteBold
hi! link TSStrong GruvboxWhiteBold
" Blue
hi! link TSField GruvboxBlue
hi! link TSLabel GruvboxBlueItalic
" Red
hi! link TSInclude GruvboxRedBold
" Aqua
hi! link TSTitle GruvboxAquaBold
hi! link TSMethod GruvboxAquaBold
hi! link TSFunction GruvboxAquaBold
" Yellow
hi! link TSConstructor GruvboxYellow
hi! link TSType GruvboxYellowBold
" Purple
hi! link TSParameter GruvboxPurpleItalic
hi! link TSConstBuiltin GruvboxPurpleBold
hi! link TSTypeBuiltin GruvboxPurpleBold
