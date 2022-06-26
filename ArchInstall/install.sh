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

# Note (1): All systemd services are located in /usr/lib/systemd/systemd

# Note (2): If you need to fix your localtime for some reason, see the actual correct time HH:MM:SS
# And then update the system time with systemd: $ timedatectl set-time 'HH:MM:SS'

# Start (Assuming the host already has git installed)
echo "Driver Option:"
echo "  1) Intel"
echo "  2) NVDIA"
echo "  3) AMD"
echo "  4) Arch Virtual Box"
read -p "Select a VALID driver! " VIDEO_OPTION

case VIDEO_OPTION in
    "1") sudo pacman -S xf86-video-intel ;;
    "2") sudo pacman -S nvidia nvidia-settings ;;
    "3") sudo pacman -S xf86-video-amdgpu ;;
    "4") sudo pacman -S virtualbox-guest-utils ;;
    *) echo "[ ABORT! ] Invalid driver option..."; exit 1
esac

echo "[ COMPLETE! ] Installation finished!"
exit 0

sudo pacman -Syyu  # Update
sudo pacman -S base-devel pacman-contrib --needed

# Video
sudo pacman -S xorg xorg-xinit awesome arandr

# Audio
sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa pavucontrol pulsemixer

# Installing graphical themes
sudo pacman gtk3 gtk4            # Gtk libraries
sudo pacman -S breeze breeze-gtk # For both GTK and Qt
sudo pacman -S qt5ct             # Qt5 engine
# To set GTK2 system wide themes edit /etc/gtk-2.0/gtkrc

# Tools
sudo pacman -S alacritty firefox acpi ripgrep font-manager vim stow unzip bash-completion \
    imagemagick youtube-dl gimp neofetch htop wmctrl

# Installing the aura AUR helper
cd $(mktemp -d)
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U [the-package-file-that-makepkg-produces]

# Synchronize
sudo aura -Ayu

# Installing the LightDM login display
sudo pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm.service
# Set the correct theme editing /etc/lightdm/lightdm-gtk-greeter.conf

# Installing betterlockscreen
sudo aura -A betterlockscreen

cd $HOME/.config/betterlockscreen && ./config.lua # Script to set new wallpaper to lockscreen
sudo systemctl enable betterlockscreen@$USER.service --now

# Fonts and Emojis
sudo pacman -S noto-fonts-emoji
sudo aura -A nerd-fonts-hack
# Japanese and Chinese glyphs
sudo pacman -S adobe-source-han-sans-jp-fonts adobe-source-han-sans-cn-fonts
sudo pacman -S adobe-source-han-serif-jp-fonts adobe-source-han-serif-cn-fonts

# Neovim
sudo pacman -S neovim && sudo aura -A nvim-packer-git

# Utilities
sudo pacman -S vlc nemo gscreenshot qalculate-gtk

# Polkit so we can run simple stuff without having to open a root prompt
sudo pacman -S polkit lxsession-gtk3

sudo pacman -S zathura zathura-pdf-poppler
sudo pacman -S pqiv

sudo pacman -S virtualbox virtualbox-host-modules-arch
sudo pacman -S transmission-gtk # Torrent Client

# Link to config files
stow CFG/

# Link to files/folders on my home directory
CONFIG_DIR=$HOME/.config/zoomer-config
rm $HOME/.bashrc
rm $HOME/.bash_profile
ln -s ${CONFIG_DIR}/HOME/.profile $HOME/.profile
ln -s ${CONFIG_DIR}/HOME/.bashrc $HOME/.bashrc

# Create the .local folders
mkdir -p $HOME/.local/share/fonts
mkdir -p $HOME/.local/bin

# Link the shell scripts to the local bin directory
cd $CONFIG_DIR
stow -t $HOME/.local/bin SHELL-SCRIPTS/

# Git user config
# git config --global user.email "lincolnyuji@hotmail.com"
# git config --global user.name "Lincoln Yuji de Oliveira"

# Installing Latex
# sudo pacman -S texlive-core texlive-latexextra texlive-bibtexextra texlive-formatsextra 

# Installing ZSH
sudo pacman -S zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions
