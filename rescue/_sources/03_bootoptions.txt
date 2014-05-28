##################################
 Sysem Rescue CD Boot Options
##################################

.. note::
	This documentation is extracted from the System Rescue CD documentation found on line at http://www.sysresccd.org/Online-Manual-EN. Please refer to the original documentation there.

Kernels on SystemRescueCd
===========================

standard-kernels: (rescuecd and rescue64)
""""""""""""""""""""""""""""""""""""""""""""

+ recent linux version: linux-2.6.35 with recent linux-stable fixes
+ kernel sources are based on vanilla (it is stable) with the sysresccd patchset.
+ both IDE and SATA hard disk drivers are based on the libsata (all disks are sda, sdb, ...)
+ almost all disk-controllers (IDE, SATA, SCSI) and network drivers are compiled as modules (so that you can use noload-xxx if it hangs)
+ supports the frame buffer, the frame buffer can be enabled with the boot option (vga=xxx)
+ the standard kernel is preferred if you want to use either ext4 or btrfs

alternative-kernels: (altker32 and altker64)
""""""""""""""""""""""""""""""""""""""""""""""

+ stable linux version version: linux-2.6.32.25
+ kernel sources are based on linux-2.6.32 (series with long term maintenance) with the sysresccd patchset
+ the two kernel images are altker32 (32bit) and altker64 (64bit)
+ both IDE and SATA hard disk drivers are based on the libsata (all disks are sda, sdb, ...)
+ almost all disk-controllers (IDE, SATA, SCSI) and network drivers are built-in (no need to load a module)
+ no frame buffer support

32 bit kernels
""""""""""""""""""

+ rescuecd and altker32 are the two 32bit kernels provided
+ any Intel/AMD/VIA based processor should work with the 32bit kernel
+ you can run a 32bit kernel even if you have a processor that supports 64bit instructions (amd64 / em64t)
+ you can work (backup/restore) 64bit programs with a 32bit kernel
+ you cannot chroot on an existing linux partition with 64bit programs with a 32bit kernel

64 bit kernels
""""""""""""""""""

+ rescue64 and altker64 are the two 64bit kernels provided
+ 64bit kernels will work only if your processor supports amd64 (AMD implementation of x86_64) or em64t (Intel implementation of x86_64) instruction set.
+ 64bit kernels do not work on IA64 / Itanium processors.
+ You must use a 64bit kernel if you want to chroot to a linux system using 64bit programs.
+ 64bit kernels can execute 32bit programs since the IA32 instructions support is included in the kernel

Choosing a kernel
===========================

Pressing [Enter] boots SystemRescueCD with defaults that are a good starting point.
These kernels are available:
+ **rescuecd** Default for 32bit systems, with Framebuffer disabled, best choice.
+ **rescue64** Default 64 bit kernel. Use it if you want to chroot to a 64bit linux system installed on your hard disk, or if you have to run 64 bit programs. This kernel is able to boot with 32bit programs, and it requires a processor with 64bit instructions (amd64 / em64t).
+ **altker32** an alternative kernel for 32bit systems. Boot with this kernel if you have problems with rescuecd
+ **altker64** an alternative kernel for 64bit systems. Boot with this kernel in case you have problems with rescue64.

Booting from the CD-ROM
============================

.. Note::
	To boot from a CD-ROM ensure that the BIOS is configured to boot from a CD drive before the hard disk. To start SystemRescueCd, insert the CD in the drive, and power on or reset your computer.

Move up and down the SystemRescueCD menu with the cursor keys. To change the options for a selection, press :kbd:`<Tab>`; press :kbd:`<Esc>` to return to the menu from the options entry line. Press :kbd:`<Enter>` at any time to start the highlighted selection.

As the system begins to load, if you did not disable this option, the map for your keyboard will be requested. Next, the kernel will continue to load, and the hardware configuration will be autodetected. Boot scripts will load kernel modules required for all detected hardware automatically. Boot will end with a shell prompt, where you have several linux consoles available. You can change between them by pressing Alt+F1 for the first one, Alt+F2 for the second, ...

Boot options
============================

General boot options
""""""""""""""""""""""""

Press :kbd:`<Tab>` to add additional options.

+ **docache**: causes the CD-ROM to be fully loaded into memory. A slower start but once complete, programs start faster and the CD drive will be released allowing normal access to other CDs. This requires 400MB of memory to cache everything (including the bootdisks and isolinux directories). Add lowmem if you have less that 400MB of memory of to prevent these directories from being copied.
+ **setkmap=kk**: defines the keymap to load (example: :kbd:`setkmap=de` for German keyboards). This way you will not be prompted for the keyboard configuration during the boot.
+ **root=/dev/xdnp**: the *root=<device>* option boots an existing linux system. For example, if you have linux Gentoo installed on */dev/sda6*, use :kbd:`rescuecd root=/dev/sda6` to start it. Keep in mind that you must use a 64bit kernel if your system is made of 64bit programs. This option works with LVM volumes, e.g., :kbd:`rescuecd root=/dev/VolGroup00/LogVol00`. The option :kbd:`root=auto` will scan all the block devices for a linux system; the first linux system found will be started. So *root=auto* lets you start the system installed from the CD-ROM in case you have problem with your boot loader or kernel. If the label of the partition where linux is installed is *mylinux*, then boot it using rescuecd :kbd:`root=LABEL=mylinux`. Similarly specify a partition using its uuid: :kbd:`root=UUID=b3d3bec5-997a-413e-8449-0d0ec41ccba7`.
+ **initscript=service:action**: This option allows one to start/stop a service at boot time. For instance if you need the samba service to be started, you can boot with: :kbd:`initscript=samba:start`. This does the same thing as */etc/init.d/samba start*. Use this option a multiple of times for different services. All the actions that are supported by an initscript can be used.
+ **backstore=xxx**: SystemRescueCd comes with support for the backing-stores. A backing-store saves all the changes you can make, so that you keep these changes the next time you boot. By default, sysresccd automatically scan removable devices (eg: USB sticks) at boot time and uses the first backing-store it finds. A backing-store is not mandatory and if the scan fails, it will store the files which have changed in memory. To disable the disks scan at boot time specify :kbd:`backstore=off` on the boot command line. If you want to save your backing-store file on a harddisk, boot with :kbd:`backstore=alldev` to scan all devices (not just removable devices). The default location for a backing-stores file is any file named *sysrcd.bs* located at the root of a disk which is often a USB stick. Change the path by using :kbd:`backstore=/sysrcd/mybackstore.bs`.
+ **isoloop=xxx**: Grub2 will boot from an ISO image which is stored on the hard disk. If you put a copy of *systemrescuecd.iso* on a partition that Grub2 can read then you can boot SystemRescueCd directly from the ISO image stored on your hard drive. When booting an image, SystemRescueCd must be aware that its *sysrcd.dat* file is in an ISO and not directly on the partition. For that reason, this :kbd:`isoloop=xxx` boot option is required in your *grub.cfg*. This option specifies the path of the ISO image in the partition that grub considers as its root partition. The path of the ISO image may be different from the path on your linux system. If you have a separate boot partition mounted on */boot* and if you copy this ISO image to */boot/sysrcd/systemrescuecd-x86.iso* then the option has to be :kbd:`isoloop=/sysrcd/systemrescuecd-x86.iso`. This is because the boot partition is what Grub2 will consider as its root partition during the boot process.

Hardware, drivers and troubleshooting options
""""""""""""""""""""""""""""""""""""""""""""""

