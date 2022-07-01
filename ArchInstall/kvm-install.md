# Using KVM - Kernel-Based Virtual Machine

KVM is a hypervisor built into the Linux kernel. It's a special operating mode of QEMU using
CPU extensions for virtualizations via kernel module. It's not simple emulation and since it's
directly integrated into the kernel, the VM's performance boosts up a lot.

This is a little personal guide on how to setup and get KVM running some virtual machines
on Arch Linux.

## Step 1: Virtualization
First of all, we need to make sure we have virtualization enaled, otherwise we can't use the
KVM Linux module. In order to check that, run the following command:

```
LC_ALL=C lscpu | grep Virtualization
```

This will prompt a line informing your CPU's virtualizer. If nothing shows up then either you have
to enable virtualization on your BIOS or your CPU model doesn't support virtualization at all.

If you know your processor does have virtualization support, then enable in your system's BIOS and
rerun the command to check if everything is working.

## Step 2: Installing packages

There are some packages that we need to install to easily be able to use KVM on Arch Linux. We
need to install [QEMU](https://wiki.qemu.org/Main_Page) as our machine emulator and virtualizer.
Running QEMU as a virtualizer is exactly what will give us a huge performance boost compared to
an ordinary machine emulator. We can use QEMU's virtualization excuting it under the KVM
hypervisor.

We can get a very minimal QEMU installation installing the qemu-base package:

```
sudo pacman -S qemu-base
```

Now it's important to notice that QEMU does not provide a GUI to manage virtual machines
(other than the window that appears when running a virtual machine), nor does it provide a way
to create persistent virtual machines with saved settings.

We can install the [libvirt](https://wiki.archlinux.org/title/Libvirt) package which will
provide us multiple tools to manage our virtual machines:

```
sudo pacman -S libvirt
```

Network connectivity will be important to install and use some operating systems. Libvirt can
use the default NAT/DHCP networking and we can easily get that functionality installing:

```
sudo pacman -S iptables-nft dnsmasq dmidecode
```

A graphical user interface will help us a lot while using libvirt and QEMU. We can install
Virt-Manager to graphically manage KVM via libvirt:

```
sudo pacman -S virt-manager
```

## Step 3: Libvirt daemon authenticator
We can now enable the libvirt daemon and use an authenticator (polkit, for instance) to control
the machanisms used for client connections independently.

Initialize the libvirt daemon:

```
sudo systemctl enable libvirtd
```

One easy way to ensure your user has access to libvirt daemon is to add it as a member of the
libvirt user group:

```
sudo usermod -G libvirt -a $USER
```

Relog to ensure the changes were deployed.

## Troubleshooting
We are theorically already ready to go. However, some additional configurations may be required
since some default libvirt settings will be, perhaps, not desired. Also we may face some problems
regarding the installation.

This is more focused on personal preferences and issues I faced than a general thing.

### 1. How to change KVM libvirt default storage pool location
By default all the images created by livirt will be created on /var/lib/libvirt/images/, however
I would rather have the images installed at some place inside my user directory, for example:
~/Desktop/Qemu-KVM.

We can easily achieve that using virt-manager:

+ Open Virt-Manager, right-click on QEMU/KVM hypervisor option and click on Details.
+ Under the Storage section, ensure the default pool is selected.
+ Click Stop Pool and then Delete Pool in the bottom left pane.
+ Click the plus (+) sign on the bottom left pane to create a new storage pool.
+ We can give it the name 'default' and the type 'Filesystem directory'.
+ On Target Path, write the new path: /home/\<username\>/Desktop/Qemu-KVM and then Finish.
+ Check the Autostart On Boot box to automatically start the new pool at system boot.

More details
[here](https://ostechnix.com/how-to-change-kvm-libvirt-default-storage-pool-location/).

### 2. Cannot access storage file, Permission denied in KVM Libvirt
Since we change our Libvirt storage location, we may face issues regarding permissions. One
quick and easy way to fix that is editing the /etc/libvirt/qemu.conf file:

```
[...]
Some examples of valid values are:
#
#   user = "qemu"
#   user = "+0"
#   user = "100"
#
#user = "root"

# The group for QEMU processes run by the system instance. It can be
# specified in a similar way to user.
#group = "root"
[...]
```

Uncomment and change those lines to:
```
user = "<username>"
group = "libvirt"
```

Save the file and, again, ensure the user is a member of the group libvirt.

Finally, restart the libvirtd service:

```
sudo systemctl restart libvirtd
```

Relog if necessary and check if everything is fine. More details
[here](https://ostechnix.com/solved-cannot-access-storage-file-permission-denied-error-in-kvm-libvirt/).

### 3. How to fix "network 'default' is not active" error in libvirt
When we install QEMU/KVM in linux via libvirt, the default NAT network is created automatically
by the libvirtd daemon. If the default network is inactive, we won't be abe to start any guest
virtual machine which is configured to use the network.

You can check the state of all networks by running the following command:

```
sudo virsh net-list --all
```

Virsh is the command line front-end for libvirt and should already be installed since it comes
with the libvirt package.

We can firstly try to fix the issue running:

```
sudo virsh net-start default
```

If you get an error like "internal error: Network is already in use by interface virbr0" then
we have to make some extra steps.

First, we need to destroy the virbr0 bridge, the one associated to the default network. If for
some reason libvirtd chose another bridge with another name to the default, use this name!

```
sudo ifconfig virbr0 down
sudo brctl delbr virbr0
```

Now start the default network:

```
sudo virsh net-start default
```

This will re-create the virbr0 bridge and the connection should work fine now. To check it out,
run:

```
sudo virsh net-list --all
```

If the default network is now set with "Autostart = No" then run the following command.
It will make the default network to automatically get started by libvirtd daemon.

```
sudo virsh net-autostart default
```

More details
[here](https://www.xmodulo.com/network-default-is-not-active.html).
