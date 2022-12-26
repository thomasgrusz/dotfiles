

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""    


"" ******** General Settings ********
" Set runtimetime path 
set runtimepath^=~/.vim/bundle/badwolf

" Set compatibility to Vim only (not Vi)
set nocompatible

" Encoding
set encoding=utf-8

" Show partial command you type, in last line of the screen
set showcmd

" Show mode you are in, on the last line
set showmode

" Show line numbers
set number relativenumber

" Highlight searches incrementally and ignore case 
set hlsearch
set incsearch
set ignorecase
set smartcase	" disables ignorecas if search term contains capitals

" Automatically wrap text that extends beyond the screen length
set wrap

" Set color scheme
"colorscheme slate
colorscheme koehler
"colorscheme molokai     " $ curl -o molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

" Enable mouse usage (all modes)
set mouse=a

" Enable filetype detection. Vim will be able to try to detect the type of
" file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Highlight cursor line underneath the cursor horizontally
"set cursorline

" Highlight cursor line underneath the cursor vertically
"set cursorcolumn

" Set shift width to 4 spaces
set shiftwidth=4

" Set tab width to 4 columns
set tabstop=4

" Set space characters instead of tabs
set expandtab

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu for opening files after pressing TAB
set wildmenu

" Make wildmenu behave like similar to Bash completion
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
"set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


"" ******** MAPPINGS ********
" Map simpler pane-navigation keys
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map NERDTree toggle to Ctrl-n
"map <C-n> :NERDTreeToggle<CR>  " CTRL-n to toggle NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1    " Automatically cloase NERDTree when you open a file

" Map jj to Escape key in INSERT and VISUAL modes
inoremap jj <esc>
vnoremap jj <esc>

" Set leader key to a backslash `\`
let mapleader = "\\"

" Map `\\` to turn off the highlighted text from a search
nnoremap <leader>\ :nohlsearch<CR>

" Map `\t` to opening a terminal pane to the right
nnoremap <leader>t :below vertical terminal<CR>

" Press SPACE BAR to get into : commant typing mode
nnoremap <space> : 

" Create an empty line by pressing `o` or `O`
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to end of line
nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>


"" ******** PLUGINS ********
" To install the vim-plug plugin manager run the following command:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif


"" ******** VIMSCRIPTS ********
" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab



"" ******** STATUS LINE ********

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
