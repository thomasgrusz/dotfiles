#!/usr/bin/env bash
set -euo pipefail

## Install latest Helix pre-built binary (x86_64 Linux)

# Get latest tag
TAG=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Dir and file
DIR="helix-${TAG}-x86_64-linux"
FILE="${DIR}.tar.xz"

# Download
curl -L -o "$FILE" "https://github.com/helix-editor/helix/releases/download/${TAG}/${FILE}"

# Extract
tar xf "$FILE"

# Enter dir
cd "$DIR"

# Config dir
mkdir -p "$HOME"/.config/helix

# Copy runtime
cp -r runtime "$HOME"/.config/helix/runtime

# Install binary to ~/.local/bin
mkdir -p "$HOME"/.local/bin
cp hx "$HOME"/.local/bin/hx

# Install bash completion
COMPLETION_DIR="$HOME/.local/share/bash-completion/completions"
mkdir -p "$COMPLETION_DIR"
cp contrib/completion/hx.bash "$COMPLETION_DIR/hx"

# shellcheck disable=SC2016
# Ensure ~/.local/bin in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
    echo "Added ~/.local/bin to PATH in ~/.bashrc — run 'source ~/.bashrc' or restart terminal"
fi

# Cleanup
cd ..
rm -rf "$DIR" "$FILE"

## Install personal Helix config files from the dotfiles repo
# Backup existing configs if they exist (and aren't already symlinks)
backup_dir="$HOME/helix_configs_backup_$(date +%Y%m%d)"
mkdir -p "$backup_dir"

# Array for new Helix config files
files=("config.toml" "languages.toml")

# Backup old files
for file in "${files[@]}"; do
    dot_file="$HOME/.config/helix/${file}"
    if [ -f "$dot_file" ] && [ ! -L "$dot_file" ]; then
        mv "$dot_file" "$backup_dir/$file"
        echo "Backed up $dot_file to $backup_dir"
    fi
done

# Create symlinks for files (with check)
for file in "${files[@]}"; do
    dot_file="$HOME/.config/helix/${file}"
    target="$HOME/dotfiles/helix/$file"
    if [ -L "$dot_file" ] && [ "$(readlink "$dot_file")" = "$target" ]; then
        echo "Symlink $dot_file already correct, skipping."
        continue
    fi
    ln -sf "$target" "$dot_file"
    echo "Symlink $dot_file created."
done

# Cleanup
rmdir "$backup_dir" 2>/dev/null

echo "Helix ${TAG} installed. Run with: hx"
