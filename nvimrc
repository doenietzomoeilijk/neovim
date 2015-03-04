" vim: set filetype=vim foldmethod=marker foldlevel=1 foldcolumn=0 et tw=78:"{{{

" Plug {{{
call plug#begin('~/.nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'mattn/ctrlp-register'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'raimondi/delimitMate'
Plug 'rking/ag.vim'
" Plug 'SirVer/ultisnips'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
call plug#end()
" }}}

set encoding=utf-8
let mapleader = ","
set shortmess+=I
set history=10000
set undolevels=10000

" CtrlP {{{
nnoremap <leader>r !Ccal ctrlp#init(ctrlp#register#id())!CtrlPRegisterCtrlPRegister
" }}}

" UI {{{
if &term =~ "xterm" 
    set t_Co=256
elseif &term =~ "256color"
    set t_Co=256
endif

" Clearing using background colour -- needed inside tmux.
set t_ut=

set bg=dark
" colorscheme xoria256
let g:rehash256=1
let g:molokai_original=1
" colorscheme molokai
colorscheme solarized
" set bg=light

" A nice EOL guide column.
if exists("&colorcolumn")
  set colorcolumn=+1,+41
  " hi ColorColumn ctermbg=237 guibg=#232526
endif

set ruler
set number
nnoremap <leader>nn :set number!<CR>

if exists("&relativenumber")
    set relativenumber
    nnoremap <leader>NN :set relativenumber!<CR>
endif 

set cursorline
nnoremap <leader>c :set cursorline!<CR>
nnoremap <leader>C :set cursorcolumn!<CR>

set backspace=2

" Give us some room for feedback. Prevents 90% of 'Press enter to continue'.
set laststatus=2
set cmdheight=3

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" End the bell terror
set noerrorbells visualbell t_vb=
augroup NoVisualBellFluff
    autocmd!
    autocmd GUIEnter * set vb t_vb=
augroup END

" Casing and wrapping
set ignorecase smartcase
set nowrap " We just CODE to the correct width, bitches!
set whichwrap+=<,>,h,l
set linebreak
set showbreak=~\ \ \ 

" Split stuff
set equalalways
set eadirection=hor
set splitright

" Folding
set foldmethod=syntax
set foldlevel=999
set foldcolumn=3

" Allow us to switch away from buffers with changes in them.
set hidden

" Toggle invisible chars
noremap <leader>i :set list!<CR>

" Oh, wait, we have a mouse.
set mouse=a

" Who uses ex mode anyway?
nnoremap Q @q
command! W w
command! Q q
command! Wq wq

set wildmenu
set wildmode=list:longest,full

set viewoptions-=options
augroup UI
    autocmd!

    " autocmd BufWritePost *
    " \   if expand('%') != '' && &buftype !~ 'nofile'
    " \|      mkview
    " \|  endif
    " autocmd BufRead *
    " \   if expand('%') != '' && &buftype !~ 'nofile'
    " \|      silent loadview
    " \|  endif

    " Resize windows on metawindow resize
    autocmd VimResized * exe "normal! \<C-w>="
augroup END

" Visually select the last edited/pasted/... text.
nnoremap gV `[v`]

" Movement {{{
" Quick jumping between splits and buffers
" nnoremap <C-J> <C-W>j
" nnoremap <C-K> <C-W>k
" nnoremap <C-H> <C-W>h
" nnoremap <C-L> <C-W>l

" H is easier to reach than ^
nnoremap H ^
nnoremap L g_

" For everyone who uses wrap
nnoremap j gj
nnoremap k gk

" Why didn't I think of these earlier?
inoremap <C-E> <End>
inoremap <C-A> <Home>

" Highlighting search
set showmatch
set matchpairs+=<:>
set hlsearch
set incsearch

nnoremap <leader>n :nohlsearch<CR> " Setting it to enter mucked with error windows.
noremap <leader>h :let @/ = ""<CR> " clear search pattern to disable hlsearch

" Enable matchit.vim to make % even more useful.
runtime macros/matchit.vim
" }}}

" Editing {{{
" Uppercase / lowercase current word
nnoremap <Leader>U viwU
nnoremap <Leader>u viwu

" Write with sudo
cnoremap w!! w !sudo tee % >/dev/null

" Paste with auto-indent
nnoremap <Leader>p p'[v']=
nnoremap <Leader>P P'[v']=
nnoremap <Leader>pp :set paste!<CR>

" Shortcut for CTRL_X modes, straight from the Vim docs.
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

" If I want help, I'll ask for it (instead of inadvertly hit my F1 when I
" actually wanted ESC)
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Faster escape
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" See :help fo-table for letter meaning
set formatoptions=lcqn
" }}}

" Coding defaults {{{
set tabstop=4
set shiftwidth=4
set nosmartindent " As smartindent conflicts with filetype
set nocindent
set smarttab
set expandtab
set shiftround
set textwidth=80
" }}}
" }}}

" Files {{{
set directory=/tmp//
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline_inactive_collapse=1
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_alt_sep = '⮁'
let g:airline_left_sep = '⮀'
let g:airline_right_alt_sep = '⮃'
let g:airline_right_sep = '⮂'
let g:airline_section_y = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.whitespace = 'Ξ'

if has('nvim')
    " set unnamedclip
endif
" }}}

" Editing the nvimrc file {{{
" From http://github.com/devjj/vim-config/blob/master/.vimrc After editing, run
augroup Vimrc
    autocmd!
    autocmd FileType vim setlocal keywordprg=:help

    autocmd BufWritePost $MYVIMRC source $MYVIMRC | exec 'echom "nvimrc reloaded after save."'

    if (exists(':AirlineRefresh'))
        autocmd BufWritePost $MYVIMRC AirlineRefresh
    endif
augroup END

noremap <Leader>vv :vsplit $MYVIMRC<CR>
noremap <Leader>V :source $MYVIMRC<CR>:filetype detect<CR>:echom 'nvimrc reloaded'<CR>
" }}}
