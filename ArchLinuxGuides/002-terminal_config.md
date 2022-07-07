# Terminal Usage

Terminal emulators are great tools for anyone using Linux. KDE is pretty rich when it comes
to GUI configurations giving you the option to almost never touch directly your config files
or open a terminal to set things up. However, it's always nice to have the option to use a
terminal to do some things, specially if you consider yourself a 'power user'.

Here we have a very basic set of configurations regarding the terminal.

## 1. Emulator: Alacritty

Alacritty is a terminal emulator written in rust which supports GPU acceleration. It's very simple
compared to Konsole but on my experience I feel Alacritty is faster and easier to configure. But you
can keep using Konsole if you want. After all it's a great terminal emulator as well.

```sh
sudo pacman -S alacritty
```

## 2. Alternative interactive shell: ZSH

We can install shells other than bash onto our system. I think it's fine to keep bash as the
default non-interactive shell to users, but I do love ZSH features and extensions on command line:

```sh
sudo pacman -S zsh zsh-syntax-highlighting zsh-completions zsh-autosuggestions
```

## 3. Neovim text editor

Neovim is a Vim fork written in LUA. A simple but powerful terminal text editor which inherts all
Vim's functionalities. Very extensible with plugins, really fast and comfy! But you can use Kate if
you rather so since it has a better integration with the rest of the graphical environment.

```sh
sudo pacman -S neovim
```

We can install the Packer plugin manager for neovim from the AUR:

```sh
sudo aura -A nvim-packer-git
```

Now we can just open neovim and run the following command to download all your plugins from github
and update them:

```
:PackerInstall
:PackerSync
```

## 4. Other terminal tools

We can also install other terminal tools to help us on the command line:

```sh
sudo pacman -S ripgrep stow neofetch htop bashtop youtube-dl
```
