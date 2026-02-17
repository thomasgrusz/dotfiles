#!/usr/bin/env bash

# *********************************************************************
# Install latest helix pre-built binary (x86_64 Linux) and dependencies
# *********************************************************************

set -euo pipefail

GREEN="\033[1;92m"
PURPLE="\033[1;95m"
RESET="\033[0m"

BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/helix"
COMPLETIONS_DIR="$HOME/.local/share/bash-completion/completions"
TMPDIR=$(mktemp -d /tmp/helix.XXXXXX)
trap 'rm -rf "$TMPDIR"' EXIT

# ────────────────────────────────────────────────────────────────
# Install helix
# ────────────────────────────────────────────────────────────────
echo "Installing helix ..."
cd "$TMPDIR"
url="$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest |
    grep -oP '(?<="browser_download_url": ")[^"]*x86_64-linux\.tar\.xz')"
curl --proto '=https' --tlsv1.2 -#fL "$url" | tar --strip-components=1 -xJf -

mkdir -p "$CONFIG_DIR" "$BIN_DIR" "$COMPLETIONS_DIR"
cp -r runtime "$CONFIG_DIR/runtime"
cp hx "$BIN_DIR/hx"
cp contrib/completion/hx.bash "$COMPLETIONS_DIR/hx"

# shellcheck disable=SC2016
# Ensure ~/.local/bin in PATH
if ! [[ ":$PATH:" =~ :$BIN_DIR: ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
    echo "Added $BIN_DIR to PATH (source ~/.bashrc or restart terminal)"
fi

echo

# ────────────────────────────────────────────────────────────────
# Install helix dependencies
# ────────────────────────────────────────────────────────────────
# helper function
install_binary() {
    local name="$1"              # displayname
    local repo="$2"              # e.g. tamasfe/taplo
    local asset_pattern="$3"     # regex to match the download URL
    local extract_cmd="$4"       # command to pipe the download into
    local bin_name="${5:-$name}" # final binary name in $BIN_DIR

    if command -v "$bin_name" &>/dev/null; then
        echo "OK - $name already installed, skipping"
        return
    fi

    echo "$name..."
    local url
    url=$(curl -s "https://api.github.com/repos/$repo/releases/latest" |
        grep -oP "(?<=\"browser_download_url\": \")[^\"]*${asset_pattern}(?=\")")

    curl --proto '=https' --tlsv1.2 -#fL "$url" | $extract_cmd >"$BIN_DIR/$bin_name"
    chmod +x "$BIN_DIR/$bin_name"
}

# Install dependencies
echo -e "Installing dependencies from github to ~${BIN_DIR#"$HOME"} ...: "
install_binary "taplo" "tamasfe/taplo" "taplo-linux-x86_64\.gz" "gzip -d"
install_binary "marksman" "artempyanykh/marksman" "marksman-linux-x64" "cat"
install_binary "ty" "astral-sh/ty" "ty-x86_64-unknown-linux-gnu\.tar\.gz" "tar xzf - -O"
install_binary "shellcheck" "koalaman/shellcheck" "linux\.x86_64\.tar\.xz" "tar -xJOf - --strip-components=1 --wildcards */shellcheck"
install_binary "shfmt" "mvdan/sh" "linux_amd64" "cat"
install_binary "black" "psf/black" "black_linux" "cat"

# `shellcheck' leaves extra files -> clean up
rm -f "$BIN_DIR"/{LICENSE,README}.txt 2>/dev/null

echo

# ────────────────────────────────────────────────────────────────
# Install NPM packages
# ────────────────────────────────────────────────────────────────
echo "Installing dependencies via npm ..."
npm install -g \
    bash-language-server \
    oxlint \
    prettier \
    typescript \
    typescript-language-server \
    tree-sitter-cli --quiet

echo -e "\nInstalled node packages (global):"
npm -g ls --depth=0 --parseable | tail -n +2 | xargs -n1 basename | sed 's/^/- /'

# ────────────────────────────────────────────────────────────────
# Final success message
# ────────────────────────────────────────────────────────────────
if [[ -x "$BIN_DIR/hx" ]]; then
    echo -e "\n${GREEN}SUCCESS!${RESET} - $("$BIN_DIR/hx" -V) installed (${PURPLE}~${BIN_DIR#"$HOME"}/hx${RESET}). Run: hx"
fi
