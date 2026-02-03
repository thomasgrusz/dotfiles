" Startup sequence notes:
" :scriptnames to list sourced files.
" :set to show set options.
" :set all for all options.
" :echo g: for global vars.
" :function: for functions.
" :map for key bindings.

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'

call plug#end()

" coc auto-installs on new machines
let g:coc_global_extensions = ['coc-pyright', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-html', 'coc-emmet', 'coc-css']

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
inoremap jk <esc>
nnoremap Y y$
noremap n nzz
noremap N Nzz
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap <silent> <Esc>k :m-2<CR>
nnoremap <silent> <Esc>j :m+1<CR>
xnoremap <silent> <Esc>k :m-2<CR>gv=gv
xnoremap <silent> <Esc>j :m'>+1<CR>gv=gv
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
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
let g:coc_snippet_next = '<tab>'

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

" Run JavaScript files in a terminal window to the right
let g:js_term_bufnr = -1

function! RunJSInTerm()
  write
  if g:js_term_bufnr == -1 || !bufexists(g:js_term_bufnr)
    vert rightbelow term
    let g:js_term_bufnr = bufnr('%')
    wincmd p
  endif
  " Send clear + node command to existing terminal
  call term_sendkeys(g:js_term_bufnr, "clear\<CR>node " . expand('%:p') . "\<CR>")
endfunction

" Run Python files in a terminal window to the right
let g:py_term_bufnr = -1

function! RunPythonInTerm()
  write
  if g:py_term_bufnr == -1 || !bufexists(g:py_term_bufnr)
    vert rightbelow term
    let g:py_term_bufnr = bufnr('%')
    wincmd p
  endif
  call term_sendkeys(g:py_term_bufnr, "clear\<CR>python3 " . expand('%:p') . "\<CR>")
endfunction

"
" Language-specific
function! s:LoadPythonDevEnvironment()
  setlocal tabstop=4 shiftwidth=4 expandtab
  nnoremap <buffer> <leader>f :ALEFix<CR>
  nnoremap <buffer> <F5> :call RunPythonInTerm()<CR>
endfunction

function! s:LoadHtmlCssDevEnvironment()
  setlocal tabstop=2 shiftwidth=2 expandtab
endfunction

function! s:LoadJavaScriptDevEnvironment()
  setlocal tabstop=2 shiftwidth=2 expandtab
  nnoremap <buffer> <leader>f :ALEFix<CR>
  nnoremap <buffer> <F5> :call RunJSInTerm()<CR>
endfunction

augroup LanguageSettings
  autocmd!
  autocmd FileType python call s:LoadPythonDevEnvironment()
  autocmd FileType html,css call s:LoadHtmlCssDevEnvironment()
  autocmd FileType javascript,json call s:LoadJavaScriptDevEnvironment()
augroup END