+ **dodebug**: Enables verbose messages in linuxrc.
+ **doload=xxx**: loads needed kernel modules, multiple comma separated occurrences are permitted (example: :kbd:`doload=3c59x,e1000`).
+ **noload=xxx**: prevents loading kernel modules, multiple comma separated occurrences are permitted (example: :kbd:`noload=3c59x,e1000`). Use this option if you have a problem when the system loads a particular module.
+ **nonet**: this will disable the network auto detection at startup.
+ **scandelay=x**: pauses x seconds during the startup to allow slow devices to initialize. This is required when you boot a USB device. A delay of only few seconds should be enough.
+ **doxdetect**: This option forces the system to run the *mkxf86config* startup script and to run the hardware auto-detection from this script. Use this option if you have problems with the graphical environment configuration. This option replaces the option noxdetect that was useful in previous versions.
+ **nodetect**: prevents generic hardware auto-detection.
+ **nomodeset**: Do not load the Kernel-Mode-Setting video driver. You can use that option if you are experiencing problems with your screen during the boot process (just after modules are being loaded).
+ **dostartx**: load the X.Org graphical environment.
+ **forcevesa**: Forces X.Org to use the safe VESA driver instead of the best video driver detected for your video card. Use this option if you cannot get the graphical environment working with the default options.
+ **forcevesa=xxx**: The startx command will load the Xvesa server instead of Xorg, and use the screen resolution given as parameter (e.g. :kbd:`1024x768`, :kbd:`1280x1024x32`).
+ **all-generic-ide**: In case of problems related to your hard disk, try to enable this option (e.g. :kbd:`rescuecd all-generic-ide`).
+ **nodmraid**: Disable dmraid, for some motherboards with built-in RAID controller.
+ **nomdadm**: Disable mdadm, for software RAID.
+ **acpi-off / noapic / irqpool**: use these options if, during boot, the kernel hangs on a driver, or if it crashes, ...
+ **lowmem**: For systems with smaller memory, some daemons are not started including *sshd* and *nfsd*.
+ **skipmount=/dev/xxx**: The system mounts all the storage devices at boot time to find the *sysrcd.dat* file. If your hard disk is broken it should not be mounted. Boot with :kbd:`skipmount=/dev/sda1 skipmount=/dev/sda2` to ignore these two partitions, for example.

