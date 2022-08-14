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
brightYellowFG="%F{11}"
brightMagentaFG="%F{13}"
brightCyanFG="%F{14}"
cyanFG="%F{cyan}"
magentaFG="%F{magenta}"
greenFG="%F{green}"
whiteFG="%F{white}"

# Default prompt
#PROMPT="%B$brightYellowFG%n$cyanFG@$brightYellowFG%m$whiteFG [ $greenFG%1~ $whiteFG] $resetColor %#%b " 
RPROMPT="%T"

# Load official git prompt support for branch and (dirty/clean) state indication
source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PS1='$brightYellowFG%n$cyanFG@$brightYellowFG%m$whiteFG [ $greenFG%1~ $whiteFG]$brightMagentaFG$(__git_ps1 " (%s)") $whiteFG$resetColor %# '


# Load zsh specific tab-completion for git
autoload -Uz compinit && compinit

# Load zsh specific prompt support for Git
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'            # This is for right side prompt support
# # PROMPT='${vcs_info_msg_0_}%# '        # This is for left side prompt support
# zstyle ':vcs_info:git:*' formats '%b'
