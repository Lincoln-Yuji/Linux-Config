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

One easy way to ensure your user has access to libvirt daemon is to add it as a member of the
libvirt user group:

```
sudo usermod -G libvirt -a $USER
```

## Troubleshooting
