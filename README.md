# dotfiles

## Setup a new Linux box

_Make sure Python 3 and Vim are installed on your system._

### Clone this repo to your homefolder:

`cd && git clone git@github.com:thomasgrusz/dotfiles.git`

### Install dotfiles:

`bash ~/dotfiles/install_dotfiles.sh`

This will backup existing dotfiles in the home folder and create the symlinks below:

```
~/.bash_aliases -> ~/dotfiles/bash_aliases
~/.bash_git_setup -> ~/dotfiles/bash_git_setup
~/.bashrc -> ~/dotfiles/bashrc
~/.git-completion.bash -> ~/dotfiles/git-completion.bash
~/.gitconfig -> ~/dotfiles/gitconfig
~/.git-prompt.sh -> ~/dotfiles/git-prompt.sh
~/.vim -> ~/dotfiles/vim
~/.vimrc -> ~/dotfiles/vimrc
```

### Install nvm (node version manager) and node

```
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \
  | bash'
nvm install --lts && nvm use --lts
```

Check installation with `nvm -v && node -v`

### Install Vim plugins (inside Vim), regularly update:

`:PlugInstall`

`:PlugUpdate`

### Install Helix text editor and dependencies:

```
cd && bash ~/dotfiles/install_helix.sh
npm install -g bash-language-server oxlint prettier typescript typescript-language-server
sudo apt update && sudo apt install shellcheck shfmt
curl -fsSL https://github.com/tamasfe/taplo/releases/latest/download/taplo-linux-x86_64.gz \
  | gzip -d - | install -D -m 755 /dev/stdin ~/.local/bin/taplo
curl -fsSL https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 \
  | install -D -m 755 /dev/stdin ~/.local/bin/marksman
```

This will backup existing Helix configs in the home folder and create the symlinks below:

```
~/.config/helix/config.toml -> ~/dotfiles/helix/config.toml
~/.config/helix/language.toml -> ~/dotfiles/helix/languages.toml
```

---

## Start new Python project

`makevenve` and `makevenvVim` are aliases in `~/.bash_aliases` that install certain Python packages needed for linting, formatting and autocompletion.

### in Vim

```
cd && mkdir mypythonproject && cd mypythonproject
makevenvVim
```

### in Helix

```
cd && mkdir mypythonproject && cd mypythonproject
makevenv
```

## Start new JavaScript project

`makejsVim` is an alias in `~/.bash_aliases` that installs certain node packages needed for linting and formatting with Vim. Helix works with the gloablly installed node packages `oxlint`, `prettier`, `typescript` and `typescript-language-server`

### in Vim

```
cd && mkdir myJSproject && cd myJSproject
makejsVim
```

### in Helix

```
cd && mkdir myJSproject && cd myJSproject
# no need for installing dependencies
```
