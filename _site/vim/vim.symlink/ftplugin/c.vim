" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
set formatoptions+=ro
map <F2> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
map <F3> :vsp %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
