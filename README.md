# dotfiles

## Setup a new Linux box

_Make sure Python 3 and Vim are installed on your system._

### Clone this repo to your homefolder:

```
cd && git clone git@github.com:thomasgrusz/dotfiles.git
```

### Install dotfiles:

```
bash ~/dotfiles/install_dotfiles.sh
```

This will backup existing dotfiles in the home folder and create the symlinks below:

| Source                 |     | Target                         |
| ---------------------- | --- | ------------------------------ |
| ~/.bash_aliases        | »   | ~/dotfiles/bash_aliases        |
| ~/.bash_git_setup      | »   | ~/dotfiles/bash_git_setup      |
| ~/.bashrc              | »   | ~/dotfiles/bashrc              |
| ~/.git-completion.bash | »   | ~/dotfiles/git-completion.bash |
| ~/.gitconfig           | »   | ~/dotfiles/gitconfig           |
| ~/.git-prompt.sh       | »   | ~/dotfiles/git-prompt.sh       |
| ~/.vim                 | »   | ~/dotfiles/vim                 |
| ~/.vimrc               | »   | ~/dotfiles/vimrc               |

### Install nvm (node version manager) and node

```
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \
  | bash'
nvm install --lts && nvm use --lts
```

Check installation with:

```
nvm -v && node -v
```

### Install Vim plugins (inside Vim), regularly update:

`:PlugInstall`

`:PlugUpdate`

### Install Helix text editor and dependencies:

```
cd && bash ~/dotfiles/install_helix.sh
```

This will backup existing Helix configs in the home folder and create the symlinks below:

| Source                          |     | Target                            |
| ------------------------------- | --- | --------------------------------- |
| `~/.config/helix/config.toml`   | »   | `~/dotfiles/helix/config.toml`    |
| `~/.config/helix/language.toml` | »   | `~/dotfiles/helix/languages.toml` |

---

## Start new Python project

**Helix** does not requiree any further python dev packages. If you want to start a python project using **Vim** you need to run the alias `makevenv` from `~/.bash_aliases` which will instal `flake8` and `yapf` for linting and formatting.

### in Vim

```
cd && mkdir myPythonproject && cd myPythonproject
makevenv
```

### in Helix

```
cd && mkdir myPythonproject && cd myPythonproject
# no need for installing dependencies
```

## Start new JavaScript project

`makejs` is an alias in `~/.bash_aliases` that locally installs node packages `eslint` and `prettier` needed for linting and formatting with Vim. Helix works with gloablly installed node packages.

### in Vim

```
cd && mkdir myJSproject && cd myJSproject
makejs
```

### in Helix

```
cd && mkdir myJSproject && cd myJSproject
# no need for installing dependencies
```
