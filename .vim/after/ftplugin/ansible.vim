set autoindent
set expandtab
set foldmethod=indent
set keywordprg=ansible-doc
set nofoldenable
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
let b:ale_linters = {'ansible': ['ansible_lint'], 'yaml': ['yamllint']}
let b:ale_fix_on_save_ignore = {'yaml': ['yamlfix']}

" vim: ft=vim ts=2 sts=2 sw=2 nosr et
