setlocal autoindent
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal expandtab
setlocal fileformat=unix
setlocal foldmethod=indent
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=79
let python_highlight_all=1
let b:ale_fixers = {'python': ['isort', 'black']}
let b:ale_fix_on_save_ignore = {'python': ['black']}
let g:ale_python_auto_virtualenv = 1

" vim: ft=vim ts=2 sts=2 sw=2 nosr et
