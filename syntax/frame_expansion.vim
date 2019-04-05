if exists("b:current_syntax")
  finish
endif

syn keyword feKeyword relation parent if

syn match feOperator ":="
syn match feNumber "\v<\d+>"
syn match feFeatName "\.[A-Za-z_]\+"
syn match feBuiltin "builtin::"
syn match feSliceNumber "\[\\\"\-?[0-9]\+\\\"\]" contained

syn region feComment start=/\/\// end=/$/ oneline
syn region feFeatures start=/feature/ end=/]/ oneline
syn region feString start=/\"/ skip=/\\"/ end=/\"/
syn match feTerm "term\[[0-9]\+\]"

syn match feTkid "\[[^(),]\+\]"

hi def link feKeyword Keyword
hi def link feOperator Keyword
hi def link feFeatures Define
hi def link feNumber Number
hi def link feString String
hi def link feTkid String
hi def link feFeatName Exception
hi def link feComment Comment
hi def link feTerm Constant
hi def link feBuiltin Typedef
hi def link feSliceNumber Ignore
