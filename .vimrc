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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug '~/.vim/plugged/vim-redact-pass'
Plug 'vim-scripts/AutoComplPop'
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"Plug 'mattn/calendar-vim'
"Plug 'mattn/emmet-vim'
"Plug 'vimwiki/vimwiki'
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
" General
"------------------------------------------------------------
filetype indent plugin on              " Guess filetype based on name & contents
set autoindent                         " Keep same indent as the line you're on
set backspace=indent,eol,start         " Backspace over indent, eol and start
set complete+=kspell                   " Set matches for completion
set completeopt=menuone,longest        " Options for completion
set confirm                            " Ask to save changed files
set encoding=utf8                      " Set utf8 as standard encoding
set expandtab                          " Use spaces instead of tabs
set ffs=unix,dos,mac                   " Set Unix as standard file type
set hidden                             " Switch buffers without saving first
set hlsearch                           " Highlight searches
set ignorecase                         " Use case insensitive search
set incsearch                          " Highlight as you type a search term
set modeline                           " Enable modeline
set modelines=3                        " Bottom 3 lines for modeline
set nospell                            " Disable spellcheck
set nostartofline                      " Stop going to first character of line
set notimeout ttimeout ttimeoutlen=200 " Time out on keycodes, but not mappings
set omnifunc=syntaxcomplete#Complete   " Enable Omni Completion
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
set foldmethod=manual                  " Fold method
set laststatus=2                       " Always display the status line
set list                               " Mark whitespace and tabs, etc.
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set nofoldenable                       " Don't fold initially
set relativenumber                     " line numbers counting away from cursor
set ruler                              " Cursor position in the status line
set showcmd                            " Show commands in last line of screen
set wildmenu                           " Better command-line completion
set wildmode=list,longest              " Completion mode

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
set statusline+=%l,                       " Line number
set statusline+=\                         " A space
set statusline+=%3c                       " Column number
set statusline+=\ \|\                     " A separator
set statusline+=%L                        " Total number of lines

"------------------------------------------------------------
" File Browsing
"------------------------------------------------------------
let g:netrw_banner=0                   " Don't show text at top of file tree
let g:netrw_browse_split=4             " Open in same buffer as existing file
let g:netrw_winsize=25                 " Set file tree at 25% of window width

"------------------------------------------------------------
" Keyboard & Mouse
"------------------------------------------------------------
" Set leader to spacebar
let mapleader=" "

" Enable use of the mouse for all modes
set mouse=a

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

"" Source Vim config file.
nnoremap <leader>sv :source $MYVIMRC<CR>

" Turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Toggle spell check.
nnoremap <F5> :setlocal spell!<CR>

" Use <F11> to toggle paste
set pastetoggle=<F11>

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
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

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

" vim: ft=vim ts=2 sts=2 sw=2 sr et
