"------------------------------------------------------------
" Plugins
"------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use vim-plug for plugins.
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
Plug '~/.local/src/fzf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug '~/.vim/plugged/vim-redact-pass'
"Plug 'mattn/emmet-vim'
call plug#end()

" Enable matchit
runtime macros/matchit.vim

"------------------------------------------------------------
" Colorscheme
"------------------------------------------------------------
" Set colorscheme
if $SSH_CONNECTION
    colorscheme default
else
    colorscheme nord
endif

" Lighten nord comment color
function! NordOverrides() abort
    autocmd!
    highlight Comment     cterm=none  ctermbg=none ctermfg=245
    highlight Error       cterm=bold  ctermbg=none ctermfg=9
    highlight Visual      cterm=none  ctermbg=234  ctermfg=3
    highlight vimComment  cterm=none  ctermbg=none ctermfg=245
    if &diff
        highlight CursorLine cterm=reverse ctermbg=252 ctermfg=0
    else
        highlight CursorLine cterm=none    ctermbg=235 ctermfg=none
    endif
endfunction

augroup nordColors
    autocmd!
    autocmd ColorScheme nord call NordOverrides()
augroup END

" Configure default colors
function! DefaultOverrides() abort
    highlight ColorColumn cterm=none  ctermbg=14   ctermfg=0
    highlight Comment     cterm=none  ctermbg=none ctermfg=245
    highlight CursorLine  cterm=none  ctermbg=06   ctermfg=234
    highlight DiffAdd     cterm=bold  ctermbg=10   ctermfg=236
    highlight DiffChange  cterm=bold  ctermbg=12   ctermfg=07
    highlight DiffDelete  cterm=bold  ctermbg=09   ctermfg=236
    highlight DiffText    cterm=bold  ctermbg=01   ctermfg=236
    highlight Error       cterm=none  ctermbg=1    ctermfg=0
    highlight Search      cterm=none  ctermbg=02   ctermfg=234
    highlight Visual      cterm=none  ctermbg=14   ctermfg=08
    highlight vimComment  cterm=none  ctermbg=none ctermfg=06
endfunction

augroup defaultColors
    autocmd!
    autocmd ColorScheme default call DefaultOverrides()
augroup END

"------------------------------------------------------------
" General
"------------------------------------------------------------
filetype indent plugin on              " Guess filetype based on name & contents
set autoindent                         " Keep same indent as the line you're on
set backspace=indent,eol,start         " Backspace over indent, eol and start
set complete+=kspell                   " Set matches for completion
" set completeopt=menuone,noinsert       " Options for completion
set completeopt=menuone                " Options for completion
set confirm                            " Ask to save changed files
set dictionary+=/usr/share/dict/words  " Set dictionary file location
set encoding=utf8                      " Set utf8 as standard encoding
set expandtab                          " Use spaces instead of tabs
set ffs=unix,dos,mac                   " Set Unix as standard file type
set hidden                             " Switch buffers without saving first
set hlsearch                           " Highlight searches
set ignorecase                         " Use case insensitive search
set incsearch                          " Highlight as you type a search term
set mouse=a                            " Enable use of the mouse for all modes
set nospell                            " Disable spellcheck
set nostartofline                      " Stop going to first character of line
set notimeout ttimeout ttimeoutlen=200 " Time out on keycodes, but not mappings
set omnifunc=syntaxcomplete#Complete   " Enable Omni Completion
set previewheight=25                   " Bigger preview window (eg. ALEInfo)
set shiftwidth=2                       " Set column number for indentation
set shortmess+=c                       " Avoid some error messages
set smartcase                          " Except when using capital letters
set softtabstop=2                      " Use 2 spaces instead of tabs
set spelllang=en_us                    " Set spellcheck to en_us
set splitbelow                         " Send splits to bottom
set splitright                         " Send splits to right
set t_vb=                              " Neither flash nor beep
set visualbell                         " Visual bell instead of beeping
syntax on                              " Enable syntax highlighting

