map <F2> :e %:p:s,.hh$,.X123X,:s,.cc$,.hh,:s,.X123X$,.cc,<CR>

" For work
" Disable textwidth otherwise using clang-format with formatexpr breaks insert
" mode
" set textwidth=120
set colorcolumn=120

map <F5> /\%>120v.\+<CR>
