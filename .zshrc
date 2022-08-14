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

# Ansi color explanations
#   brightYellowFG    %F{11}
#   brightMagentaFG   %F{13}
#   brightCyanFG      %F{14}
#   colorReset        %f

# Load official git prompt support for branch and (dirty/clean) state indication
source ~/.git-prompt.sh

# Define prompts
# --------------
# Enable prompt expansion
setopt PROMPT_SUBST

# Indicate status of working directory (*), stage area (+)
GIT_PS1_SHOWDIRTYSTATE=1
#Indicate stash status ($)
GIT_PS1_SHOWSTASHSTATE=1
#Indicate untracked files (%)
GIT_PS1_SHOWUNTRACKEDFILES=1
# Indicate difference between HEAD and upstream repo
GIT_PS1_SHOWUPSTREAM="auto, verbose, name"
# Separator symbol between branch and status (default: SP)
GIT_PS1_STATESEPARATOR="|"
# Show ? to indicate sparse repo
#GIT_PS1_COMPRESSSPARSESTATE
# Do not indicate if repo is sparse
#GIT_PS1_OMITSPARSESTATE
# Info on headless checked out commits (contains, branch, describe, tag, default)
#GIT_PS1_DESCRIBE_STYLE
# Show colored hints for dirty state
GIT_PS1_SHOWCOLORHINTS=1
# Do not show anything if current working directory is ignored by git
#GIT_PS1_HIDE_IF_PWD_IGNORED

# This is the regular prompt setting
#PS1='%F{11}%n%F{cyan}@%F{11}%m%F{white} [ %F{green}%1~ %F{white}]%F{13}$(__git_ps1 " (%s)")%f %# '

# Set right prompt to time
RPROMPT="%T" 

# Set pre-prompt command, this is faster than setting PS1 directly
#precmd () { __git_ps1 "%F{11}%n%F{cyan}@%F{11}%m%F{13}" "%F{white} [ %F{green}%1~%f ] %# " "|%s" }
precmd () { __git_ps1 "%F{11}%n%F{cyan}@%F{11}%m%f" "%F{white} [ %F{green}%1~%f ] %# " "|%s" }

# Load zsh specific tab-completion for git
autoload -Uz compinit && compinit
