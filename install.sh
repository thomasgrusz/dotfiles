#!/bin/bash

# Backup existing configs if they exist (and aren't already symlinks)
backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d)"
mkdir -p "$backup_dir"

# Array for files (stored without dot in dotfiles)
files=("bash_aliases" "bash_git_setup" "bashrc" "git-completion.bash" "gitconfig" "gitignore" "git-prompt.sh" "vimrc")

# Backup files
for file in "${files[@]}"; do
    dot_file="$HOME/.${file}"
    if [ -f "$dot_file" ] && [ ! -L "$dot_file" ]; then
        mv "$dot_file" "$backup_dir/$file"
        echo "Backed up $dot_file to $backup_dir"
    fi
done

# Array for directories
dirs=("vim")

# Backup directories
for dir in "${dirs[@]}"; do
    dot_dir="$HOME/.${dir}"
    if [ -d "$dot_dir" ] && [ ! -L "$dot_dir" ]; then
        mv "$dot_dir" "$backup_dir/$dir"
        echo "Backed up $dot_dir to $backup_dir"
    fi
done

# Create symlinks for files (with check)
for file in "${files[@]}"; do
    dot_file="$HOME/.${file}"
    target="$HOME/dotfiles/$file"
    if [ -L "$dot_file" ] && [ "$(readlink "$dot_file")" = "$target" ]; then
        echo "Symlink $dot_file already correct, skipping."
        continue
    fi
    ln -sf "$target" "$dot_file"
    echo "Symlink $dot_file created."
done

# Create symlinks for directories (with check)
for dir in "${dirs[@]}"; do
    dot_dir="$HOME/.${dir}"
    target="$HOME/dotfiles/$dir"
    if [ -L "$dot_dir" ] && [ "$(readlink "$dot_dir")" = "$target" ]; then
        echo "Symlink $dot_dir already correct, skipping."
        continue
    fi
    ln -sf "$target" "$dot_dir"
    echo "Symlink $dot_dir created."
done

# Remove backup folder if empty
rmdir "$HOME/dotfiles_backup_$(date +%Y%m%d)" 2>/dev/null

echo "Symlinks created/verified. Configs are now managed via ~/dotfiles."