Network configuration and remote access
""""""""""""""""""""""""""""""""""""""""

+ **nonm**: Use this option to disable the Network-Manager service that conflicts with the standard network command line tools such as :kbd:`ifconfig` and :kbd:`ip`. This option is not necessary when SystemRescueCd is booting from the network since the service is automatically stopped in that case.
+ **dodhcp**: will request a DHCP server provide network attributes including IP address, gateway, and so forth. If there are multiple interfaces on the computer it will run the dhcp client on all of them by default, when no argument is specified with this option. Optionally specify which interfaces should be configured with dhcp to combine static and dynamic addresses in the automatic Ethernet configuration. For example, to use dhcp for *eth0* and *eth2* and a static address on *eth1*, you can use options like::

	dodhcp=eth0,eth2 eth1=192.168.128.1/24.

+ **nodhcp**: never run the dhcp client in the initramfs boot script. May be useful if you use PXE boot on a computer with several ethernet interfaces.
+ **ethx=ipaddr/cidr**: Sets the static IP address of all the ethernet interfaces on the system. The :kbd:`/cidr` extension is optional. For instance, if you use option :kbd:`ethx=192.168.0.1` on a machine with two ethernet adapters, both *eth0* and *eth1* will be configured with *192.168.0.1*. You can use the format :kbd:`ethx=10.0.0.1/24` (using the cidr notation) if you do not use the default netmask.
+ **eth0=ipaddr/cidr**: This option is similar to *ethx=ipaddr/cidr* but it configures only one interface at a time. To configure the network on a server that has two interfaces, use, for example: :kbd:`eth0=192.168.10.1/24 eth1=192.168.20.1`.
+ **dns=ipaddr**: Sets the static IP address of the DNS nameserver you want to use to resolve the names. For instance :kbd:`dns=192.168.0.254` means that you want to use *192.168.0.254* as the DNS server.
+ **gateway=ipaddr**: Sets the static IP address of the default route on your network. For instance :kbd:`gateway=192.168.0.254` means that the computer can connect to a computer outside of the local network via *192.168.0.254*.
+ **dhcphostname=myhost**: Sets the hostname that the DHCP client will send to the DHCP server. This may be required if the default hostname cannot be used with your DHCP configuration.
+ **rootpass=123456**: Sets the root password of the system running on the livecd to *123456*. That way you can connect from the network and ssh on the livecd and give *123456* password as the root password.
+ **vncserver=x:123456**: This options forces the system to configure the VNC-server and to start it automatically at boot time. You have to replace *x* with the number of displays you want, and *123456* with your password. The password must be between 5 and 12 characters, else the boot option will be ignored. In other words the command option :kbd:`vncserver=2:MyPaSsWd` will give you access to two displays, display=1 on tcp/5901 and display=2 on tcp/5902 (Display 0 is reserved for X.Org).
+ **nameif=xxx**: You can specify what interface name to give to a particular interface using the mac address. Here is how you can specify which interface is using which mac address on a machine with two network interfaces: :kbd:`nameif=eth0!00:0C:29:57:D0:6E,eth1!00:0C:29:57:D0:64`. Be careful, you have to respect the separator (comma between the interfaces and exclamation marks between the name and the mac address). You can also use the magic keyword :kbd:`BOOTIF` when you boot from pxelinux. The pxeboot loader will set *BOOTIF* to the name of the interface used to boot. You can then use something like :kbd:`nameif=eth0!BOOTIF` if you want the boot interface to be called *eth0* on a computer with several Ethernet interfaces.

Network boot using PXE
===========================

SystemRescueCd provides several options for booting from the network using PXE. These options can be combined with other network boot options such as *ethx* (cf previous section). See PXE network booting to get a global overview of SystemRescueCd and PXE and Manage remote servers using PXE.
The second stage downloads the kernel + initramfs using DHCP/TFTP.
The third stage of the PXE boot process acquires the root files system.
Several protocols are available.

+ **netboot=tftp://ip/path/sysrcd.dat**: from a TFTP server. The filesystem is loaded into memory. As a consequence computers with less than 400MB of memory will not be able to boot this way. The system will continue to work if the network is disconnected after the boot process.
+ **netboot=http://ip:port/path/sysrcd.dat**: from a Web server. The file system is loaded into memory. Computers with smaller memory will not be able to boot this way. The the system continues to work if the network is disconnected after the boot process.
+ **netboot=nfs://ip:/path**: mount an NFSv3 directory. The NFS url must be the path of the directory that contains *sysrcd.dat*. Only NFSv3 can be used, NFSv4 is not supported. NFS allows computers with smaller memory to boot SystemRescueCd from the network. After the boot process, continued network connection is required or you will loose access to the root file system.
+ **netboot=nbd://ip:port**: connect to an NBD server configured with *sysrcd.dat* on *ip:port*. NBD is easier to configure than NFS (only one TCP port involved) and it allows computers with smaller memory to boot SystemRescueCd from the network. After the boot process, the network connection continues to be required to access the root file system.

Options provided for autorun
============================

+ **ar_source=xxx**: place where the autorun are stored. It may be the root directory of a partition (*/dev/sda1*), an nfs share (*nfs://192.168.1.1:/path/to/scripts*), a samba share (*smb://192.168.1.1/path/to/scripts*), or an http directory (*http://192.168.1.1/path/to/scripts*).
+ **autoruns=[0-9]**: comma separated list of the autorun script to be run. For example, the option :kbd:`autoruns=0,2,7` will run the scripts *autorun0*, *autorun2*, and *autorun7*. Use :kbd:`autoruns=no` to disable all the autorun scripts with a number.
+ **ar_ignorefail**: continue to execute the scripts chain even if a script failed (returned a non-zero status).
+ **ar_nodel**: do not delete the temporary copy of the autorun scripts located in */var/autorun/tmp* after execution.
+ **ar_disable**: completely disable autorun, the simple autorun script will not be executed.
+ **ar_nowait**: do not wait for a keypress after the autorun script have been executed.

.. Note::
	Refer to the on-line documentation at http://www/sysresccd.org for help with any of the following options.

Changing default boot options
===================================

Follow this instruction to create a personalized SystemRescueCd and edit *syslinux.cfg* to add your options. Use the *sysresccd-custom* script to extract the current files of the livecd, edit *isolinux.cfg* (*syslinux.cfg* with USB keys), and recreate the ISO image. If you use the network booting via PXE feature edit *pxelinux.cfg/default* on your PXE boot server.

Booting from the network via PXE
===================================

It is also possible to boot SystemRescueCd from the network. Since the installation is not obvious, there is a dedicated chapter to network booting via pxe.

Booting with an old computer
===================================

Many old computers cannot boot a CD-ROM. If you have such a problem, you can try to create a boot floppy that allows you to start the system on the CD-ROM. SmartBootManager can create such a boot floppy for you. If you have no floppy drive, you can install this bootloader on the hard disk too. Using this boot manager is easy. You must download *sbminst*, and run the installer from Linux. Here is the most common install process::

	./sbminst -t us -d /dev/fd0

Booting from a Virtual Machine
===================================

It is possible to use SystemRescueCd from Windows or Linux with a complete computer emulator, such as VMWare and Virtual PC. You have to declare the ISO image as the virtual CD-ROM drive. In the virtual BIOS, you must ask the computer to boot from the CD-ROM. It is even possible to use the network. The virtual machine will have a new IP address.

Booting from the Windows partition
=====================================

It is now possible to install SystemRescueCd on an NTFS / FAT partition used by Windows. It means you do not have to partition your disk, and you can even boot SystemRescueCd if there is no cdrom drive in your computer.
