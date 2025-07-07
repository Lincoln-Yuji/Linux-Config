#!/bin/env bash

# Install the big three: Alacritty, ZSH and Zellij

# Fedora
sudo dnf copr enable sramanujam/zellij

sudo dnf install \
    alacritty \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    fzf \
    zellij

# Arch
sudo pacman -S \
    alacritty \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    zsh-completions\
    fzf \
    zellij