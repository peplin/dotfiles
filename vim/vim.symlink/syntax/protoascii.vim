" Inspired by proto.vim.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match
syn keyword pbasciiTodo contained TODO FIXME XXX
syn cluster pbasciiCommentGrp contains=pbasciiTodo
syn region pbasciiComment start="#" skip="\\$" end="$" keepend contains=@pbasciiCommentGrp
syn region pbasciiString start=/"/ skip=/\\./ end=/"/
syn region pbasciiString start=/'/ skip=/\\./ end=/'/


if version >= 508 || !exists("did_proto_ascii_syn_inits")
  if version < 508
    let did_proto_ascii_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pbasciiTodo    Todo
  HiLink pbasciiComment      Comment
  HiLink pbasciiString       String

  delcommand HiLink
endif

let b:current_syntax = "protoascii"
