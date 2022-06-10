#!/bin/env bash

# sudo apt update && apt full-upgrade

# sudo apt install timeshift discord bashtop neofetch acpi \
#     ripgrep nodejs npm;
# sudo apt install ibx11-dev libxcursor-dev ninja-build cmake;
# sudo apt install gettext libtool libtool-bin autoconf automake pkg-config unzip;

# If we want to install latex, we don't want to make the full instaltion
# This one is the recomended for us:
# sudo apt install texlive-latex-extra apt-file
# sudo apt-file update

# If we need to install additional packages, we can search for them using the
# apt-file command:
# $ apt-file search <file-name>
# This will find the pakages that conatain <file-name>, for example:
# $ apt-file search titling.sty

# ===================================================================================================== #

# Arch Linux session (Still not automated)

# Start (Assuming the host already has git installed)
sudo pacman -Syyu  # Update
sudo pacman -S base-devel pacman-contrib

# Video
sudo pacman -S xorg xorg-xinit xf86-video-[driver-name] awesome arandr

# Audio
sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa pavucontrol pulsemixer

# Tools
sudo pacman -S alacritty firefox acpi ripgrep font-manager vim stow unzip bash-completion \
    imagemagick youtube-dl gimp neofetch htop

# Installing the aura AUR helper
cd $(mktemp -d)
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U [the-package-file-that-makepkg-produces]

# Synchronize
sudo aura -Ayy

# Installing and setting the Ly login manager
sudo aura -A ly
sudo systemctl enable ly.service && sudo systemctl start ly.service

# Fonts and Emojis
sudo pacman -S noto-fonts-emoji
sudo aura -A nerd-fonts-hack

# Neovim
sudo pacman -S neovim && sudo aura -A nvim-packer-git

# GTK utilities
sudo pacman -S gtk3 gtk4 \
    celluloid evince eog nemo gscreenshot font-manager qalculate-gtk

# Link to config files
stow CFG/

# Link to files/folders on my home directory
rm $HOME/.bashrc
rm $HOME/.bash_profile
ln -s $XDG_CONFIG_HOME/zz-config-setup/HOME/.bash_profile $HOME/.bash_profile
ln -s $XDG_CONFIG_HOME/zz-config-setup/HOME/.bashrc $HOME/.bashrc

# Create the .local folders
mkdir -p $HOME/.local/share/fonts
mkdir -p $HOME/.local/bin

# Link the shell scripts to the local bin directory
cd $HOME/.config/zz-config-setup
stow -t $HOME/.local/bin SHELL-SCRIPTS/

# If you need to fix your localtime for some reason, see the actual correct time HH:MM:SS
# And then update the system time with systemd: $ timedatectl set-time 'HH:MM:SS'

# Packages from the AUR:
# sudo aura -A gscreenshot ly

# Git user config
git config --global user.email "lincolnyuji@hotmail.com"
git config --global user.name "Lincoln Yuji de Oliveira"

# Installing Latex
sudo pacman -S texlive-core texlive-latexextra texlive-bibtexextra texlive-formatsextra 

# Polkit so we can run simple stuff without having to open a root prompt
sudo pacman -S polkit lxsession-gtk3
