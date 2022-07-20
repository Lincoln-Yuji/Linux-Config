# Arch Linux Installation guide (UEFI)

## 1. Preparations

Some important stuff to do before starting the process

### 1.1 Keyboard layout during installation

Make sure your keyboard layout is defined correctly so you won't have problems
typing commands. It's easy to mess things up while using a wrong keyboard layout.

```
loadkeys br-abnt2
```

### 1.2 Internet connection

We can't proceed with the installation without an internet connection! Type the following to
check if you can get google's server response:

```
ping -c 4 google.com
```

You probably already have a connection if are wired with a ethernet cable. In case you are
using wi-fi, you can use the iwctl command from the iwd package to connect to wi-fi:

```
iwctl
```

Inside the new prompt, type the following command to display the name of all you network
devices:

```
[iwd]# device list
```

Next you have to scan and then display all the networks available with following commands:

```
[iwd]# station <device-name> scan
[iwd]# station <device-name> get-networks
```

Finally, you can connect to a network using:

```
[iwd]# station <device-name> connect <network-name>
```

Type the password if it's required. After that, test again you internet connection:

```
ping -c 4 google.com
```

## 2. Configuring the disk

You can see all your devices and their partitions using the fdisk command:

```
fdisk -l
```

This process will depend on how you actually want to install the system. For example, a raw
Arch Linux installation may be performed cleaning everything inside the device and then
you can create all the partitions yourself.

There's a very good tool that comes with the Arch Linux iso called cfdisk. We can use it
to easilly create a partition table (either MBR or GPT) and then build our partitions:

```
cfdisk /dev/<device-name>
```

Don't forget to write all the changes before quitting.

