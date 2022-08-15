#!/bin/zsh

local style
style="38;5"
for color in {0..255} 
do
    tag="\033[${style};${color}m"
    string="${style};${color}"
    echo "${tag}${string}"
done
