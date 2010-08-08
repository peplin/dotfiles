" Written by steven for quick loadup of Markdown text into HTML
function Mkdp()
  write
  let file   = expand("%")
  let mkd_file = file . ".html"
  let result = system("markdown " . file . " > " . mkd_file)
  let result = system("chromium-browser " . mkd_file)
endfunction
:map :mm :call Mkdp()<CR>
