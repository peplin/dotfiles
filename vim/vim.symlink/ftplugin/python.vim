map <F7> Oimport pdb; pdb.set_trace(); # TODO<esc>

map <Leader>r :w\|:!python %:p<CR>

let b:ale_fixers = ['ruff', 'ruff_format']
