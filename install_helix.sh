#!/usr/bin/env bash
set -euo pipefail

## Install latest helix pre-built binary (x86_64 Linux)

# Download helix
echo "Downloading helix ..."
TMPDIR="/tmp/helix"
mkdir -p "$TMPDIR"
cd "$TMPDIR"
URL=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+x86_64-linux\.tar\.xz')
curl --proto '=https' --tlsv1.2 -fsSL "$URL" | tar -xJf - --strip-components=1 -C .

# Install helix
echo "Installing helix ..."
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
        echo -e "Symlink \033[1;94m$dot_file\033[0m already correct, skipping."
        continue
    fi
    ln -sf "$target" "$dot_file"
    echo -e "Symlink \033[1;94m$dot_file\033[0m created."
done

# Cleanup
rmdir "$backup_dir" 2>/dev/null
if [ -f ~/.local/bin/hx ]; then
    echo "-----------------------------------------------------------------------------"
    echo -e "\033[1;92mSUCCESS!\033[0m - $(~/.local/bin/hx -V) installed (\033[1;94m~/.local/bin/hx\033[0m). Run with: hx"
    echo "============================================================================="
    echo
fi

## Install dependencies for Helix

echo "Downloading dependencies from github to ~/.local/bin ...: "
echo "taplo"
curl --proto '=https' --tlsv1.2 -#fL \
    https://github.com/tamasfe/taplo/releases/latest/download/taplo-linux-x86_64.gz |
    gzip -d - | install -D -m 755 /dev/stdin ~/.local/bin/taplo

echo "marsman"
curl --proto '=https' --tlsv1.2 -#fL \
    https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 |
    install -D -m 755 /dev/stdin ~/.local/bin/marksman

echo "ty"
curl --proto '=https' --tlsv1.2 -#fL \
    https://github.com/astral-sh/ty/releases/latest/download/ty-x86_64-unknown-linux-gnu.tar.gz |
    tar xzf - -O | install -D -m 755 /dev/stdin ~/.local/bin/ty

echo "shellcheck"
URL="$(curl -s https://api.github.com/repos/koalaman/shellcheck/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+linux\.x86_64\.tar\.xz')"
curl --proto '=https' --tlsv1.2 -#fL "$URL" | tar -xJf - --strip-components=1 -C ~/.local/bin
rm ~/.local/bin/LICENSE.txt ~/.local/bin/README.txt 2>/dev/null

echo "shfmt"
URL="$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+linux_amd64')"
curl --proto '=https' --tlsv1.2 -#fL "$URL" | install -D -m 755 /dev/stdin ~/.local/bin/shfmt

echo "black"
URL="$(curl -s https://api.github.com/repos/psf/black/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]+black_linux(?=")')"
curl --proto '=https' --tlsv1.2 -#fL "$URL" | install -D -m 755 /dev/stdin ~/.local/bin/black

echo
echo "Download dependencies via npm ...(patience)"
npm install -g bash-language-server oxlint prettier typescript typescript-language-server tree-sitter-cli --quiet
echo
echo "The following node packages are globally installed:"
echo
npm -g ls --depth=0 --parseable | tail -n +2 | xargs -n1 basename
