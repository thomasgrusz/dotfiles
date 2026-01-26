" Startup sequence for vim starts here (set in runtimepath): /etc/vim/vimrc

" In /etc/vim/vimrc the following files are sourced with VIMRUNTUME=/usr/share/vim/vim91/ :
" $VIMRUNTIME/debian.vim
" $VIMRUNTIME/defaults.vim	(only loaded if no ~/.vimrc)
" ~/.vimrc
" ~/.vim/pack/myplugins/start/*
" $VIMRUNTIME/plugin/*

" Run this command to display all sourced files in sequence:
" :scriptnames

" Run this command to display all options that have been set:
" :set

" Run this command to display all available options:
" :set all

" Run this command to display all global variables:
" :echo g:

" Run this command to display all functions:
" :function:

" Run this command to display all key bindings except insert/command mode:
" :map

" ----------------- options -----------------

" Enable Vim-specific features, disabling strict vi compatibility
" (/usr/share/vim/debian.vim)
" set nocompatible

" More powerful backspacing
" (/usr/share/vim/debian.vim)
" set backspace=indent,eol,start

" Keep 50 lines of command line history
" (/usr/share/vim/debian.vim)
" set history=50

" Show the cursor position all the time
" (/usr/share/vim/debian.vim)
" set ruler

" modelines have historically been a source of security/resource
" vulnerabilities - disable by default, even when 'nocompatible' is set
" (/usr/share/vim/debian.vim)
" set nomodeline

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
" (/usr/share/vim/debian.vim)
" set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Vim5 and later versions support syntax highlighting. Uncommenting the
" three lines below enables syntax highlighting by default.
" (/etc/vim/vimrc)
" if has("syntax")
"   syntax on
" endif

" The 'syntax on' setting in /etc/vim/vimrc (above) sources multiple scripts:
" /usr/shar/vim/vim91/syntax/syntax.vim
" usr/share/vim/vim91/syntax/synload.vim
" usr/share/vim/vim91/syntax/syncolor.vim
" usr/share/vim/vim91/colors/lists/default.vim
" /usr/share/vim/vim91/filetype.vim
" /usr/share/vim/vim91/scripts.vim
" /usr/share/vim/vim91/autoload/dist/script.vim

" Enable filetype detection
" (/usr/share/vim/vim91/syntax/syntax.vim)
" filetype on

" Load indentation rules and plugins according to the detected filetype
filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim), for a commit or rebase message
" (likely a different one than last time), and when using xxd(1) to filter
" and edit binary files (it transforms input files back and forth, causing
" them to have dual nature, so to speak)

" Put these in an autocmd group, so that you can revert them with:
" :autocmd! vimStartup"
augroup vimStartup
autocmd!

autocmd BufReadPost *
\ let line = line("'\"")
\ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
\      && index(['xxd', 'gitrebase'], &filetype) == -1
\ |   execute "normal! g`\""
\ | endif

augroup END

" Set background (light or dark, readability)
set background=dark

" Set colorscheme
colorscheme gruvbox

" Set colorcolum
"set colorcolumn=80

" Show partial commands in status line (bottom-right)
set showcmd

" Switch quickly back and forth to matching brackets
"set showmatch

" Make searches case-insensitive
set ignorecase

" Override ignorecase if search contains uppercase
set smartcase

" Highlight search matches as you type
set incsearch

" Automatically save before commands like :next and :make
"set autowrite

" Allow switching buffers without saving
set hidden

" Enable mouse support in all modes
set mouse=a

" Enable enhanced command-line completion menu
set wildmenu

" Complete longest match first, then show full menu
"set wildmode=longest,full

" Ignore object files, git, and other temporary files
"set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Ignore compressed archives
"set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore vendor and cache directories
"set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore swap and backup files
"set wildignore+=*.swp,*~,._*

" Wait up to 100ms after first key in key-mappings
set timeoutlen=500

" Enable timeout for key codes
set ttimeout

" Wait up to 100ms after Esc for special key
set ttimeoutlen=100

" Show @@@ in the last line if it is truncated
"set display=truncate

" Keep X lines visible above/below the cursor
set scrolloff=4

" Exclude octal from number formats (e.g., for increment/decrement)
set nrformats-=octal

" Disable Q for Ex mode
nnoremap Q <nop>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Map jj to escape in insert mode
inoremap jj <esc>

" Copy to end of line with Y in normal mode
nnoremap Y y$

" Center screen on next search match
noremap n nzz

" Center screen on previous search match
noremap N Nzz

" Map space to enter command mode
nnoremap <space> :

" Insert new line below and return to normal mode
nnoremap o o<esc>

" Insert new line above and return to normal mode
nnoremap O O<esc>

" Move line up
nnoremap <silent> <Esc>k :m-2<CR>

" Move line down
nnoremap <silent> <Esc>j :m+1<CR>

" Move line up (Alt+Up)
nnoremap <silent> <M-Up> :m-2<CR>

" Move line down (Alt+Down)
nnoremap <silent> <M-Down> :m+1<CR>

" Move selected lines up in visual mode
xnoremap <silent> <Esc>k :m-2<CR>gv=gv

