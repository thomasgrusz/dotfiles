# History control - leading space, duplicates not recorded
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%Y-%m-%d %T '

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Python Virtual Environment related
alias cve='python3 -m venv .venv'
alias s='source .venv/bin/activate'
alias d='deactivate'

# macOS
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# Define prompt
PS1='\[\e[93m\]\u\[\e[36m\]@\[\e[93m\]\h \[\e[0m\][ \[\e[32m\]\W\[\e[0m\] ] \$ '

# Load git support for shell session
if [ -f ~/.bash_git_setup ]; then
    . ~/.bash_git_setup
fi

# set environment variable for the less command to handle utf-8 character encoding
export LESSCHARSET=utf-8