"------------------------------------------------------------
" Visual Helpers
"------------------------------------------------------------
set cmdheight=2                        " Set command window height to 2 lines
set colorcolumn=80                     " Highlight column 80
set cursorline                         " Highlight current line
" set foldcolumn=2                       " Show folds in sidebar
set foldmethod=indent                  " Fold method
set laststatus=2                       " Always display the status line
set list                               " Mark whitespace and tabs, etc.
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set modeline                           " Set filetype and indentation via comment
set modelines=3                        " Look for modeline in bottom 3 lines
set nofoldenable                       " Don't fold initially
set relativenumber                     " line numbers counting away from cursor
set ruler                              " Cursor position in the status line
set showcmd                            " Show commands in last line of screen
set wildmenu                           " Better command-line completion
set wildmode=longest:full,full         " Completion mode

"------------------------------------------------------------
" Statusline
"------------------------------------------------------------
set statusline=%f                         " Filepath
set statusline+=\                         " A space
set statusline+=%y                        " Filetype
set statusline+=\ %{FugitiveStatusline()} " Current branch & edited file's commit
set statusline+=\ %m                      " Modified flag
set statusline+=%*                        " Restore default highlight
set statusline+=%=                        " Split the left and right sides
set statusline+=%3c                       " Column number
set statusline+=\ \|\                     " A separator
set statusline+=\                         " A space
set statusline+=%l/%L                     " Line number/Total lines
set statusline+=\                         " A space
set statusline+=%p%%                      " Position in percentage
set statusline+=\                         " A space

"------------------------------------------------------------
" File Browsing
"------------------------------------------------------------
let g:netrw_banner=0                   " Don't show text at top of file tree
let g:netrw_browse_split=4             " Open in same buffer as existing file
let g:netrw_winsize=25                 " Set file tree at 25% of window width

"------------------------------------------------------------
" ALE
"------------------------------------------------------------
" Navigate ALE errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Run :ALEFix
nnoremap <leader>af :ALEFix<CR>

" Toggle ALE
map <leader>at :ALEToggle<CR>

"------------------------------------------------------------
" FZF
" https://github.com/junegunn/fzf.vim/issues/837#issuecomment-1582511811
"------------------------------------------------------------
if executable('fzf')
  let $FZF_DEFAULT_OPTS="--preview-window 'right:57%'
      \ --preview 'bat --style=numbers --line-range :300 {}'
      \ --bind ctrl-y:preview-up,ctrl-e:preview-down
      \ --bind ctrl-u:preview-half-page-up
      \ --bind ctrl-d:preview-half-page-down
      \ --bind ctrl-w:toggle-preview-wrap
      \ --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down
      \ --bind shift-up:preview-top,shift-down:preview-bottom
      \ --bind alt-up:half-page-up,alt-down:half-page-down"

  command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

  command! -bang -nargs=* -complete=custom,RgComplete Rgf
      \ call fzf#vim#grep(
      \   'rg --hidden --max-count 1 --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
      \   fzf#vim#with_preview({
      \     'dir': system(
      \       'git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]
      \     }), <bang>0)

  function RgComplete (A,L,P)
      echom a:A[0]
      if (a:A[0] == '-')
          return system("rg -h | grep '\\-.\\?[0-9A-Za-z-]*' -o | sort -u")
      endif
      if (a:A[0:1] == './')
          return globpath('.', a:A[2:]..'*')
      endif
  endfunction

  nnoremap <leader>b :Buffers<CR>
else
  nnoremap <leader>b :buffers<CR>:buffer<Space>
endif

"------------------------------------------------------------
" Mappings
"------------------------------------------------------------
" Set leader to spacebar
let mapleader=" "

" Source Vim config file.
nnoremap <leader>sv :source $MYVIMRC<CR>

" Move between splits with <space>+[h,j,k,l]
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Copy/paste
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Open file browser with <space>+pv
nnoremap <leader>pv :Lexplore<CR>

