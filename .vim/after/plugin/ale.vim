if has_key(g:plugs, "ale")
  " Remove bad whitespace and trailing newlines on save
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace']
  \}

  " Enable ale fixers on save
  let g:ale_fix_on_save = 1
endif
