#!/bin/zsh

local base_dir
local dotfile_location
base_dir="/Users/thomasgrusz/computer science/iMac 25"
dotfile_location="${base_dir}/dotfiles"

if [[ ! -e ${dotfile_location} ]]; then
	mkdir ${dotfile_location}
fi

cp ~/.zshrc ${dotfile_location}
cp ~/.bashrc ${dotfile_location}
cp ~/.gitconfig ${dotfile_location}
cp ~/.vimrc ${dotfile_location}
cp ~/.git-prompt.sh ${dotfile_location}
cp -r ~/.myScripts ${dotfile_location}
