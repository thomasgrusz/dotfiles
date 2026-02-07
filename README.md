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

The following dotfiles will be replace with symlinks to `~/dotfiles`. Your original dotfiles will be backed up in a new folder inside home (`~`).

| dotfiles                           |
| ---------------------------------- |
| ~/.bash_aliases                    |
| ~/.bash_git_setup                  |
| ~/.bashrc                          |
| ~/.dircolors                       |
| ~/.git-completion.bash             |
| ~/.gitconfig                       |
| ~/.git-prompt.sh                   |
| ~/.vimrc                           |
| ~/.vim/                            |
| ~/.config/alacritty/alacritty.toml |
| ~/.config/helix/config.toml        |
| ~/.config/helix/languages.toml     |

### Install nvm (node version manager) and node

```
PROFILE=/dev/null bash -c \
  'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \
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

---

## New Python or JavaScript projects

**Helix** does not requiree any further python or javascript dev packages. Just create a project folder `cd `into it and start coding.

**Vim** on the other hand needs dev packages that can be installed via an alias (defined in `~/.bash_aliases`):

##### Python

`makevenv` will install `flake8` and `yapf` for linting and formatting.

```
cd && mkdir myPythonproject && cd myPythonproject
makevenv
```

##### JavaScript

`makejs` will install the node packages `eslint` and `prettier` for linting and formatting.

```
cd && mkdir myJSproject && cd myJSproject
makejs
```
