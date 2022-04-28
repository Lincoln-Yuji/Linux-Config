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
