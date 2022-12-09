# Arch Linux package manager (pacman)

We've been using `pacman` to install packages, groups and to upgrade our
system. But pacman can do much more than that and, sometimes, things may
get out of whack and break. It's important to have some commands and flags
in mind if you intend to try to administrate your system or fix something.

This guide doesn't cover every `pacman` functionality. To get a complete
and more robust guide about the package manager, nothing better than the
[ArchWiki](https://wiki.archlinux.org/title/pacman) itself.

Some `pacman` flags might look too obscure and confusing at the beginning.
You can run `pacman --help` and `man pacman` to see every utility's usage.

To see detailed information about each major flag, run:

```sh
pacman [-F|-Q|-R|-S|-U] --help
```

There is also an [html page](https://archlinux.org/pacman/pacman.8.html)
which contains a simplified tour about it.

## 1. Installing packages

As we've seen, installing new packages is simple:

```sh
sudo pacman -S [package(s)]
```

If you try to install a package which is already installed on the system, it
will be reinstalled even if it's already up-to-date. To avoid that you can use
the `--needed` flag:

```sh
sudo pacman -S [packages(s)] --needed
```

## 2. Removing packages

To remove package(s), leaving all of the dependencies installed:


```sh
sudo pacman -R [package(s)]
```

The `-R` flag can be followed by a group of optional sub-flags:

+ `-c, --cascade`

Removes packages, as well as all packages that depend on one or more them. This
operation is recursive and <strong>must be used with care</strong>! It has the
the potential to remove serveral needed packages from your system. Only use it
if you do know the target packages don't have needed dependents recursively.

+ `-n, --nosave`

Removes backup files from the system that were related to the removed packages.

+ `-s, --recursive`

Removes packages and its dependencies which (A) <strong>are not required by 
other installed packages</strong> and (B) were not explicitily installed by
the user. This operation is recursive and helps to keep a clean system
without orphans. If you want to omit condition (B), just pass this option twice.

+ `-u, --unneeded`

Removes packages that are not required by any other packages. This is useful when
removing a group. Some packages from this group might be needed but others don't.
This flag will only remove the group and only the unneeded packages in it.

As we know, we can combine those flags. Example:

```sh
sudo pacman -Rns [package(s)]
```

You can use the `pactree` command from `pacman-contrib` package to see the dependency
tree of a package:

```sh
pactree <package_name>
```

## 3. Upgrading packages

+ According to the ArchWiki:

Before upgrading, users are expected to visit the Arch Linux home page to check the
latest news, or alternatively subscribe to the RSS feed or the arch-announce mailing list.
When updates require out-of-the-ordinary user intervention (more than what can be handled
simply by following the instructions given by pacman), an appropriate
[news post](https://archlinux.org/news/) will be made.

Before upgrading fundamental software (such as the kernel, xorg, systemd, or glibc) to a
new version, look over the [appropriate forum](https://bbs.archlinux.org/) to see if there
have been any reported problems.

Users must equally be aware that upgrading packages can raise unexpected problems that could
need immediate intervention; therefore, it is discouraged to upgrade a stable system shortly
before it is required for carrying out an important task. Instead, wait to upgrade
until there is enough time available to resolve any post-upgrade issues.

+ Checking updates:

We can use `pacman -Sy` to check for updates, however this is <strong>NOT RECOMENDED</strong>
by the ArchWiki. 
See [Partial upgrades are not supported](https://wiki.archlinux.org/title/System_maintenance#Partial_upgrades_are_unsupported).

Instead we can use the `checkupdates` command from the `pacman-contrib` package to see
all the upgradeable packages currently:

```
$ checkupdates
```

+ Upgrading the system:

```sh
$ sudo pacman -Syu
```

## 4. Querying and Listing packages database

Pacman queries the local package database with the `-Q` flag, the sync database with the
`-S` flag and the files database with the `-F` flag.

To look up for packages, you can use the `-Ss` flag followed by a keyword.
For example, if we want to see all the packages related to `nvidia` we can
just run:

```sh
pacman -Ss nvidia
```

That will list all the packages available (both installed or not).

You can list all the packages installed on the system by running `pacman -Q`.
However if you wish to query, for example, only the `nvidia` related packages
you can run:

```
pacman -Qs nvidia
```

Remember we have installed the `plasma` group. A group is a collection
of multiple packages. To see the packages in this group, run:

```sh
pacman -Sg plasma
```

If you know there's a file named `file_name` but don't know what package contains
that file, you can use `-F` to discover:

```sh
$ sudo pacman -Fy # Sync the files database
$ pacman -F <file_name>
```

You can display extensive information about a given package:

```sh
pacman -Si <package_name>
```

To retrieve a list of the files installed by a package:

```sh
pacman -Ql <package_name>
```

To list all packages no longer required as dependencies (orphans):

```sh
pacman -Qdt
```

To list all packages explicitly installed and not required as dependencies:

```sh
pacman -Qet
```

## 5. Cleaning the package cache

Pacman cache behaviour explained [here](https://wiki.archlinux.org/title/pacman#Cleaning_the_package_cache).

We can use the `paccache` program from `pacman-contrib` package. It deletes all cached versions of
installed and uninstalled packages, <strong>except for the most recent three ones</strong>, by default:

```sh
$ sudo paccache -r
```

Let's say you just want to keep the last past version. You can specify that using:

```sh
$ sudo paccache -rk1
```

To remove only the cache of uninstalled packages, use the `-u` flag:

```
$ sudo paccache -ru
```

Of course, this will keep the three most recent ones. To delete all of them, you have two options:

```
$ sudo paccache -ruk0
$ sudo pacman -Sc
```

We can also delete everything in cache using `pacman -Scc`, but using this command is
extremely discouraged unless the user desperately needs to free more storage.

## 6. Failed Upgrade with corrupted PGP keys

If a system upgrade fails because of corrupted or outdated keys, you have to update your `archlinux-keyring`
package first:

```
$ sudo pacman -Sy archlinux-keyring
```

After updating your keys, you can upgrade your system with `pacman -Syu`.