" Tab navigaton
" TODO: this cycles through actual terminal tabs, not vim tabs.
" nnoremap <C-S-TAB> :tabprevious<CR>
" nnoremap <C-TAB>   :tabnext<CR>

" Turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Tab to cycle autocomplete selections
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" Use <F11> to toggle paste
set pastetoggle=<F11>

"------------------------------------------------------------
" Modeline
" https://vim.fandom.com/wiki/Modeline_magic#Adding_a_modeline
"------------------------------------------------------------
function! AppendModeline()
    let l:modeline = printf("vim: ft=%s ts=%d sts=%d sw=%d %ssr %set",
        \ &filetype, &tabstop, &softtabstop, &shiftwidth,
        \ &shiftround ? '' : 'no', &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), "")
    call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"------------------------------------------------------------
" Pastebins
" https://gist.github.com/romainl/1cad2606f7b00088dda3bb511af50d53
"------------------------------------------------------------
if has('linux')
    command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh
        \| tr -d '\n' | xclip -i -selection clipboard
    command! -range=% TB <line1>,<line2>w !nc termbin.com 9999
        \| tr -d '\n' | xclip -i -selection clipboard
elseif has('osx')
    command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us
        \| tr -d '\n' | pbcopy
    command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com
        \| tr -d '\n' | pbcopy
    command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net
        \| tr -d '\n' | pbcopy
    command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1
        \| tr -d '\n' | pbcopy
    command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io
        \| tr -d '\n' | pbcopy
    command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh
        \| tr -d '\n' | pbcopy
    command! -range=% TB <line1>,<line2>w !nc termbin.com 9999
        \| tr -d '\n' | pbcopy
endif

"------------------------------------------------------------
" Registers
" https://stackoverflow.com/a/39348498
"------------------------------------------------------------
function! ClearRegs() abort
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, @_)
    endfor
endfunction

command! Cleareg call ClearRegs()

"------------------------------------------------------------
" Spellcheck
"------------------------------------------------------------
" Toggle spell check.
nnoremap <F5> :setlocal spell!<CR>

" Compile wordlists in case of manual changes or new files
function! SpellUpdate()
  for d in globpath(&runtimepath, "spell/*.add", 0, 1)
      execute "mkspell! " . fnameescape(d)
  endfor
endfunction
command! SpellUpdate call SpellUpdate()

"------------------------------------------------------------
" Sudo
"------------------------------------------------------------
function! Sudow()
    :w !sudo tee % > /dev/null
endfunction

command! Sudow call Sudow()

"------------------------------------------------------------
" Terminal
"------------------------------------------------------------
nmap <F6> :tab :term ++close<CR>
tnoremap <F6> <C-W>N

" vim-powered terminal in split window
map <Leader>t :term ++close<cr>

" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>

"------------------------------------------------------------
" Undo
"------------------------------------------------------------
function Tmpwatch(path, days)
    let l:path = expand(a:path)
    if isdirectory(l:path)
        for file in split(globpath(l:path, "*"), "\n")
            if localtime() > getftime(file) + 86400 * a:days && delete(file) != 0
                echo "Tmpwatch(): Error deleting '" . file . "'"
            endif
        endfor
    else
        echo "Tmpwatch(): Directory '" . l:path . "' not found"
    endif
endfunction

if exists("+undofile")
    if !isdirectory($HOME . '/.vimundo')
        call mkdir($HOME . "/.vimundo", "", 0700)
    endif
    set undodir=~/.vimundo//
    set undofile
    set undolevels=1000
    set undoreload=10000

    " remove undo files which have not been modified for 31 days
    call Tmpwatch(&undodir, 31)
endif

"------------------------------------------------------------
" Whitespace
"------------------------------------------------------------
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

noremap <leader>w :call TrimWhitespace()<CR>

" Flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufNewFile,BufRead *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" vim: set ft=vim ts=2 sts=2 sw=2 nosr et
