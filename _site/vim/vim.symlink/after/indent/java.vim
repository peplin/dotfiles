" Monkey patch annotation support into the Java syntax support.
" http://stackoverflow.com/questions/200932/how-do-i-make-vim-indent-java-annotations-correctly
function! GetJavaIndent_improved()
    let theIndent = GetJavaIndent()
    let lnum = prevnonblank(v:lnum - 1)
    let line = getline(lnum)
    if line =~ '^\s*@.*$'
        let theIndent = indent(lnum)
    endif

    return theIndent
endfunction
setlocal indentexpr=GetJavaIndent_improved()
