set fileformat=unix
set foldmethod=indent
set autoindent
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Comments starts with # in Vim9 script.  We have to guess which one to use.
if "\n" .. getline(1, 10)->join("\n") =~# '\n\s*vim9\%[script]\>'
  setlocal commentstring=#\ %s
else
  setlocal commentstring=\"\ %s
endif
