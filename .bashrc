# Set colors for shell
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad


# Clear terminal window and empty buffer
alias c="clear && printf '\e[3J'"
#alias cat="cat -n"
alias ll="ls -lh"
alias la="ls -lha"
alias mypath="tr ':' '\n' <<< $PATH"

# Python Virtual Environment related
alias cve='python3 -m venv .venv'
alias s='source .venv/bin/activate'
alias d='deactivate'

# macOS Apps
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# ------------------------
# Explanations and Legends
# ------------------------
# ls options
# -l    show long format
# -a    show hidden files
# -A    almost like -a but without . and ..
# -h    human readable file size (KB, MB etc instead of Blocks)
# -F    add one char of */=>@| to entries

# ********* SET COLOR FOR ls COMMAND **********

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

source ~/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
