# My Config Setup

Personal configuration files.

## Cloning

This repository may be cloned anywhere, but for simplicity reasons you can clone it into ~/.config

```
cd ~/.config
git clone https://gitlab.com/Lincoln-Yuji/zz-config-setup
```

## Installation

This repositories are organized in such way we can use [stow](https://github.com/aspiers/stow) to setup everything.
Stow has many uses and we can use it to easily create symbolic links.

```
cd ~/.config/zz-config-setup
stow <dir-01> <dir-02> ...
```

Stow uses the parent directory as target directory by default. This is why we cloned the repo into ~/.config so stow
will use that as target directory.

It's possible to change the target directory though:

```
stow --target=<path> ALACRITTY/ NVIM/ ...
```

So in case the repo is not into ~/.config we can use --target flag to force a different target.

Another we also use -t as a simpler aproach:

```
stow -t <path> ALACRITTY/ NVIM/ ...
```

## A plus

Since I'm interested on tracking other files such as ~/.bashrc we can use -t to change the target directory to our home
directory:


```
stow --dotfiles -t HOME/
```

We are using the --dotfiles so we can force stow to replace the "dot-" suffix from files to a period.
For example this will create a symlink ~/.bashrc to ~/(stow-dir)/HOME/dot-bashrc.
We are using this strategy to avoid creating directories full of hidden files.
