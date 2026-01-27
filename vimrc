" Startup sequence notes:
" :scriptnames to list sourced files.
" :set to show set options.
" :set all for all options.
" :echo g: for global vars.
" :function: for functions.
" :map for key bindings.

" Turn on syntax highlighting
syntax on

" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Jump to last cursor position (with safeguards)
augroup vimStartup
  autocmd!
  autocmd BufReadPost *
    \ let line = line("'\"")
    \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" General options
set background=dark
silent! colorscheme gruvbox
set showcmd
set ignorecase smartcase incsearch hlsearch
set hidden mouse=a wildmenu timeoutlen=500 ttimeout ttimeoutlen=100
set tabstop=2 shiftwidth=2 expandtab
set scrolloff=4 nrformats-=octal
set number relativenumber cursorline cursorlineopt=number laststatus=2
set splitright splitbelow shortmess+=I linebreak breakindent
let &showbreak='> '
set foldmethod=indent foldlevel=99 foldnestmax=3
set list listchars=tab:>\ ,space:·,trail:·,extends:>,precedes:<,nbsp:+,eol:$
set termguicolors
let g:terminal_ansi_colors = [
  \ '#000000', '#cc0000', '#4e9a06', '#c4a000',
  \ '#3465a4', '#75507b', '#06989a', '#d3d7cf',
  \ '#555753', '#ef2929', '#8ae234', '#fce94f',
  \ '#729fcf', '#ad7fa8', '#34e2e2', '#eeeeec'
  \ ]
set encoding=utf-8
set undofile undodir=~/.vim/undo//
set backup backupdir=~/.vim/backup//
set clipboard=unnamedplus
set nomodeline

" Remove trailing whitespace on save
augroup whitespaceremoval
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

" Mappings
nnoremap Q <nop>
inoremap <C-U> <C-G>u<C-U>
inoremap jj <esc>
nnoremap Y y$
noremap n nzz
noremap N Nzz
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap <silent> <M-k> :m-2<CR>
nnoremap <silent> <M-j> :m+1<CR>
xnoremap <silent> <M-k> :m-2<CR>gv=gv
xnoremap <silent> <M-j> :m'>+1<CR>gv=gv
nmap j gj
nmap k gk
vmap j gj
vmap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <silent> y y`]
let mapleader = "\\"
nnoremap <leader>\ :vertical terminal<CR>
nnoremap <silent> <C-P> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Python indentation fix
let g:pyindent_open_paren='shiftwidth()'
let g:pyindent_continue='shiftwidth()'

" Lightline config
let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\     'left':  [ [ 'mode', 'paste' ],
\                [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\     'right': [ [ 'lineinfo' ],
\                [ 'percent' ],
\                [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
\   },
\   'component': {
\     'charvaluehex': '0x%B'
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead'
\   },
\ }
silent! packadd lightline.vim

" ALE config
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\ }
let g:ale_fixers = {
\   'python': ['yapf'],
\   'javascript': ['prettier'],
\ }
let g:ale_fix_on_save = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Jedi
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0

silent! packadd supertab
silent! packadd ale
silent! packadd jedi-vim

" Language-specific
function! s:LoadPythonDevEnvironment()
  setlocal tabstop=4 shiftwidth=4 expandtab
  nnoremap <buffer> <leader>f :ALEFix<CR>
  nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
endfunction

function! s:LoadHtmlCssDevEnvironment()
  silent! packadd emmet-vim
  imap <expr> <buffer> <tab> emmet#expandAbbrIntelligent("\<tab>")
  setlocal tabstop=2 shiftwidth=2 expandtab
endfunction

function! s:LoadJavaScriptDevEnvironment()
  setlocal tabstop=2 shiftwidth=2 expandtab
  nnoremap <buffer> <leader>f :ALEFix<CR>
endfunction

augroup LanguageSettings
  autocmd!
  autocmd FileType python call s:LoadPythonDevEnvironment()
  autocmd FileType html,css call s:LoadHtmlCssDevEnvironment()
  autocmd FileType javascript,json call s:LoadJavaScriptDevEnvironment()
augroup END
