map <F2> :e %:p:s,.hh$,.X123X,:s,.cc$,.hh,:s,.X123X$,.cc,<CR>

" For work
" Disable textwidth otherwise using clang-format with formatexpr breaks insert
" mode
set textwidth=0
set colorcolumn=120

map <F5> /\%>120v.\+<CR>

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
set formatoptions+=ro
