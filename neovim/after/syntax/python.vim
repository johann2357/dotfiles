" Manual highlight
" syn keyword pythonBuiltinConst True False None
" syn keyword pythonSelf self cls
" syn match pythonFunctionCall "\zs\(\k\w*\)*\s*\ze("
" syn match pythonFunctionKwarg "\zs\(\k\w*\)\ze="

" hi! link pythonExClass DraculaCyanItalic
" hi! link pythonBuiltinFunc DraculaCyanItalic
"
" hi! link pythonBuiltinConst Constant
" hi! link pythonFunctionCall GruvboxAquaBold
" hi! link pythonFunctionKwarg GruvboxBlue
" hi! link pythonSelf GruvboxOrangeBold

" Custom colors
hi GruvboxPurpleItalic guifg=#d3869b ctermfg=214 guibg=NONE ctermbg=NONE gui=italic cterm=italic

" TS stuff
" Blue
hi! link TSField GruvboxBlue
" Red
hi! link TSInclude GruvboxRedBold
" Aqua
hi! link TSMethod GruvboxAquaBold
hi! link TSFunction GruvboxAquaBold
" Yellow
hi! link TSConstructor GruvboxYellow
hi! link TSType GruvboxYellowBold
" Purple
hi! link TSParameter GruvboxPurpleItalic
hi! link TSConstBuiltin GruvboxPurpleBold
hi! link TSTypeBuiltin GruvboxPurpleBold
