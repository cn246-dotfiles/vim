" Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use vim-plug for plugins.
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
call plug#end()

" Enable matchit
runtime macros/matchit.vim

"------------------------------------------------------------
" Colorscheme

" Lighten nord comment color
"augroup nord-theme-overrides
"  autocmd!
"  " Change foreground color for Vim comments.
"  autocmd ColorScheme nord highlight vimComment ctermfg=242 guifg=#6c6c6c
"augroup END

" Apply the nord colorscheme
colorscheme nord

"------------------------------------------------------------
"

" Enable syntax highlighting
syntax on

" Enable Omni Completion
set omnifunc=syntaxcomplete#Complete

" Re-use the same window and switch from an unsaved buffer without saving first.
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting)
set hlsearch

" Highlight as you type a search term
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Configure statusline
"set statusline=%.40F                   " Full file path (40 char max)
set statusline=%f                       " Full file path (40 char max)
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %m                    " Modified flag
set statusline+=%*                      " Restore default highlight
set statusline+=%=                      " Split the left and right sides
set statusline+=%l,                     " Line number
set statusline+=\                       " A space
set statusline+=%3c                     " Column number
set statusline+=\ \|\                   " A separator
set statusline+=%L                      " Total number of lines

" Ask if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" If visualbell is set, and this line is also included, vim will neither flash
" nor beep. If visualbell is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines
set cmdheight=2

" Display line numbers on the left counting away from cursor position
set relativenumber

" Highlight column 80
set colorcolumn=80

" Highlight current line
set cursorline

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Folding
set foldmethod=indent
set foldlevel=99

" Mark whitespace and tabs, etc.
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲

"------------------------------------------------------------
" File Browsing

" Don't show text at top of file tree
let g:netrw_banner=0

" Open in same buffer as existing file
let g:netrw_browse_split=4

" Set file tree at 20% of window width
let g:netrw_winsize=20

"------------------------------------------------------------
" Key Mappings

" Turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Set leader as spacebar
let mapleader=" "

" Move between splits with <space>+[h,j,k,l]
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Code folding
" nnoremap <leader> z

" Open file browser with <space>+pv
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 20<CR>

"------------------------------------------------------------
" Indentation

" Disable modeline
"set nomodeline
set modeline
set modelines=3

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Indentation settings for using 4 spaces instead of tabs
set shiftwidth=4
set softtabstop=4
set expandtab

" Flag unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufNewFile,BufRead *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"------------------------------------------------------------
" Prevent various Vim features from keeping the contents of pass(1) password
" files (or any other purely temporary files) in plaintext on the system.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>

" Don't backup files in temp directories or shm
if exists('&backupskip')
    set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" Don't keep swap files in temp directories or shm
if has('autocmd')
    augroup swapskip
        autocmd!
        silent! autocmd BufNewFile,BufReadPre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noswapfile
    augroup END
endif

" Don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
    augroup undoskip
        autocmd!
        silent! autocmd BufWritePre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noundofile
    augroup END
endif

" Don't keep viminfo for files in temp directories or shm
if has('viminfo')
    if has('autocmd')
        augroup viminfoskip
            autocmd!
            silent! autocmd BufNewFile,BufReadPre
                \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
                \ setlocal viminfo=
        augroup END
    endif
endif

