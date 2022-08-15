# Set colors for shell
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Clear terminal window and empty buffer
alias c="clear && printf '\e[3J'"
#alias cat="cat -n"
alias ll="ls -lh"
alias la="ls -lha"
alias mypath="tr ':' '\n' <<< $PATH"
alias grep="grep --color=auto"

# Python Virtual Environment related
alias cve='python3 -m venv .venv'
alias s='source .venv/bin/activate'
alias d='deactivate'

# macOS Apps
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# Load official git prompt support for branch and (dirty/clean) state indication
source ~/.git-prompt.sh

# GIT prompt options
# ------------------
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

# Define prompt
#PS1='\h:\W \u\$ '
PS1='\[\e[93m\]\u\[\e[36m\]@\[\e[93m\]\h \[\e[0m\][ \[\e[32m\]\W\[\e[0m\] ]\[\e[95m\]$(__git_ps1 " (%s)")\[\e[0m\] \$ '
#PROMPT_COMMAND='__git_ps1 "\[\e[93m\]\u\[\e[36m\]@\[\e[93m\]\h \[\e[0m\][ \[\e[32m\]\W\[\e[0m\] ]" "\\\$ "'

# ***********************************************************

# ------------------------
# Ansi color explanation
# ------------------------
# brightYellow "[\e93m"
# brightMagenta "[\e95m"
# cyan "[\e36m"
# green "[\e32m"
# reset colores "\e[0m"
# The color codes and reset MUST be wrapped in `\[' and `\]', otherwise the prompt behaves strangely.

# ------------------------
# ls options
# ------------------------
# -l    show long format
# -a    show hidden files
# -A    almost like -a but without . and ..
# -h    human readable file size (KB, MB etc instead of Blocks)
# -F    add one char of */=>@| to entries

# ------------------------
# Color for 'ls' command
# ------------------------
#export CLICOLOR=1
#export LSCOLORS=gxfxcxdxbxegedabagacad 
# gx fx cx dx bx eg ed ab ag ac ad 

# ls Attribute  Foreground color  Background color
# --------------------------------------------------------
# directory		g		x
# symbolic		f		x
# socket		c		x
# pipe			d		x
# executable		b		x
# block			e		g
# character		e		d
# executable-setuid	a		b
# executable-setgid	a		g
# directory 1)		a		c
# directory 2)		a		d

# 1) directory writable to others, with sticky bit
# 2) directory writable to others, without sticky bit

# Code 	Meaning (Color)
# -----------------------
#   a 	Black
#   b 	Red
#   c 	Green
#   d 	Brown
#   e 	Blue
#   f 	Magenta
#   g 	Cyan
#   h 	Light grey
#   A 	Bold black, usually shows up as dark grey
#   B 	Bold red
#   C 	Bold green
#   D 	Bold brown, usually shows up as yellow
#   E 	Bold blue
#   F 	Bold magenta
#   G 	Bold cyan
#   H 	Bold light grey; looks like bright white
#   x 	Default foreground or background

# Other color schemes
# export LSCOLORS=cxfxbxdxbxegedabagacad
# export LSCOLORS=CxFxBxDxBxegedabagacad
# export LSCOLORS=exfxcxdxbxegedabagacad 
