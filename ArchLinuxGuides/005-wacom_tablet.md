# Wacom Tablet on Linux

According to the ArchWiki: Wacom does not officially support Linux. Linux support is
provided by the Linux Wacom Project (which notably has several developers who work for Wacom).

That means we can use Wacom Tablets on most Linux distros out there, including Arch.

The Arch Linux kernels include the input-wacom driver, that is, the kernel should recognize
your tablet right after connecting it via USB or Bluetooth.

You can check that out running:

```sh
sudo dmesg | grep -i wacom
```

If it's not recognized, your only chance is that your tablet is supported by a more recent
driver than the one in your kernel. In that case install the input-wacom-dkms package from
AUR:

```
sudo aura -A input-wacom-dkms
```

## 1. Device compatibility in X server

Install the Xorg wacom driver and then restart the X server so the new udev rules take effect:

```sh
# Log out and log in after this
sudo pacman -S xf86-input-wacom
```

We can check out if X is handling the wacom devices by running:

```sh
xinput list | grep -i wacom
```

If it does not, we'll have to
[setup manually](https://wiki.archlinux.org/title/wacom_tablet#Manual_setup).

## 2. KDE graphical tools

KDE provides a graphical user interface for tablet configuration and supports tablet-specific
profiles and hotplugging. To enable that, install:

```sh
sudo pacman -S kcm-wacomtablet
```

You can now launch the <strong><em>Wacom Tablet Finder</em></strong> application and see
if KDE detected and connected to your device. You should be good to go if everything so far
is ok.

You can tweak some configuration through KDE's interface going to:

+ Settings > Input Devices > Graphic Tablet

More info about wacom on arch [here](https://wiki.archlinux.org/title/wacom_tablet).

## 3. Assign tablet to one screen

If you have a multi-monitor system, you will realize that, by default, your wacom tablet's
surface is mapped to all your displays resolution summed up.

You can easily map your tablet to just one screen through the KDE interface in 
<strong><em>Graphic Tablet</em></strong>.
Open the <strong><em>Tablet</strong></em> tab and click the
<strong><em>Map Tablet Area to Screen</strong></em> button.

Select your desired screen by clicking <strong><em>Toggle Screen</strong></em> and
make sure you have <strong><em>Full Tablet</strong></em> selected.

Click <strong><em>Ok</strong></em> and then <strong><em>Apply</strong></em>.

<h4>3.1 Assign without KDE tools</h4>

If you don't have access to these KDE tools or just don't want to use them, you can
map your wacom tablet using the xinput command. Note that this step will only work in an
X11 session.

I'll show you an example below. First of all, run <strong>xinput list | grep -i wacom</strong>
and then <strong>xrandr</strong>:

```
❱❱❱ xinput list | grep -i wacom
⎜   ↳ Wacom Intuos S Pad pad                  	id=10	[slave  pointer  (2)]
⎜   ↳ Wacom Intuos S Pen stylus               	id=11	[slave  pointer  (2)]

❱❱❱ xrandr
Screen 0: minimum 8 x 8, current 3920 x 1080, maximum 32767 x 32767
DVI-D-0 connected 1360x768+2560+0 (normal left inverted right x axis y axis) 700mm x 375mm
   1280x720      60.00 +  59.94    59.65    50.00
   1920x1080     59.94    50.00    29.97    23.98    60.05    60.00    50.04
   1440x480      60.05
   1360x768      59.80*
   1024x768      60.00
   800x600       60.32
   720x576       50.00
   720x480       59.94
   640x480       59.94    59.93
HDMI-0 connected primary 2560x1080+0+0 (normal left inverted right x axis y axis) 673mm x 284mm
   2560x1080     60.00*+
   1920x1080     60.00    59.94    50.00    60.05    60.00    50.04
   1680x1050     59.95
   1600x900      60.00
   1280x1024     75.02    60.02
   1280x720      60.00    59.94    50.00
   1152x864      75.00
   1024x768      75.03    60.00
   800x600       75.00    60.32
   720x576       50.00
   720x480       59.94
   640x480       75.00    59.94    59.93
DP-0 disconnected (normal left inverted right x axis y axis)
DP-1 disconnected (normal left inverted right x axis y axis)
```

Let's say I want to map my wacom tablet to the DVI-D-0 display. I can do this by running:

```sh
xinput map-to-output 10 DVI-D-0
xinput map-to-output 11 DVI-D-0
```

Your wacom tablet should be mapped into the correct screen now. There are ways to do this
using the <strong>xsetwacom</strong> command, but that will require some math which depends
on your display resolution. To be honest, I find it painful to use this command to set anything.
I usually do every configuration through the GUI that my DE provides.
