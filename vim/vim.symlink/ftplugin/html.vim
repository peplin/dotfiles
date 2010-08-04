" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
set formatoptions+=tl

set makeprg=~/bin/validate-html.sh\ %
set errorformat=%f:%l.%c-%m

set shiftwidth=4
