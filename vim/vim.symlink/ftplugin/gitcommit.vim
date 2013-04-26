function! JumpToFirstLine()
    " Always jump to first line, even if there was a saved cursor.
    call setpos('.', [0, 1, 1, 0])
endfunction
au BufEnter * call JumpToFirstLine()
set textwidth=72
