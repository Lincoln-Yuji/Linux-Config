#!/bin/bash

sudo apt update && apt full-upgrade

sudo apt install timeshift discord bashtop neofetch acpi \
    ripgrep nodejs npm;
sudo apt install ibx11-dev libxcursor-dev ninja-build cmake;
sudo apt install gettext libtool libtool-bin autoconf automake pkg-config unzip;

# If we want to install latex, we don't want to make the full instaltion
# This one is the recomended for us:
sudo apt install texlive-latex-extra apt-file
sudo apt-file update

# If we need to install additional packages, we can search for them using the
# apt-file command:
# $ apt-file search <file-name>
# This will find the pakages that conatain <file-name>, for example:
# $ apt-file search titling.sty

# ===================================================================================================== #

# Arch Linux session

# =============== #
# NSTALLING STUFF #
# =============== #

# Start
# sudo pacman -Ssyu  # Update
# sudo pacman -S base-devel 

# Video
# sudo pacman -S xorg xorg-xinit xf86-video-<depende> awesome

# Audio
# sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa

# Tools
# sudo pacman -S alacritty firefox acpi ripgrep font-manager vim stow unzip git
# Git user config
# git config --global user.email "lincolnyuji@hotmail.com"
# git config --global user.name "Lincoln Yuji de Oliveira"

# cp /etc/X11/xinit/xinitrc $HOME/.xinitrc

# === Awesome Autostart === #

# Configuração no final do xinitrc
# exec awesome

# Configuração no final do .bash_profile
# echo "# Using startx on login"
# echo "[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1" >> ~/.bash_profile

# Apps
# sudo pacman -S rofi neovim # Remember to install the packer plugin from github

# If you need to fix your localtime for some reason, see the actual correct time HH:MM:SS
# And then update the system time with systemd: $ timedatectl set-time 'HH:MM:SS'

# ========================= #
