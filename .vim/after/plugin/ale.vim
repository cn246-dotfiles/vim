if has_key(g:plugs, "ale")
  " Enable ale fixers on save
  let g:ale_fix_on_save = 0

  " Fixers to use when calling ALEFix
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'markdown': [],
  \   'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace'],
  \   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
  \   'yaml': ['yamlfix', 'remove_trailing_lines', 'trim_whitespace'],
  \}

  " Fixers to ignore with fix on save
  let g:ale_fix_on_save_ignore = {
  \   'markdown': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black'],
  \   'sh': ['shfmt'],
  \   'yaml': ['yamlfix']
  \}

  " Linters to enable
  let g:ale_linters = {
  \   'ansible': ['ansible_lint'],
  \   'cloudformation': ['cloudformation'],
  \   'json': ['jq'],
  \   'python': ['pylint', 'ruff'],
  \   'sh': ['shellcheck'],
  \   'yaml': ['yamllint']
  \}

  " Configure shfmt
  let g:ale_sh_shfmt_options = '--case-indent --indent 2 --space-redirects'

  " Python virtual envs
  let g:ale_python_auto_virtualenv = 1

endif

" vim: ft=vim ts=2 sts=2 sw=2 nosr et
