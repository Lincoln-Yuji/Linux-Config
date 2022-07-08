# Steam Client on Arch Linux

According to the official Steam Support, Steam for Linux only supports Ubuntu LTS
with Unity, Gnome or KDE desktops. Any issues regarding Steam support on Arch Linux
shouldn't be a Valve's problem since they are not promising things to work on
every linux distribution. Keep that in mind!

Official claim [here](https://help.steampowered.com/en/faqs/view/1114-3F74-0B8A-B784).

## 1. Enable multilib
We have to enable the [multilib](https://wiki.archlinux.org/title/Official_repositories#multilib)
Arch repositories. According to the Arch Wiki: "multilib contains 32-bit software and libraries
that can be used to run and build 32-bit applications on 64-bit installs (e.g. wine, steam, etc)".

To enable multilib, uncomment the [multilib] section in /etc/pacman.conf:

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

After upgrading the system, we are ready to install packages from multilib:

```sh
sudo pacman -Syu
```

## 2. Steam Requirements

There are some requirements that must be fulfilled in order to run Steam on Arch Linux. This
guide may be out dated compared to the Arch Wiki. To ensure you have all the requirements, you
can follow the [wiki](https://wiki.archlinux.org/title/steam) along these steps:

+ Installed 32-bit version OpenGL graphics driver:

    |  Brand | OpenGL 32-bits (multilib) |
    |:------:|:-------------------------:|
    |   AMD  |         lib32-mesa        |
    |  Intel |         lib32-mesa        |
    | NVIDIA |     lib32-nvidia-utils    |

```sh
sudo pacman -S <driver>
```

+ Generated en\_US.UTF-8 locale, preventing invalid pointer error:

If you don't have it generated, you can use your Desktop Environmet GUI to do so. You can also
do it manually by uncommenting the following line on /etc/locale.gen:

```
en_US.UTF-8 UTF-8
```

Then generate the location running:

```sh
sudo locale-gen
```

+ The GUI heavily uses the Arial font and also you might want Asian languages support by the Client:

```sh
sudo ttf-liberation wqy-zenhei
```

+ If using systemd-networkd for network management, install lib32-systemd in order for Steam to be
able to connect to its servers:

```sh
sudo pacman -S lib32-systemd
```

## 3. Steam Client

Now just install the steam package from multilib:

```sh
sudo pacman -S steam
```
The installation process will create a launcher in your ~/Desktop directory. You can run your Steam client
by executing it.

## 4. Proton Steam-Play

Valve developed a compatibility tool for Steam Play based on Wine and additional components named Proton.
It allows you to launch many Windows games. See the [ProtonDB](https://www.protondb.com/) compatibility
list to discover which games are currently supported and how good they are running on Linux.

It is open-source and available on [their GitHub](https://github.com/ValveSoftware/Proton/).
Steam will install its own versions of Proton when Steam Play is enabled.

Proton needs to be enabled on Steam client: Steam > Settings > Steam Play. You can enable Steam Play for games that
have and have not been whitelisted by Valve in that dialog.

If needed, to force enable Proton or a specific version of Proton for a game, right click on the game,
click Properties > Compatibility > Force the use of a specific Steam Play compatibility tool, and select the desired
version. Doing so can also be used to force games that have a Linux port to use the Windows version.

You can also install Proton from AUR with proton or proton-git:

```sh
# proton-git if you want the current git version
sudo aura -A proton
```

However extra setup is required for them to work
with Steam. See the Proton GitHub for details on how Steam recognizes Proton installs.