" Move selected lines down in visual mode
xnoremap <silent> <Esc>j :m'>+<CR>gv=gv

" Move down display (wrapped) lines in normal mode
nmap j gj

" Move up display (wrapped) lines in normal mode
nmap k gk

" Move down display (wrapped) lines in visual mode
vmap j gj

" Move up display (wrapped) lines in visual mode
vmap k gk

" Move to left window
map <C-h> <C-w>h

" Move to bottom window
map <C-j> <C-w>j

" Move to top window
map <C-k> <C-w>k

" Move to right window
map <C-l> <C-w>l

" Restore cursor position after yank in visual mode
vnoremap <silent> y y`]

" Set leader key to backslash
let mapleader = "\\"

" Open vertical terminal with leader + backslash
nnoremap <leader>\ :vertical terminal<CR>

" Enable true color support in terminal
set termguicolors

" Define 16 ANSI colors for terminal
let g:terminal_ansi_colors = [
  \ '#000000', '#cc0000', '#4e9a06', '#c4a000',
  \ '#3465a4', '#75507b', '#06989a', '#d3d7cf',
  \ '#555753', '#ef2929', '#8ae234', '#fce94f',
  \ '#729fcf', '#ad7fa8', '#34e2e2', '#eeeeec'
  \ ]

" Set terminal foreground and background colors
"highlight Terminal guifg=#ebdbb2 guibg=#282828

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Highlight current line
set cursorline

" Highlight only the line number for cursorline
set cursorlineopt=number

" Always show status line (0=never, 1=default=only if 2+ windows, 2=always)
set laststatus=2

" Highlight search matches
set hlsearch

" Clear search highlight and update diff
nnoremap <silent> <C-P> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Open vertical splits to the right
set splitright

" Open horizontal splits below
set splitbelow

" Suppress intro message
set shortmess+=I

" Wrap lines at word boundaries
set linebreak

" Use break indicator at beginning of wrapped line
set breakindent

" Show an arrow and space as wrap indicator on next line
let &showbreak='> '

" Lines with equal indent form a fold
set foldmethod=indent

" Set fold level (0=all closed, 99=all open)
set foldlevel=99

" Limit fold nesting to 3 levels
set foldnestmax=3

" Make invisible characters visible
" set list

" Customize invisible character display (tabs, trailing spaces, etc.)
set listchars=tab:>\ ,space:·,trail:·,extends:>,precedes:<,nbsp:+,eol:$

" Remove trailing whitespace on save
augroup whitespaceremoval
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

" These 2 lines correct vim's default indentation behaviour for python files
" in certain 'line continuation' situations. 1 shiftwidth is inserted
" instead of 2 shiftwiths. Both are PEP8 compliant, but 4 spaces are
" recommenden, i.e. 1 shiftwidth.
" Correction of lines 9 and 11 in '/usr/share/vim/vim91/autoload/python.vim'.
let g:pyindent_open_paren='shiftwidth()'
let g:pyindent_continue='shiftwidth()'

" Configure lightline plugin for status bar with
" - {powerline,wombat,solarized,PaperColor,one} colorscheme
" - active: place components
" - component_function: define a component
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

" Load lightline plugin from ~/.vim/pack/myplugins/opt for statusline
packadd lightline.vim

" Set up Python development environment
let g:ale_linters = {
\   'python': ['flake8']
\ }
"I don't use the 'black' formatter as it is not always PEP8 compliant
let g:ale_fixers = {
\   'python': ['yapf']
\ }

let g:SuperTabDefaultCompletionType = "context"

let g:ale_fix_on_save = 1
"let g:ale_python_black_options='--line-length=79'

" These three options are the most important for jedi-vim
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0

"let g:jedi#auto_initialization = 1
"let g:jedi#completions_enabled = 1
"let g:jedi#show_signature_help = 0

packadd supertab
packadd ale
packadd jedi-vim


augroup PythonSettings
    autocmd!
    autocmd FileType python call s:LoadPythonDevEnvironment()
augroup END

" Load Python-specific mappings
function! s:LoadPythonDevEnvironment()
	"nnoremap K :ALEHover<CR>
	nnoremap <buffer> <leader>f :ALEFix<CR>
	nnoremap <F5> :w<CR>:!python3 %<CR>
endfunction


" ----------------- not used -----------------

"" Set up Python development environment without jedi-vim plugin
"augroup PythonSettings
"    autocmd!
"    autocmd FileType python call s:LoadPythonDevEnvironment()
"augroup END
"
"" Load Python-specific plugins and mappings
"function! s:LoadPythonDevEnvironment()
"	packadd ale
"	setlocal omnifunc=ale#completion#OmniFunc
"
"	let g:ale_linters = {
"	\   'python': ['pylsp', 'flake8']
"	\ }
"	let g:ale_fixers = {
"	\   'python': ['black']
"	\ }
"
"	set completeopt=menu,menuone
"	"set completeopt=menu,menuone,noselect
"	let g:ale_completion_enabled = 1
"	let g:ale_fix_on_save = 1
"	nnoremap K :ALEHover<CR>
"	nnoremap <buffer> <leader>f :ALEFix<CR>
"	nnoremap <F5> :w<CR>:!python3 %<CR>
"
"	" Tab completion after dot and keywords
"	inoremap <silent><expr> <Tab>
"	      \ pumvisible() ? "\<C-n>" :
"	      \ col('.') > 1 && getline('.')[col('.') - 2] =~ '[A-Za-z0-9_\.]' ?
"	      \ "\<C-x>\<C-o>" :
"	      \ "\<Tab>"
"
"	" Use shift-Tab to go backwards in menu
"	inoremap <silent><expr> <S-Tab>
"	      \ pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"endfunction
"
"
"
"
"" Enable auto-indentation, copying indent from previous line
"set autoindent
"
"" Convert tabs to spaces
"set expandtab
"
"" Insert tabs as spaces when at start of line
"set smarttab
"
"" Set tab width to 2 spaces
"set tabstop=2
"
"" Set soft tab (spaces) width to 2
"set softtabstop=2
"
"" Set indentation width to 2 spaces (auto indent, >>, <<, =
"" If shiftwidth is set to 0, Vim uses the value of tabstop instead.
"set shiftwidth=0
"
"" Exclude #include files from completion to speed up
"set complete-=i
"
"" Allow joining lines with comments cleanly
"set formatoptions+=j
"
"" Include gems.tags file for tag searches
"set tags+=gems.tags
"
"" Allow up to 50 tabs (=tab pages opened)
"set tabpagemax=50
"
"" Include ! for viminfo to save uppercase marks
"set viminfo^=!
"
"" Store file marks in viminfo
"set viminfo+=f1
"
"" Exclude options from session saving
"set sessionoptions-=options
"
"" Exclude options from view saving
"set viewoptions-=options
"
"" Set backup directory (must exist)
"let &backupdir = expand('$HOME') . '/.local/share/vim/backup//'
"
"" Set undo directory (must exist)
"let &undodir = expand('$HOME') . '/.local/share/vim/undodir//'
"
"" Enable persistent undo
"set undofile
"
"" Include hyphen in keywords for word boundaries
"set iskeyword+=-
"
"" Use existing tab if buffer is open
"set switchbuf=usetab
"
"" Suppress swap file attention message (commented out)
""set shortmess+=A
"
"" Set idle time for swap file updates to 1500ms
"set updatetime=1500
"
"" Use git grep for :grep command
"set gp=git\ grep\ -n
"
"" Define custom Grep command using silent grep
"command! -nargs=+ Grep silent grep! <args>
"
"" Repeat last substitution with flags
"nnoremap & :&&<CR>
"
"" Repeat last substitution with flags in visual mode
"xnoremap & :&&<CR>
"
"" Visually select last changed/yanked text
"noremap gV `[v`]
"
"" Expand %% to current file's directory in command mode
"cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"
"" Set swap file directory
"let &directory = '/home/thomasgrusz/.vim' . '//,' . &directory
"
"" Auto-check for file changes on focus or buffer enter
"au FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
"
"" C boiler plate shortcut -> /s
""nnoremap <leader>c 1Gi#include <stdio.h><CR><CR>int main(int argc, char *argv[]) {<CR><CR><Tab>return 0;<CR><BS>}<Esc>2ki<Tab>
"nnoremap <leader>c 1Gi#include <stdio.h><CR><CR>int main(int argc, char *argv[]) {<CR><CR><Tab>return 0;<CR><BS>}<Esc>2ki<Tab>
"
"" Set up HTML/CSS development environment
"augroup HTMLCSSSettings
"    autocmd!
"    autocmd FileType html,css call s:htmlAndCss()
"augroup END
"
"" Load HTML/CSS-specific plugins and mappings
"function! s:htmlAndCss()
"    packadd ale             " Load linter plugin
"    packadd emmet-vim       " Load emmet plugin
"    packadd vim-css-color   " Load css color plugin
"    nnoremap <buffer> <leader>f :ALEFix<CR>
"    nnoremap <buffer> <leader>l :terminal browser-sync -w<CR>
"endfunction
"
"" Set up JavaScript development environment
"augroup JavaScriptSettings
"    autocmd!
"    autocmd FileType javascript call s:jsSettings()
"augroup END
"
"" Load JavaScript-specific plugins and mappings
"function! s:jsSettings()
"    packadd ale
"    nnoremap <buffer> <leader>f :ALEFix<CR>
"    nnoremap <buffer> <leader>] :update<CR>:terminal node %:p<CR>
"endfunction
"
"" Open quickfix window after non-location list commands
"autocmd QuickFixCmdPost [^l]* nested cwindow 20 | redraw!
"
"" Close quickfix window after selecting an item
"autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

"===============================================================================
" %s/\Csearchterm/replacement/g - force case-sensitive searches (\C)
" %s/\cSEARCHTERM/replacement/g - force case-insensitive searches (\c)

" sudo apt install fonts-powerline fonts-jetbrains-mono

" *** Python projects
" Create and start a virtual environment
" in the project folder and download relevant packages:
"   python3 -m venv venv
"   source venv/bin/activate
"   pip install --upgrade pip
"   pip install python-lsp-server[flake8]
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

