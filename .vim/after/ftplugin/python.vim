set autoindent
set cinwords=if,elif,else,for,while,try,except,finally,def,class
set expandtab
set fileformat=unix
set foldmethod=indent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=79
let python_highlight_all=1
let b:ale_fixers = {'python': ['isort', 'black']}
let b:ale_fix_on_save_ignore = {'python': ['black']}
let g:ale_python_auto_virtualenv = 1