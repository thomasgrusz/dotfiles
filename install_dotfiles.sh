#!/usr/bin/env bash
# Backs up and removes existing dotfiles, creates/verifies symlinks to ~/dotfiles
set -euo pipefail

# Comment in for debugging
# trap 'echo "Error on line $LINENO"' ERR

# Colors
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[94m'
RESET='\033[0m'

backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d)"
mkdir -p "$backup_dir"

# Subfolders, like `config/helix', contain files/folders (`runtime/')
# which are not managed by the dotfiles repo. Such subfolders must not be
# included in the items array as `folders', but with an individual file at
# the end. The `vim' folder is different, as it is entirely managed by the
# dotfiles repo.
items=("bash_aliases" "bash_git_setup" "bashrc" "dircolors" "git-completion.bash" "gitconfig" "git-prompt.sh" "tmux.conf" "vimrc" "vim" "myscripts"
    "config/alacritty/alacritty.toml"
    "config/helix/config.toml"
    "config/helix/languages.toml")

# Backup existing configs if they exist and aren't symlinks
for item in "${items[@]}"; do
    dot_path="$HOME/.$item"
    if [ -e "$dot_path" ] && [ ! -L "$dot_path" ]; then
        mkdir -p "$(dirname "$backup_dir/$item")"
        mv "$dot_path" "$backup_dir/$item"
        echo -e "Backed up ${YELLOW}~${dot_path#"$HOME"}${RESET} to ${YELLOW}~${backup_dir#"$HOME"}${RESET}"
    fi
done

# Create/verify symlinks
for item in "${items[@]}"; do
    dot_path="$HOME/.$item"
    target="$HOME/dotfiles/$item"
    if [ ! -e "$target" ]; then
        echo -e "Target ${RED}~${target#"$HOME"}${RESET} does not exist, skipping."
        continue
    fi
    if [ -L "$dot_path" ] && [ "$(readlink "$dot_path")" = "$target" ]; then
        echo -e "Symlink ${BLUE}~${dot_path#"$HOME"}${RESET} already correct, skipping."
        continue
    fi
    mkdir -p "$(dirname "$dot_path")"
    ln -sf "$target" "$dot_path"
    echo -e "Symlink ${GREEN}~${dot_path#"$HOME"}${RESET} created."
done

# Remove backup folder if empty
rmdir "$backup_dir" 2>/dev/null || true
echo -e "\n${GREEN}Symlinks created/verified. Configs are now managed via ~/dotfiles.${RESET}"
