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
hi! link @variable GruvboxWhite
hi! link @constant GruvboxWhiteBold
hi! link @strong GruvboxWhiteBold
" Blue
hi! link @field GruvboxBlue
hi! link @label GruvboxBlueItalic
" Red
hi! link @include GruvboxRedBold
" Aqua
hi! link @title GruvboxAquaBold
hi! link @method GruvboxAquaBold
hi! link @function GruvboxAquaBold
" Yellow
hi! link @constructor GruvboxYellow
hi! link @type GruvboxYellowBold
" Purple
hi! link @parameter GruvboxPurpleItalic
hi! link @constant.builtin GruvboxPurpleBold
hi! link @type.builtin GruvboxPurpleBold
" Orange
hi! link @variable.builtin GruvboxOrange
