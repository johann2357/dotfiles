syn keyword pythonBuiltinConst True False None
syn match pythonFunctionCall "\zs\(\k\w*\)*\s*\ze("
syn match pythonFunctionKwarg "\zs\(\k\w*\)\ze="
syn match pythonGlobalVar "\zs\([A-Z][A-Z0-9_]\+\)\ze"

hi! link pythonExClass DraculaCyanItalic
hi! link pythonBuiltinFunc DraculaCyanItalic
hi! link pythonBuiltinConst Constant
hi! link pythonFunctionCall Function
hi! link pythonFunctionKwarg DraculaOrangeItalic
hi! link pythonSelf DraculaOrangeItalic
