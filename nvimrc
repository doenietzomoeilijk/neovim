" vim: set filetype=vim foldmethod=marker foldlevel=0 foldcolumn=0 et tw=78:

let mapleader=","
let maplocalleader=","
set shortmess+=I
set history=10000
set undolevels=10000
" set encoding="unicode"

" Plug {{{
call plug#begin('~/.config/nvim/plugged')
" Bling
" Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'

" UI
Plug 'kien/ctrlp.vim'
Plug 'mattn/ctrlp-register'
Plug 'moll/vim-bbye'
Plug 'jaxbot/semantic-highlight.vim'

" Filetypes
Plug 'elzr/vim-json'
Plug 'jeanmenezes/vim-jinja'
Plug 'docker/docker'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ap/vim-css-color'
Plug 'freitass/todo.txt-vim'
Plug 'cyberkov/openhab-vim'

" Integration
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

Plug 'phpactor/phpactor'

" Editing
if has("python")
    " Only do these if we have python, otherwise this trips balls on some
    " setups.
    " Plug 'SirVer/ultisnips'
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
endif

if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  " Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Plug 'mkusher/padawan'
" Plug 'mkusher/padawan-symfony'
" Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }

Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'raimondi/delimitMate'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
" }}}

" NeoVim {{{
if has('nvim')
    " set unnamedclip
endif
" }}}

" CtrlP {{{
" nnoremap <leader>r !Ccal ctrlp#init(ctrlp#register#id())!CtrlPRegisterCtrlPRegister
nnoremap <leader>m :CtrlPMRUFiles<CR>
" nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>q :CtrlPQuickfix<CR>
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
" colorscheme molokai
" colorscheme solarized
let g:rehash256=1
let g:molokai_original=1
colorscheme PaperColor
"colorscheme material-theme
hi Comment cterm=ITALIC gui=italic

" A nice EOL guide column.
if exists("&colorcolumn")
  set colorcolumn=+1,+41
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
set showbreak=↪︎\ 
set breakindent

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

set fillchars=vert:│,fold:-
highlight VertSplit cterm=none ctermbg=none ctermfg=247
" }}}

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
" nnoremap <CR> :nohlsearch<CR>
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
set fdm=indent
" }}}

" Files {{{
set directory=/tmp//
" File types: htmljinja {{{
augroup Htmljinja
    autocmd!
    autocmd FileType twig setlocal ft=htmljinja
augroup END
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline_inactive_collapse=1
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
" }}}

" Editing the nvimrc file {{{
" From http://github.com/devjj/vim-config/blob/master/.vimrc After editing, run
augroup Vimrc
    autocmd!
    autocmd FileType vim setlocal keywordprg=:help

    autocmd BufWritePost $MYVIMRC source $MYVIMRC | exec ':echom "nvimrc reloaded after save."'

    if (exists(':AirlineRefresh'))
        autocmd BufWritePost $MYVIMRC AirlineRefresh
    endif
augroup END

noremap <Leader>vv :vsplit $MYVIMRC<CR>
noremap <Leader>V :source $MYVIMRC<CR>:filetype detect<CR>:echom 'nvimrc reloaded'<CR>
" }}}

" Vim Easy Align mappings {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" UltiSnips + YCM {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" Syntastic {{{
let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_php_phpcs_args='--standard=PSR2'
" }}}

" GutenTags {{{
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_write = 0
let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_exclude = ['/usr/local']
let g:gutentags_ctags_executable_php = 'phpctags'
" }}}

" NERDTree {{{
" Lifted from https://github.com/krampstudio/webvim
nnoremap <c-n> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" NeoMake {{{
augroup NeoMake
    autocmd!
    autocmd! BufWritePost * Neomake
augroup END
" }}}

" SplitJoin {{{
nmap sj :SplitjoinSplit<CR>
nmap sk :SplitjoinJoin<CR>
" }}}

" FZF {{{
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })


function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! FZFBuffers call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })

nnoremap <leader>m :FZFMru<CR>
nnoremap <leader>b :FZFBuffers<CR>
nnoremap <silent> <Leader><Enter> :FZFBuffers<CR>
" }}}
