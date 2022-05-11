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
