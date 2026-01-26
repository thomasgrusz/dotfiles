# dotfiles
## Setup a new Linux box
**Clone this repo to your homefolder:**
`cd && git clone git@github.com:thomasgrusz/dotfiles.git`

**Run this install script for backing up existing dotfiles and to create the following soft links below:**
`bash ~/dotfiles/install.sh`

```
.bash_aliases -> ~/dotfiles/bash_aliases
.bash_git_setup -> ~/dotfiles/bash_git_setup
.bashrc -> ~/dotfiles/bashrc
.git-completion.bash -> ~/dotfiles/git-completion.bash
.gitconfig -> ~/dotfiles/gitconfig
.git-prompt.sh -> ~/dotfiles/git-prompt.sh
.vim -> ~/dotfiles/vim
.vimrc -> ~/dotfiles/vimrc
```
**Populate vim plugins (= git submodules):**
`cd ~/dotfiles && git submodule update --init --recursive`

**Update vim plugins regularly:**
`cd ~/dotfiles && git submodule update --remote --merge`

**Enable git support for bash (prompt and completion) by adding:**
`source ~/.bash_git_setup` to `~/.bashrc`:

---


## Add vim plugins as git submodules
```
cd  ~/dotfiles/vim/pack/myplygins/opt

# already installed
git submodule add https://github.com/itchyny/lightline.vim
git submodule add https://github.com/morhetz/gruvbox
git submodule add https://github.com/tpope/vim-fugitive
git submodule add https://github.com/dense-analysis/ale
git submodule add https://github.com/davidhalter/jedi-vim
git submodule add https://github.com/ervandew/supertab

# not installed
git submodule add https://github.com/mattn/emmet-vim
git submodule add https://github.com/sirver/ultisnips
git submodule add https://github.com/joom/vim-commentary

cd ~/dotfiles
git add .gitmodules vim/pack/myplugins/opt/*
git commit -m "Add Vim plugins as submodules"
git push origin main
```
