map <F7> Ofrom pdb import set_trace; set_trace(); # TODO<esc>
map <F8> Oimport traceback, sys; traceback.print_exception(*sys.exc_info()); # TODO<esc>

map <Leader>r :w\|:!python %:p<CR>
