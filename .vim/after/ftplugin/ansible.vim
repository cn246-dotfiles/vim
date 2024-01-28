setlocal autoindent
setlocal expandtab
setlocal foldmethod=indent
setlocal keywordprg=ansible-doc
setlocal nofoldenable
setlocal shiftround
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
let b:ale_linters = {'ansible': ['ansible_lint'], 'yaml': ['yamllint']}
let b:ale_fix_on_save_ignore = {'yaml': ['yamlfix']}

" vim: ft=vim ts=2 sts=2 sw=2 nosr et
