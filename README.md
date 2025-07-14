# Configuration Repo for Stow

Personal configuration files, that can be quickly setup using **Stow**.

## Cloning

This repository may be cloned anywhere, but it's usual to clone it into `~/.config`:

```bash
cd ~/.config
git clone https://gitlab.com/Lincoln-Yuji/Linux-Config linux-config
```

## Installation

This repositories are organized in such way we can use [stow](https://github.com/aspiers/stow)
to setup everything. Stow has many uses and we can use it to easily create symbolic links.

```bash
cd ~/.config/linux-config
stow <directory_01> <directory_02> ...
```

Stow uses the parent directory as target directory by default. This is why we cloned the repo into ~/.config so stow
will use that as target directory.

## Directories

It's possible to change the target directory in some cases. This section covers that...

+ **HOME** direcory: contains configuration files that stay in user's `home` folder:

```bash
cd ~/.config/linux-config
stow --target="$HOME" HOME/
```

+ **SHELL-SCRIPT** directory: contains some shell scripts for task automation.

They must be targeted to .local/bin so our $PATH will find them:

```bash
cd ~/.config/linux-config
stow --target="${HOME}/.local/bin" SHELL-SCRIPTS/
```

## Optional

It's possible to put all the home files we want to track other in one folder like HOME/ and
stow them. If you would like to aviod creating a diretory full of hidden files you can name
them such as HOME/dot-bashrc for example. Stow has a special flag --dotfiles, which replaces
the 'dot-' suffix to a proper dot.

```bash
stow --dotfiles -t $HOME HOME/
```

# Solving some possible issues

## - Official GPG keys

If you try to install or update packages from Arch official repositories and get an error
about either missing, corrupted or invalid GPG keys (usually happens when your arch version
gets old) you can update all the keys running the following command:

```bash
sudo pacman -Sy archlinux-keyring
```

## - Arch User Repository GPG keys

When installing packages from the AUR you also may face problems involving invalid GPG keys.
Usually this error is caught when you are building the files using makepkg. If the authentication
fails, the building process is terminated. It's always possible to see makepkg's log and see
what happened. If it says something like "unkown public key \<code\>" that means this key is
missing and you have to manually add it by doing:

```bash
gpg --recv-keys <code>
```