The configuration will change depending on if you are going to install from a BIOS-Legacy or
UEFI setup. It's strongly recommended to take a look at the
[Arch Wiki](https://wiki.archlinux.org/title/installation_guide) page for more and
updated informations. To perform an UEFI installation, we need to create a ~500MB efi system
partition to allocate the boot entry point to our new system.

If you already have another operating system installed and wishes to do a dual boot, you
just need to create the partition to the new OS file system.

## 3. Formatting the partitions

Now we need to format the new partitions (DO NOT format the partitions that already existed
if you want to either persist the old data or make a dual boot). We can use the mkfs family
of commands from the dosfstools package to format the partitions.

If you need to check the device names, run:

```
fdisk -l
```

+ Formatting the efi system boot partition:

```
mkfs.fat -F32 /dev/<device-name>
```

+ Formatting the system's root partition:

```
mkfs.ext4 /dev/<device-name>
```

+ If you created a SWAP partition, use the following command to make it:

```
mkswap /dev/<device-name>
```

Usually it's more convenient using a SWAPFILE rather than a SWAP partition. If you want to create
a SWAPFILE, just ignore the steps related to the SWAP partition. We can easily create a new
SWAPFILE after the basic installation.

Note that we are not restrained to use EXT4 to our root directory. There are alternatives
such as BTRFS and ZFS. A basic Arch Linux installation should support all of these file
systems out of the box.

## 4. Mounting points

Now we need to mount those partitions onto our future system.

+ Mounting the root partition:

```
mount /dev/<device-name> /mnt
```

+ Creating the boot directory and mounting the efi system partition:

```
mkdir /mnt/boot
mount /dev/<device-name> /mnt/boot
```

+ If you intend to make a dual boot with Windows, you can mount its basic data partition:

```
mkdir /mnt/win
mount /dev/<device-name> /mnt/win
```

By doing this, we will have access to the Windows file system from Arch Linux.

+ If you created a SWAP partition, you can activate it by doing:

```
swapon /dev/<device-name>
```

We can check if everything has been mounted correctly using the the lsblk command:

```
lsblk
```

## 5. Fundamental packages

Now we are going to install some essential packages, such as the Linux kernel and some basic
dev tools. Also, we can install some useful tools like a text editor and a package to
set a dynamic IP address out of the box:

```
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd
```

## 6. Generating the FSTAB

The system needs an FSTAB, a file that describes all of our partions mounting points.
We just need to run the following command:

```
genfstab -U /mnt >> /mnt/etc/fstab
```

You can check if the table has been generated correctly with:

```
cat /mnt/etc/fstab
```
## 7. Entering the system

We have built everything so far inside the /mnt directory. To proceed with the installation
we can change our root directory using the following command:

```
arch-chroot /mnt
```

Now we are on the disk, not the removable media anymore. Every change we do right here will
affect our Arch Linux system.

## 8. Date and time

We can configure our system's date and time making a symbolic link from a zoneinfo file:

```
ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
```

If we are in Brazil, we can usually use the Brasília timezone info (same as São Paulo):

```
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```

Now synchronize the system clock and the hardware clock using the new zone info:

```
hwclock --systohc
```

+ To check if the date and time are correct, just run:

```
date
```

## 9. The system's basic configurations

Open the locale.gen file with a text editor and uncomment the lines with the languages
you would like to set up (as many as you want). For example, we can uncomment:

```
nano /etc/locale.gen
#en_US.UTF-8 UTF-8
```

Now we can generate the language files running:

```
locale-gen
```

+ Create the locale.conf file and set the LANG variable accordingly:

```
nano /etc/locale.conf
LANG=en_US.UTF-8
```
+ Make the keyboard layout changes persistent editing (or creating) the vconsole.conf file:

```
nano /etc/vconsole.conf
KEYMAP=br-abnt2
```
## 10. Network Configuration

Create the hostname file with the host's name:

```
nano /etc/hostname
<myhostname>
```

However, some softwares may still try to read the /etc/host directly. To prevent them from
potentially breaking, we can modify this file as well:

```
127.0.0.1   localhost
::1         localhost
127.0.1.1   <myhostname>
```

## 11. Setting the root's password and creating a new user

Run the following command and set the root's password:

```
passwd
```

To create a new user, we can run the useradd command.

+ -m: Creates the home directory for the user.
+ -U: Creates a group with same name as the user and add them to it as primary group.
+ -G: Lists groups that the user will get added into (will allow it to use sudo).
+ -s: Sets a default shell to the user.

```
useradd -m -U -G wheel,storage,power -s /bin/bash <username>
```

Finally we can set the user's password:

```
passwd <username>
```

## 12. Installing some useful packages

After installing and rebooting, we may want have some packages installed to keep configuring
the system and recover our internet connection.

```
pacman -S dosfstools mtools networkmanager wpa_supplicant wireless_tools \
            dialog git unzip reflector pacman-contrib bash-completion
```

We don't need to install all of them. For example you don't need WPA and wirless tools if
we are using wired connection. But they are all useful depending on how and where you are
installing Arch Linux.

## 13. Installing a boot loader (GRUB)

We can easily install grub as our boot loader. It's very convenient to have a boot loader
installed when we have multiple operating systems installed.

```
pacman -S grub efibootmgr os-prober ntfs-3g
```

You just need the efibootmgr package if you are installing on UEFI mode. The os-prober
will be required in case you want to dual boot the system. Grub will not find the other
operating systems without it. You must install the ntfs-3g package if you want to dual boot
with windows!

To do a simple BIOS-Legacy installation, you just need the grub package.

We now have the grub packages and extensions installed, but the boot loader itself is not
installed yet.

+ To install grub on UEFI mode and 64 bits architecture, run:

```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck
```

+ Just for convenience, if you are attempting to install Arch in BIOS Legacy system, then:

```
grub-install --target=i386-pc --recheck /dev/<device>
```

Note that \<device\> is the device which you are installing your system into (sda, vda, ...).

Before generating grub's config file, we need to modify the /etc/default/grub file to force
the boot loader to use the os-prober extension to search and detect other operating systems
installed.

Open the file and uncomment (or add) the line with this set up:

```
nano /etc/default/grub
GRUB_DISABLE_OS_PROBER=false
```
Finally, we can generate the config file running:

```
grub-mkconfig -o /boot/grub/grub.cfg
```
We can now exit and then reboot the system. If everything worked, we will see the GRUB boot
loader screen.

```
exit
reboot
```

## 14. Sudoers

We can login as the root user and allow members from the wheel group to use sudo:

```
EDITOR=nano visudo
%wheel ALL=(ALL:ALL) ALL
```

## 15. Enable Network Manager
Super user privileges are required to run the following command. Either do it as root or do it
using sudo.

```
systemctl enable NetworkManager --now
```
Test your internet connection using the ping command and see if you get an echo from the
server (google.com, for example). However, the NetworkManager doesn't automatically reconnect
to your wifi. That happens because we firstly connected using the
<strong><em>iNet Wireless Daemon</strong></em> (iwd).

Since NetworkManager is enabled and activated, you can use the nmtui command to open a Text
User Interface and reconnect to your wifi network, reinserting the right credentials.

## 16. Pacman configurations

We can use reflector to generate a server list based on our country to speed up downloads.
The following code will look up for servers hosted in 'country' and write them into 'file'.

```
reflector -c '<country>' --sort rate --save <file>
```

We can just copy the generated addresses and add it to /etc/pacman.d/mirrorlist. Make sure to put
them above every other server so pacman will give them priotity.

If you have a rather good internet connection you may want to speed up stuff even more by enabling
parallel downloads with pacman. You can do that just uncommenting (or adding) the following:

```
sudo nano /etc/pacman.conf
ParallelDownloads = 3
```

This example will allow pacman to perform the maximum of 3 parallel downloads. This file has
lots of things we can change to configure the Arch Linux package manager.

## 16. Creating a Swapfile

If you already have a `swapfile` but want to create a new one to make it larger or smaller,
make sure to `swapoff` it and then delete it:

```
swapoff <swapfile-path>
rm <swapfile-path>
```

After that we can create a new `swapfile` running the following command:

```
dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
```

The `dd` command  stands for `disk-destroyer`. Be careful when using this command since it has the
potential to damage your files and partitions otherwise. You will need super-user privileges when
running it as a regular user.

That command line is basically creating a file `/swapfile` filled with zeros. Each block has a size of
1M (1 megabyte) and there will a total of 4096 blocks. In other words, this file will have a size of 4GB.
You can change these values to create larger or smaller swapfiles.

Also we want to make sure that this file can't be changed or deleted by a random user:

```
chmod 600 /swapfile
```

Now that the file is created we have to actually make it a `swapfile`. Use `mkswap` and then `swapon`
to enable swapping onto this file:

```
mkswap /swapfile
swapon /swapfile
```

We are almost done. We still need to edit the `/etc/fstab` file. Add the following onto your fstab:

```
[ ... ]
# Swapfile
/swapfile none swap sw 0 0
```

Reboot your machine and you are good to go.
