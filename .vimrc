"------------------------------------------------------------
" Table of Contents
"------------------------------------------------------------
" 01 - Vim-Plug
" 02 - Colorscheme
" 03 - General
" 04 - File Browsing
" 05 - Indentation
" 06 - Keyboard & Mouse
" 07 - Search
" 08 - Undo
" 09 - Visual Helpers & Statusline
" 10 - Whitespace
" 11 - Pastebins

"------------------------------------------------------------
" 01 - Vim-Plug
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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug '~/.vim/plugged/vim-redact-pass'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"Plug 'mattn/calendar-vim'
"Plug 'mattn/emmet-vim'
"Plug 'vimwiki/vimwiki'
call plug#end()

" Enable matchit
runtime macros/matchit.vim

"------------------------------------------------------------
" 02 - Colorscheme
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
  highlight Comment     ctermfg=245
  highlight vimComment  ctermfg=245
  highlight Visual      ctermbg=235
  highlight CursorLine  ctermbg=235
endfunction

augroup nordColors
  autocmd!
  autocmd ColorScheme nord call NordOverrides()
augroup END

" Configure default colors
function! DefaultOverrides() abort
  highlight Comment     ctermfg=245
  highlight vimComment  ctermfg=06
  highlight ColorColumn ctermbg=14  ctermfg=0
  highlight Search      ctermbg=02  ctermfg=234
  highlight Visual      ctermbg=14  ctermfg=08
  highlight CursorLine  cterm=NONE  ctermbg=06  ctermfg=234
  highlight DiffAdd     cterm=bold  ctermfg=236 ctermbg=10
  highlight DiffChange  cterm=bold  ctermfg=07  ctermbg=12
  highlight DiffDelete  cterm=bold  ctermfg=236 ctermbg=09
  highlight DiffText    cterm=bold  ctermfg=236 ctermbg=01
endfunction

augroup defaultColors
  autocmd!
  autocmd ColorScheme default call DefaultOverrides()
augroup END

"------------------------------------------------------------
" 03 - General
"------------------------------------------------------------
" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable syntax highlighting
syntax on

" Enable Omni Completion
set omnifunc=syntaxcomplete#Complete

" Re-use the same window and switch from an unsaved buffer without saving first
set hidden

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line
set nostartofline

" Ask if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" If visualbell is set & this line is included, vim will neither flash nor beep
set t_vb=

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

"------------------------------------------------------------
" 04 - File Browsing
"------------------------------------------------------------
" Don't show text at top of file tree
let g:netrw_banner=0

" Open in same buffer as existing file
let g:netrw_browse_split=4

" Set file tree at 25% of window width
let g:netrw_winsize=25

"------------------------------------------------------------
" 05 - Indentation
"------------------------------------------------------------
" Enable modeline
set modeline
set modelines=3

" Attempt to determine the type of a file based on its name and its contents
filetype indent plugin on

" Keep the same indent as the line you're currently on
set autoindent

" Use 2 spaces instead of tabs
set shiftwidth=2
set softtabstop=2
set expandtab

"------------------------------------------------------------
" 06 - Keyboard & Mouse
"------------------------------------------------------------
" Enable use of the mouse for all modes
set mouse=a

" Set leader as spacebar
let mapleader=" "

" Show contents of buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

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
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 20<CR>

" Save and run last command
nnoremap <leader>r :w<CR>:!!<CR>

" Turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

"------------------------------------------------------------
" 07 - Search
"------------------------------------------------------------
" Highlight searches (use <C-L> to temporarily turn off highlighting)
set hlsearch

" Highlight as you type a search term
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"------------------------------------------------------------
" 08 - Undo
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

" undofile part of your .vimrc
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
" 09 - Visual Helpers & Statusline
"------------------------------------------------------------
" Mark whitespace and tabs, etc.
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Folding
set foldmethod=manual
set nofoldenable

" Show partial commands in the last line of the screen
set showcmd

" Display line numbers on the left counting away from cursor position
set relativenumber

" Highlight column 80
set colorcolumn=80

" Highlight current line
set cursorline

" Set the command window height to 2 lines
set cmdheight=2

" Better command-line completion
set wildmenu
set wildmode=list

" Display cursor position in the status line
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Configure statusline
set statusline=%f                         " Filepath
set statusline+=\                         " A space
set statusline+=%y                        " Filetype
set statusline+=\ %{FugitiveStatusline()} " Current branch & edited file's commit
set statusline+=\ %m                      " Modified flag
set statusline+=%*                        " Restore default highlight
set statusline+=%=                        " Split the left and right sides
set statusline+=%l,                       " Line number
set statusline+=\                         " A space
set statusline+=%3c                       " Column number
set statusline+=\ \|\                     " A separator
set statusline+=%L                        " Total number of lines

"------------------------------------------------------------
" 10 - Whitespace
"------------------------------------------------------------
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

noremap <leader>w :call TrimWhitespace()<CR>

" Flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"------------------------------------------------------------
" Pastebins
" https://gist.github.com/romainl/1cad2606f7b00088dda3bb511af50d53
"------------------------------------------------------------
if has('osx')
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
elseif has('linux')
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
endif

" vim: ft=vim ts=2 sts=2 sw=2 sr et
