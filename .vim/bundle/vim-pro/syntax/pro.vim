" Vim syntax file
" Language:     Markdown
" Author:       Ben Williams <benw@plasticboy.com>


if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match

syntax keyword proString         yes no
syntax keyword proType     set_trail_single_step
syntax match   proVar      /\s\+\$\w\+/
syntax match   proCom      /@\w\+/

if version >= 508 || !exists("did_pro_syn_inits")
  if version < 508
    let did_pro_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

HiLink proString         Boolean
HiLink proType         String
HiLink proVar         Number
HiLink proCom         Label

delcommand HiLink
endif

let b:current_syntax = "pro"

" vim: tabstop=2
