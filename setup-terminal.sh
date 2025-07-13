#!/bin/env bash

# Install the big three: Alacritty, ZSH and Zellij

# Fedora
sudo dnf copr enable sramanujam/zellij

terminal_tools='
alacritty
zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions
fzf fd bat eza ripgrep
zellij
'

sudo $terminal_tools

# Arch
sudo pacman -S $terminal_tools
