# Installing KDE Plasma on Arch Linux

Basic installation guide for KDE plasma desktop environment.

## 1. Xorg installation

Before installing Plasma, make sure your have a working Xorg installation on your system:

```sh
sudo pacman -Syu
sudo pacman -S xorg xorg-xinit
```

Install the video drivers based on your hardware. You may also install OpenGL support:

|  Brand |       Driver      |    OpenGL    |
|:------:|:-----------------:|:------------:|
|   AMD  | xf86-video-amdgpu |     mesa     |
|  Intel |  xf86-video-intel |     mesa     |
| NVIDIA |       nvidia      | nvidia-utils |

Nvidia drivers might turn out a huge pain to handle on Linux. You can install some additional tools
to help you:

```sh
sudo pacman -S nvidia-settings
```

More information about Xorg [here](https://wiki.archlinux.org/title/Xorg).

## 2. Pipewire audio server

KDE uses pulseaudio as default audio server. If we attempt to install KDE we are going to get
pulseaudio. We can use pipewire and avoid major conficts installing pipewire-pulse on top of it.
The desktop environment will comunicate with the audio server as if it was pulseaudio, but the
actual engine running under the api is pipewire.

```sh
sudo pacman -S pipewire wireplumber pipewire-pulse gst-plugin-pipewire
```
Now ensure to have the service enabled:

```sh
# Don't use sudo
systemctl --user enable pipewire.service pipewire-pulse.service
```

## 3. Plasma installation

Now we are ready to go with Plasma installation:

```sh
sudo pacman -S plasma gtk2 gtk3 gtk4 --needed
```

If you want to run Plasma under the Wayland protocol, install the following package. Plasma's default display
manager (SDDM) will be able to find it and then you can simply choose the session through the GUI (X11 or
Wayland).

```sh
sudo pacman -S plasma-wayland-session
```

NVIDIA users need to install the EGL module to be able to start a session using Wayland:

```
sudo pacman -S egl-wayland
```

If having major issues regarding your Wayland sessions on Plasma, either refer to the
[Arch Wiki](https://wiki.archlinux.org/title/KDE#Plasma) page or the
[KDE page](https://community.kde.org/Plasma/Wayland/Nvidia).

## 4. KDE Applications

The plasma package doesn't bring the KDE applications such as file manager, terminal emulator, etc.
If you wish to install EVERY single KDE application available, you can install the kde-applications
group package:

```sh
sudo pacman -S kde-applications
```

However, you may not be willing to install everything in this group. Pacman will prompt all the
packages included in this group and require a confimation to install it. You can see more about
all these applications [here](https://archlinux.org/groups/x86_64/kde-applications).

This is a list of applications that I find useful:

```sh
sudo pacman -S ark dolphin dolphin-plugins dragon elisa filelight gwenview kalgebra kate \
    kbackup kcalc kcron kalendar kdeconnect kdialog kget kmousetool kruler \
    ksystemlog konsole ktimer ktorrent krita okular sweeper spectacle
```

If need printing, install the following:

```sh
sudo pacman -S print-manager cups system-config-printer
```

## 5. Other applications and programs

We are using KDE, but we are not limited to just KDE applications. If you think some KDE
application sucks you can just install an alternative which you consider better.

```sh
sudo pacman -S firefox font-manager gimp unzip godot bash-completion --needed
```

## 6. Configuration

Here we will set some applications up. Some of them will require packages from the AUR. You can
use any AUR helper or install every package manually. Here we will install the
[aura](https://github.com/fosskers/aura) AUR helper:

```sh
cd $(mktemp -d)
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U *.pkg.tar.zst # The compressed bin
```

### 6.1 SDDM login manager
We got SDDM when we installed the packages from the plasma group. We just need to enable the
service through Systemd:

```sh
sudo systemctl enable sddm.service
```

The next time you try to login from tty1, you will have a graphical interface.


### 6.2 System Fonts

Some applications won't render fonts properly beacuse our system doesn't have the required fonts
to render some specifc glyphs or emojis (discord for instance will be a huge mess):

```
sudo pacman -S noto-fonts-emoji ttf-font-awesome
```

We can also install nerd fonts from the AUR:

```sh
sudo aura -A nerd-fonts-hack
```

You can install all the available nerd fonts downloading the nerd-fonts package.

At this point you can just reboot your computer and you will get the SDDM screen to perform
your login and get into the KDE Plasma desktop. You can choose the Wayland session if yo installed
the plasma-wayland-session package.

### 6.3 Tiling windows behaviour in KDE

I've spent some years messing with Tiling Window Managers before finally stick to a proper DE like
Gnome, KDE etc, and somehow I got too spoiled by the tiling behaviour.

There's a third party script made for Kwin (KDE window manager) which does the work called
[bismuth](https://github.com/Bismuth-Forge/bismuth). We can easily download and install it from
the AUR:

```sh
sudo aura -A kwin-bismuth
```

Follow the bismuth's github README and Wiki to set it up initially and troubleshooting.

There's a hacking we can do on multi-monitor systems. Everytime you switch to another virtual
desktop it changes all your screens desktops. KDE doesn't have separated groups of desktops
to each screen (comprhensible resource-wise).

On the window's titlebar there's an option called "On all Desktops", which will make the window
persist on all your current desktops. You can enable/disable this decoration in:
+ SystemSettings > WindowDecorations > ConfigureButtons.

But setting this up to every window we put on other screens is too much of a hassle. I've found
a script that automates that. Every window which is not on the primary display will inherit this
behaviour. You can find it [here](https://github.com/wsdfhjxc/kwin-scripts) and install it:

```sh
cd $(mktemp -d)
git clone https://github.com/wsdfhjxc/kwin-scripts
cd kwin-scripts
./helper.sh install virtual-desktops-only-on-primary
```

After that go to:
+ SystemSettings > WindowManagement > KWinScript

Enable the Virtual Desktops Only on Primary script and you are ready to go.

Note that this is another non-official script and it may break on updates. Keep it in mind!

### 6.4 Import KDE configuration

KDE offers some official ways to import and export your desktop configuration, but I don't find
them too good and some times I couldn't make them work properly (several times the customization
saver widget simply refused to download).

I've found a program written in python called [konsave](https://github.com/Prayag2/konsave). However,
since it's not an official script, it may not work properly sometimes and possibly break your Desktop
settings. Use it while assuming these risks!

First of all, ensure you have the pip python module installed:

```sh
sudo pacman -S python-pip
```

Now just install konsave:

```sh
python -m pip install konsave
```

If you need any help using the program take a look at the github page or run:

```sh
# Alternatively: konsave --help
konsave -h
```

Download your .knsv configuration and import it. After reloggin into your account, you are ready
to go.

If you aren't willing to use this program or any other third party configuration saver, I recommend
saving settings that you really care about and will work exactly the same way regardless of your
machine or installation. Shortcuts, for instance, are a huge hassle to configure every time and you
will probably use the same hotkeys on every KDE installation you do.

Although KDE is very customizable regarding themes, panels, widgets, etc I try to keep my customization
as near to the default one as possible. Honestly, KDE looks good enough with Breeze theme and the
default appearence. Your programs configurations are usually more important.

