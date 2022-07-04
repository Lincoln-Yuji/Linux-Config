# Installing KDE Plasma on Arch Linux

Basic installation guide for KDE plasma desktop environment.

## 1. Xorg installation

Before installing Plasma, make sure your have a working Xorg installation on your system:

```
sudo pacman -Syu
sudo pacman -S xorg xorg-xinit
```

## 2. Pipewire audio server

KDE uses pulseaudio as default audio server. If we attempt to install KDE we are going to get
pulseaudio. We can use pipewire and avoid major conficts installing pipewire-pulse on top of it.
The desktop environment will comunicate with the audio server as if it was pulseaudio, but the
actual engine running under the api is pipewire.

```
sudo pacman -S pipewire wireplumber pipewire-pulse gst-plugin-pipewire
```
Now ensure to have the service enabled:

```
sudo systemctl --user enable pipewire.service pipewire-pulse.service
```

## 3. Plasma installation

Now we are ready to go with Plasma installation:

```
sudo pacman -S plasma gtk2 gtk3 gtk4 --needed
```

If you want to use a wayland section or have nvdia hardware, refer to the
[Arch Wiki](https://wiki.archlinux.org/title/KDE) page.

## 4. KDE Applications

The plasma package doesn't bring the KDE applications such as file manager, terminal emulator, etc.
If you wish to install EVERY single KDE application available, you can install the kde-applications
group package:

```
sudo pacman -S kde-applications
```

However, you may not be willing to install everything in this group. Pacman will prompt all the
packages included in this group and require a confimation to install it. You can see more about
all these applications [here](https://archlinux.org/groups/x86_64/kde-applications).

This is a list of applications that I find useful:

```
sudo pacman -S ark dolphin dolphin-plugins dragon elisa filelight gwenview kalgebra kate \
    kbackup kcalc kcron kalendar kdeconnect kdialog kget kgpg kmix kmousetool kruler \
    ksystemlog ktimer ktorrent krita okular sweeper spectacle print-manager
```

## 5. Other applications and programs

We are using KDE, but we are not limited to just KDE applications. If you think some KDE
application sucks you can just install an alternative which you consider better.

```
sudo pacman -S alacritty firefox font-manager gimp ripgrep stow unzip bash-completion \
    neofetch htop bashtop youtube-dl acpi neovim pavucontrol --needed
```

## 6. Configuration

Here we will set some applications up. Some of them will require packages from the AUR. You can
use any AUR helper or install every package manually. Here we will install the
[aura](https://github.com/fosskers/aura) AUR helper:

```
cd $(mktemp -d)
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U *.pkg.tar.zst # The compressed bin
```

### 6.1 SDDM login manager
We got SDDM when we installed the packages from the plasma group. We just need to enable the
service through Systemd:

```
sudo systemctl enable sddm.service
```

The next time you try to login from tty1, you will have a graphical interface.

### 6.2 Neovim
We can install the Packer plugin manager for neovim from the AUR:

```
sudo aura -A nvim-packer-git
```

Now we can just open neovim and run the following command to download all the plugin from github.

```
:PackerInstall
```

To update your plugins, you can run:

```
:PackerSync
```

### 6.3 System Fonts

Some applications won't render fonts properly beacuse our system doesn't have the required fonts
to render some specif glyphs or emojis (discord for instance will be a huge mess):

```
sudo pacman -S noto-fonts-emoji ttf-font-awesome
```

We can also install nerd fonts from the AUR:

```
sudo aura -A nerd-fonts-hack
```

You can install all the available nerd fonts downloading the nerd-fonts package.

### 6.4 Alternative interactive shell: ZSH

We can install shells other than bash onto our system. I think it's fine to keep bash as default
non-interactive shell to users, but I do love ZSH features and extensions on command line:

```
sudo pacman -S zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions
```
