set autoindent
set expandtab
set foldmethod=syntax
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
let g:sh_fold_enabled= 7
let b:ale_linters = {'sh': ['shellcheck']}
let b:ale_fixers = {'sh': ['shfmt']}
let g:ale_sh_shfmt_options = '--case-indent --indent 2 --space-redirects'
let b:ale_fix_on_save_ignore = {'sh': ['shfmt']}

" vim: ft=vim ts=2 sts=2 sw=2 sr et
