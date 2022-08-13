export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Clear terminal window and empty buffer
alias c="clear && printf '\e[3J'"
#alias cat="cat -n"
alias ls="ls -F"
alias ll="ls -lhF"
alias la="ls -lhaF"

# Python Virtual Environment related
alias cve='python3 -m venv .venv'
alias s='source .venv/bin/activate'
alias d='deactivate'
alias mypath="tr ':' '\n' <<< $PATH"

# macOS Apps
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# Define color variables
autoload -U colors && colors
resetColor="%{$reset_color%}"

#yellowFG="%{$fg[yellow]%}"
#cyanFG="%{$fg[cyan]%}"
#greenFG="%{$fg[green]%}"
#whiteFG="%{$fg[white]%}"

# Ansi Colors
yellowFG="%F{11}"   # bright yellow
cyanFG="%F{cyan}"
greenFG="%F{green}"
whiteFG="%F{white}"

# Default prompt
PROMPT="%B$yellowFG%n$cyanFG@$yellowFG%m$whiteFG [ $greenFG%1~ $whiteFG] $resetColor %#%b " 
RPROMPT="%T"
