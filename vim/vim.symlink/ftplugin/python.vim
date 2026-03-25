map <F7> Oimport pdb; pdb.set_trace(); # TODO<esc>

map <Leader>r :w\|:!python %:p<CR>

let b:ale_fixers = ['ruff', 'ruff_format']

set shiftwidth=2
" an indentation every four columns
set tabstop=2
