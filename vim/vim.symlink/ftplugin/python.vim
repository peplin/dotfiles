let g:pylint_onwrite = 0
let g:pylint_show_rate = 0
let g:pylint_cwindow = 1
compiler pylint

map <F7> Ofrom ipdb import set_trace; set_trace(); # TODO<esc>
map <F8> Oimport traceback, sys; traceback.print_exception(*sys.exc_info()); # TODO<esc>
