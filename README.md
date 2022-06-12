# My Config Setup

Personal configuration files.

## Cloning

This repository may be cloned anywhere i.e. ~/.config

```
cd ~/.config
git clone https://gitlab.com/Lincoln-Yuji/zoomer-config
```

## Installation

This repositories are organized in such way we can use [stow](https://github.com/aspiers/stow)
to setup everything. Stow has many uses and we can use it to easily create symbolic links.

```
cd ~/.config/zz-config-setup
stow <dir-01> <dir-02> ...
```

Stow uses the parent directory as target directory by default. This is why we cloned the repo into ~/.config so stow
will use that as target directory.

It's possible to change the target directory though:

```
stow --target=$HOME/.config/ CFG/
```

So in case the repository is not into ~/.config we can use --target flag to force a different
target.

We can also use -t as a simpler aproach:

```
stow -t $HOME/.config/ CFG/
```

## Directories

Depending on the directory, they have to be symlinked from different places.

+ CFG directory: contains all the config files and directories that go into .config

The following command should be enough.
```
stow CFG/
```

+ SHELL-SCRIPT directory: contains some shell scripts for task automation.

They must be targeted to .local/bin so our $PATH will find them:
```
stow -t $HOME/.local/bin SHELL-SCRIPT/
```

## Bash

For .bashrc and .bash\_profile it's easier to just symlink them directly:
```
cd ~
ln -s .config/zoomer-config/.bashrc .bashrc
ln -s .config/zoomer-config/.bash_profie .bash_profile
```


## Optional

It's possible to put all the home files we want to track other in one folder like HOME/ and
stow them. If you would like to aviod creating a diretory full of hidden files you can name
them such as HOME/dot-bashrc for example. Stow has a special flag --dotfiles, which replaces
the 'dot-' suffix to a proper dot.

```
stow --dotfiles -t $HOME HOME/
```

# Solving some possible issues

## - Official GPG keys

If you try to install or update packages from Arch official repositories and get an error
about either missing, corrupted or invalid GPG keys (usually happens when your arch version
gets old) you can update all the keys running the following command:

```
sudo pacman -Sy archlinux-keyring
```

## - Arch User Repository GPG keys

When installing packages from the AUR you also may face problems involving invalid GPG keys.
Usually this error is caught when you are building the files using makepkg. If the authentication
fails, the building process is terminated. It's always possible to see makepkg's log and see
what happened. If it says something like "unkown public key \<code\>" that means this key is
missing and you have to manually add it by doing:

```
gpg --recv-keys <code>
```
