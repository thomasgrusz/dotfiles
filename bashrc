# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Colors
# The `1;' before the color code = `bold'
GREEN='\[\033[1;92m\]'
BLUE='\[\033[1;94m\]'
RESET='\[\033[0m\]'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${RESET}:${BLUE}\w\$(__git_ps1 ' (%s)')${RESET}\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "$HOME"/.bash_aliases ]; then
    . "$HOME"/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
export LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
[[ ":$PATH:" =~ :/sbin: ]] || export PATH="$PATH:/sbin"
[[ ":$PATH:" =~ :/usr/sbin: ]] || export PATH="$PATH:/usr/sbin"

# Add my scripts folder in ~/.myscripts to PATH, if not there
if [[ -d "$HOME/.myscripts" ]]; then
    [[ ":$PATH:" =~ :$HOME/.myscripts: ]] || export PATH="$PATH:$HOME/.myscripts"
fi

# Configure git
if [[ -f "$HOME/.bash_git_setup" ]]; then
    source "$HOME/.bash_git_setup"
fi

## Install Pyenv - Python version control
# curl -fsSL https://pyenv.run | bash

## Pyenv initialization
#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init - bash)"
#eval "$(pyenv virtualenv-init -)"

## Ensure neovim is in PATH if installed
if [[ -d "$HOME/.local/bin/nvim-linux-x86_64/bin" ]]; then
    [[ ":$PATH:" =~ :$HOME/.local/bin/nvim-linux-x86_64/bin: ]] || export PATH="$PATH:$HOME/.local/bin/nvim-linux-x86_64/bin"
fi

## Install nvm (Node Version Manager) and node
# PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
# nvm install --lts && nvm use --lts
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# shellcheck source=/dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Add `go' to path, if it exists
if [[ -d "/usr/local/go/bin" ]]; then
    [[ ":$PATH:" =~ :/usr/local/go/bin: ]] || export PATH="$PATH:/usr/local/go/bin"
fi

if [[ -d "$HOME/go/bin" ]]; then
    [[ ":$PATH:" =~ :$HOME/go/bin: ]] || export PATH="$PATH:$HOME/go/bin"
fi

# Add ~/.local/bin to PATH
if [[ -d "$HOME/.local/bin" ]]; then
    [[ ":$PATH:" =~ :$HOME/.local/bin: ]] || export PATH="$PATH:$HOME/.local/bin"
fi

# Source ~/.cargo/env if exists (rust)
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

# Start SSH agent if not running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# Add ssh keys to ssh-agent
# Non standard names are not loaded automatically
if [[ -f "$HOME/.ssh/id_ed25519_github" ]]; then
    ssh-add -q "$HOME/.ssh/id_ed25519_github"
fi

if [[ -f "$HOME/.ssh/id_ed25519_gitlab" ]]; then
    ssh-add -q "$HOME/.ssh/id_ed25519_gitlab"
fi

if [[ -f "$HOME/.bash_completion/alacritty" ]]; then
    . "$HOME/.bash_completion/alacritty"
fi

# ---

# ANSI Color Codes for Terminal (FG: Foreground, BG: Background)

# FG  BG   Name

# 30  40   Black

# 31  41   Red

# 32  42   Green

# 33  43   Yellow

# 34  44   Blue

# 35  45   Magenta

# 36  46   Cyan

# 37  47   White

# 90  100  Bright Black (Gray)

# 91  101  Bright Red

# 92  102  Bright Green

# 93  103  Bright Yellow

# 94  104  Bright Blue

# 95  105  Bright Magenta

# 96  106  Bright Cyan

# 97  107  Bright White

# 0 Reset
