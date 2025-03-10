set autoindent
set complete-=i
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set incsearch
set laststatus=2
set wildmenu
set scrolloff=8
set sidescrolloff=5
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
set tags+=gems.tags
set history=1000
set tabpagemax=50
set viminfo^=!
set viminfo+=f1
set sessionoptions-=options
set viewoptions-=options
set termguicolors
let &backupdir = '/home/thomasgrusz/.local/share/vim/backup//' " folder must exist
let &undodir = '/home/thomasgrusz/.local/share/vim/undodir//' " folder must exist
set undofile
set mouse=a
set number
set cursorline
set cursorlineopt=number
set winwidth=79
set winheight=5
set winminheight=5
set wildmode=longest,full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
"set foldmethod=indent
set foldnestmax=3
set nofoldenable
set hlsearch
set ignorecase
set smartcase
set iskeyword+=-
set splitright
set splitbelow
set shortmess+=I
set showcmd
set switchbuf=usetab
set hidden
set linebreak
set showbreak=" "
"set shortmess+=A		" suppress Attention msg
set updatetime=1500
set gp=git\ grep\ -n

inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
inoremap jj <esc>
nnoremap Y y$
nnoremap & :&&<CR> " repeat substitution w flags (i, g, etc)
xnoremap & :&&<CR>
vmap j gj
vmap k gk
nmap j gj
nmap k gk
noremap n nzz
noremap N Nzz
noremap gV `[v`]
vnoremap <silent> y y`]
nnoremap <silent> p p`]
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'		" && = shorcut to cwd in e/w mode
nnoremap <silent> <C-P> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
let &directory = '/home/thomasgrusz/.vim' . '//,' . &directory
au FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
let mapleader = "\\"
nnoremap <leader>\ :vertical terminal<CR>
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>
nnoremap <silent> <Esc>k :m-2<CR>
nnoremap <silent> <Esc>j :m+1<CR>
nnoremap <silent> <M-Up> :m-2<CR>
nnoremap <silent> <M-Down> :m+1<CR>
xnoremap <silent> <Esc>k :m-2<CR>gv=gv
xnoremap <silent> <Esc>j :m'>+<CR>gv=gv

let g:lightline = {
\   'colorscheme': 'wombat',
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead'
\   },
\ }

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'html': ['tidy', 'eslint'],
\ }


let g:ale_fixers = {
\    'python': ['autopep8'],
\    'javascript': ['eslint'],
\    'html': ['tidy'],
\ }

command! -nargs=+ Grep silent grep! <args>

" Python development environment
augroup PythonSettings
    autocmd!
    autocmd FileType python call s:LoadPythonDevEnvironment()
augroup END

function! s:LoadPythonDevEnvironment()
    packadd ale         " Load linter plugin
    packadd jedi-vim    " Load Python syntax plugin
    nnoremap <buffer> <leader>f :ALEFix<CR>
    nnoremap <buffer> <leader>] :update<CR>:terminal python3 %:p<CR>
endfunction

" WebDev environment
augroup HTMLCSSSettings
    autocmd!
    autocmd FileType html,css call s:htmlAndCss()
augroup END

function! s:htmlAndCss()
    packadd ale             " Load linter plugin
    packadd emmet-vim       " Load emmet plugin
    packadd vim-css-color   " Load css color plugin
    nnoremap <buffer> <leader>f :ALEFix<CR>
    nnoremap <buffer> <leader>l :terminal browser-sync -w<CR>
endfunction

augroup JavaScriptSettings
    autocmd!
    autocmd FileType javascript call s:jsSettings()
augroup END

function! s:jsSettings()
    packadd ale
    nnoremap <buffer> <leader>f :ALEFix<CR>
    nnoremap <buffer> <leader>] :update<CR>:terminal node %:p<CR>
endfunction

" Remove trailing whitespace when saving a file
augroup whitespaceremoval
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

autocmd QuickFixCmdPost [^l]* nested cwindow 20 | redraw!

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

"===============================================================================
" %s/\Csearchterm/replacement/g - force case-sensitive searches (\C)
" %s/\cSEARCHTERM/replacement/g - force case-insensitive searches (\c)

" sudo apt install fonts-powerline fonts-jetbrains-mono

" *** Python projects
" Create and start a virtual environment
" in the project folder and download relevant packages:
"   python3 -m venv venv
"   source venv/bin/activate
"   pip install flake8 autopep8
"
" *** Javascript projects
" Locally install the js linter 'eslint' in the project directory and initialize it:
"   npm install eslint --save-dev
"   npx eslint --init

"Also install a plugin to lint javascript within html files:
" 'eslint-plugin-html' and add 2 configuration lines inside
" 'eslint.config.mjs':

" import html from "eslint-plugin-html"
"   export default [
"     {
"       files: ["**/*.html"],
"       plugins: { html },
"     },
"   ]

" Then add a ternjs (autocomplete) configuration file:
"
"   .tern-project:
"     {
"       "libs": [
"         "browser",
"         "ecmascript"
"       ],
"       "plugins": {
"         "esmodules": {}
"       }
"     }

" Also make sure that the 'tidy' package is installed on the system.
" This package is needed by the vim plugin for 'ale' for html linting.
"       'sudo apt install tidy'
