#!/usr/bin/env bash

# **********************************************************************
# Install latest neovim pre-built binary (x86_64 Linux) and dependencies
# **********************************************************************

set -euo pipefail

GREEN='\033[32m'
RED='\033[31m'
FAT_PURPLE="\033[1;95m"
RESET="\033[0m"

BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/nvim"
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
NVCHAD_URL="https://github.com/NvChad/starter"

NERD_FONT_NAME="SourceCodePro"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${NERD_FONT_NAME}.zip"
NERD_FONT_DEST="$HOME/.local/share/fonts/${NERD_FONT_NAME}NerdFont"

NODE_PACKAGE="tree-sitter-cli"
APT_PACKAGES=("ripgrep" "gcc" "make")

# Remove old neovim folders
rm -rf "$CONFIG_DIR"
rm -rf "$HOME/.local/bin/nvim-linux-x86_64/"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.local/share/nvim"

# Install neovim
echo "Installing neovim..."
curl --proto '=https' --tlsv1.2 -#fL "$NVIM_URL" | tar -xzf - -C "$BIN_DIR"
echo -e "${GREEN}✓ neovim $(nvim --version | sed -n 1p | cut -d ' ' -f 2) installed${RESET}"

# Install NERD font: SourceCodePro
echo -e "\nInstalling Nerd Font ${NERD_FONT_NAME}..."
rm -rf "${NERD_FONT_DEST}"
curl --proto '=https' --tlsv1.2 --create-dirs --output-dir "$NERD_FONT_DEST" -#fLO "$NERD_FONT_URL"
unzip -qqod "$NERD_FONT_DEST" "${NERD_FONT_DEST}/${NERD_FONT_NAME}.zip"
rm -f "${NERD_FONT_DEST}/${NERD_FONT_NAME}.zip"
if [[ -d "${NERD_FONT_DEST}" ]]; then
    echo -e "${GREEN}✓ ${NERD_FONT_NAME} installed${RESET}"
fi

# Install/update node package
echo -e "\nInstalling/updating \`${NODE_PACKAGE}'..."
npm -g install --quiet "$NODE_PACKAGE"
if grep -q "$NODE_PACKAGE" <(npm -g list); then
    echo -e "${GREEN}✓ ${NODE_PACKAGE} installed/updated${RESET}"
fi

# Check APT packages
echo -e "\nChecking APT packages..."
for package in "${APT_PACKAGES[@]}"; do
    if dpkg-query -W "$package" >/dev/null 2>&1; then
        echo -e "$GREEN ✓ ${package} is installed${RESET}"
    else
        echo -e "$RED" "✗" "$package" "is not installed. Please install!" "$RESET"
    fi
done

# Install NvChad framework
echo -e "\nInstalling NvChad framework for neovim"
git clone -q "${NVCHAD_URL}" "${CONFIG_DIR}"
if [[ -d "${CONFIG_DIR}" ]]; then
    echo -e "${GREEN}✓ NvChad framework installed${RESET}"
fi
rm -rf "${CONFIG_DIR}/.git"
echo -e "\nRun ${FAT_PURPLE}\`nvim'${RESET} to start neovim and run the following commands inside neovim:"
echo -e "${FAT_PURPLE}:MasonInstallAll${RESET}"
echo -e "${FAT_PURPLE}:TSInstallAll${RESET}"

echo -e "For regular updates run ${FAT_PURPLE}:Lazy sync${RESET}"
echo -e "Learn about customization of ui & base46 ${FAT_PURPLE}:h nvui${RESET}"
