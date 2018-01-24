" Vim syntax file
" Language:     QuakeC
" Maintainer:   Robert Siska <github.com/RobSis>
" Last Change:  2013 Mar 03

" Quit when a (custom) syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif


" Keywords and statements
syn keyword     qcStatement     if else while do return
syn keyword     qcTodo          contained TODO FIXME XXX
syn keyword     qcQuaked        contained QUAKED

syn keyword     qcType          void float vector string entity
syn keyword     qcStorageClass  local

syn keyword     qcConstant      TRUE FALSE


" Literals
syn match       qcNumbers       display transparent "\<\d\|\.\d" contains=qcNumber,qcHexNumber
syn match       qcHexNumber     display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match       qcNumber        display contained "\([0-9]\+\(\.[0-9]*f\=\)\=\|\.[0-9]\+f\=\)\>"
syn region      qcVector        display oneline start=+'+ end=+'+ keepend contains=@Spell

syn region      qcString        start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=qcSpecial,@Spell
syn match       qcSpecial       display contained "\\\(x\x\+\|.\|$\)"

syn match       qcBuiltin       display "\#\d\+"
syn match       qcFrame         display "\$[^\d\W]\w*\>"
syn match       qcPragma        display "\$\(flags\|base\|cd\|frame\|modelname\|origin\|scale\|skin\)\>"


" Comments
syn cluster     qcCommentGroup  contains=qcTodo,qcQuaked
syn region      qcLineComment   start="//" skip="\\$" end="$" keepend contains=@qcCommentGroup,@Spell
syn region      qcComment       start="/\*" end="\*/" contains=@qcCommentGroup,@Spell fold extend

" Match comments that start out of screen
if !exists("quakec_minlines")
  let quakec_minlines = 10
endif
exec "syn sync ccomment qcComment minlines=" . quakec_minlines


" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
if version >= 508 || !exists("did_quakec_syn_inits")
    if version < 508
        let did_quakec_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink qcLineComment        qcComment
    HiLink qcComment            Comment
    HiLink qcString             String
    HiLink qcSpecial            SpecialChar
    HiLink qcNumber             Number
    HiLink qcVector             String
    HiLink qcFrame              Number
    HiLink qcBuiltin            PreProc
    HiLink qcPragma             PreProc
    HiLink qcType               Type
    HiLink qcStorageClass       StorageClass
    HiLink qcStatement          Statement
    HiLink qcConstant           Constant

    HiLink qcTodo               Todo
    HiLink qcQuaked             Label

    delcommand HiLink
endif

let b:current_syntax = "quakec"
