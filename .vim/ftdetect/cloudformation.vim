"au BufNewFile,BufRead *.cfn.yml set filetype=yaml.cloudformation
au BufNewFile,BufRead * if getline(1) =~ '^AWSTemplateFormatVersion:'
      \| setlocal filetype=yaml.cloudformation
      \| endif
