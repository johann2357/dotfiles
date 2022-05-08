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

" TS stuff
hi! link TSField GruvboxBlue
hi! link TSInclude GruvboxRedBold
hi! link TSMethod GruvboxAquaBold
hi! link TSFunction GruvboxAquaBold
hi! link TSConstructor GruvboxYellow
hi! link TSParameter GruvboxYellow
hi! link TSType GruvboxYellowBold
hi! link TSConstBuiltin GruvboxPurpleBold
hi! link TSTypeBuiltin GruvboxPurpleBold
