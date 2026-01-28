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
**Install nvm (node version manager) and node**

`PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'`

`nvm install --lts && nvm use --lts`

**Install Vim plugins (inside Vim):**
`:PlugInstall`

**Update Vim plugins regularly:**
`:PlugUpdate`
