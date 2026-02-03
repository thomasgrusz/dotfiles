#!/usr/bin/env bash
set -euo pipefail

## Install latest Helix pre-built binary (x86_64 Linux)

# Download Helix
TMPDIR="/tmp/helix"
mkdir -p "$TMPDIR"
cd "$TMPDIR"
URL=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+x86_64-linux\.tar\.xz')
curl --proto '=https' --tlsv1.2 -fsSL "$URL" | tar -xJf - --strip-components=1 -C .

# Install Helix
mkdir -p "$HOME"/.config/helix
cp -r runtime "$HOME"/.config/helix/runtime
mkdir -p "$HOME"/.local/bin
cp hx "$HOME"/.local/bin/hx

# Install bash completion for Helix
mkdir -p "$HOME/.local/share/bash-completion/completions"
cp contrib/completion/hx.bash "$HOME/.local/share/bash-completion/completions/hx"

# shellcheck disable=SC2016
# Ensure ~/.local/bin in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export [[ ":$PATH:" == *":$HOME/.local/bin:"* ]] || export PATH="$PATH:$HOME/.local/bin"' >>~/.bashrc
    echo "Added ~/.local/bin to PATH in ~/.bashrc — run 'source ~/.bashrc' or restart terminal"
fi

# Cleanup
cd
rm -rf "$TMPDIR"

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

## Install dependencies for Helix

curl --proto '=https' --tlsv1.2 -fsSL \
    https://github.com/tamasfe/taplo/releases/latest/download/taplo-linux-x86_64.gz |
    gzip -d - | install -D -m 755 /dev/stdin ~/.local/bin/taplo

curl --proto '=https' --tlsv1.2 -fsSL \
    https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 |
    install -D -m 755 /dev/stdin ~/.local/bin/marksman

curl --proto '=https' --tlsv1.2 -fsSL \
    https://github.com/astral-sh/ty/releases/latest/download/ty-x86_64-unknown-linux-gnu.tar.gz |
    tar xzf - -O | install -D -m 755 /dev/stdin ~/.local/bin/ty

# sudo apt update -qq && sudo apt install shellcheck shfmt black
URL="$(curl -s https://api.github.com/repos/koalaman/shellcheck/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+linux\.x86_64\.tar\.xz')"
curl --proto '=https' --tlsv1.2 -fsSL "$URL" | tar -xJf - --strip-components=1 -C ~/.local/bin
rm ~/.local/bin/LICENSE.txt ~/.local/bin/README.txt 2>/dev/null

URL="$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+linux_amd64')"
curl --proto '=https' --tlsv1.2 -fsSL "$URL" | install -D -m 755 /dev/stdin ~/.local/bin/shfmt

URL="$(curl -s https://api.github.com/repos/psf/black/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+black_linux(?=")')"
curl --proto '=https' --tlsv1.2 -fsSL "$URL" | install -D -m 755 /dev/stdin ~/.local/bin/black

npm install -g bash-language-server oxlint prettier typescript typescript-language-server --silent

echo -e "\nHelix $(~/.local/bin/hx -V) installed. Run with: hx"
