#######################################
 SysRescue First Steps
#######################################

.. note::
	This documentation is extracted from the System Rescue CD documentation found on line at http://www.sysresccd.org/Online-Manual-EN. Please refer to the original documentation there.

Booting from SystemRescueCd
==================================

+ Insert the SystemRescueCd and boot your system.
+ Use :kbd:`Up` or :kbd:`Down` cursor keys to move the menu highlight.
+ Press :kbd:`F2/F3/F4/F5/F6` to read advanced boot instructions.
+ Press :kbd:`<Tab>` to edit options on any line.
+ Press :kbd:`<Enter>` to boot the currently selected item.

.. Note::
	A boot command has two parts: the boot image name, and the boot options. When editing a command, use spaces to separate options. For example you may want to boot with *rescue64* as boot-image and *docache setkmap=us* as boot-options. The resulting command would be :kbd:`rescue64 docache setkmap=us`.

Main boot images
""""""""""""""""""""""

There are four main boot images with SystemRescueCd. The differences are detailed in the kernel page.

+ **rescuecd**: The default for 32bit systems, you can use it by default for most things.
+ **rescue64**: Use the default 64 bit kernel if you have a 64bit capable processor.
+ **altker32**: This alternative kernel for 32bit systems may work if you have problems with the standard kernel.
+ **altker64**: This alternative kernel for 64bit systems is provided in case you have problems with *rescue64*.

Main boot options
""""""""""""""""""""""

Here are the most common boot options:

+ **docache**: Copies the SysRescueCD files to RAMfs, which permits the CD to be ejected and which means programs will load faster.
+ **setkmap=cc**: Specify keyboard: *us* for USA, *uk* for british, *de* for german, ...
+ **root=/dev/idxn**: the *root=<device>* option boots an existing linux system. For example, if you have a linux Gentoo installed on */dev/sda6*, use :kbd:`rescuecd root=/dev/sda6`.
+ **ide=nodma** or **all-generic-ide**: Use these options if the kernel boot process hangs on a driver related to storage.
+ **doxdetect** or **forcevesa**: Use these options if you cannot get the graphical environment to work.
+ **acpi-off / noapic / irqpool**: Use these options to solve kernel boot problems.

Additional Programs
===========================

.. note::
	Some included programs boot from their own floppy image. Choose :kbd:`F) Run system tools from floppy disk image ...` to select from a menu of these programs.

Working in the console mode
""""""""""""""""""""""""""""""

+ Mount disk partitions in order to troubleshoot an installed Linux or a Windows system. You can mount linux filesystems (ext2fs, ext3fs, reiserfs, reiser4, jfs, xfs) and FAT and NTFS partitions used by MS Windows (eg: :kbd:`ntfs-3g /dev/sda1 /mnt/windows`).
+ You can backup/restore data or operating system files.
+ Midnight Commander (type :kbd:`mc`) is able to copy/move/delete/edit files and directories.
+ **vim** and **qemacs** editors can be used to edit files.
+ Six virtual consoles are available. Press :kbd:`Alt+F1` for the first virtual console, :kbd:`Alt+F2` for the second one, ...

Working in the graphical environment
""""""""""""""""""""""""""""""""""""

To use graphical tools (such as *GParted*), start the graphical environment by typing :kbd:`wizard`. There are two graphical environments: *Xorg* and *Xvesa*. Try *Xorg* first, but if it fails to start, run :kbd:`wizard` again and choose *Xvesa* which should always work. The drawback is that *Xvesa* is not optimized for your hardware and it requires a 32bit kernel (*rescuecd* or *altker32*); it is not available on 64bit kernels (*rescue64* and *altker64*).

The graphical environment allows you to work with *GParted* (partition manager), to use graphical editors (*Geany* or *GVim*), to browse the web with *Firefox* and use terminals like *xfce-terminal* or *mrxvt*.

Setting up your network
===============================

*SystemRescueCd* can connect you to your network, provided your system has supported hardware, the network interface card (NIC) was auto-detected, and the driver is loaded. This functionality allows you to make a backup over the network, download files, work remotely using *ssh*, *telnet*, access files that are shared on a Unix server with *NFS*, or access a MS Windows system with *Samba*.

+ **Network Manager**: The most convenient way to configure your network is to use the *Network-Manager* service in the graphical environment. This friendly tool makes the network configuration much easier, especially if you are attempting to connect to wireless networks. Start *Network Manager* by clicking the small icon in the task bar next to the clock when you are in the graphical environment.

 .. note::
	To configure the network by hand using *dhcp*, *net-setup*, or *ifconfig*, first you must stop the *Network-Manager* service: :kbd:`/etc/init.d/NetworkManager stop`.

+ **dhcpd**: To use dynamic configuration, at the command shell type :kbd:`dhcpcd eth0`. Use :kbd:`ifconfig -a` to display the IP address which the DHCP server leased to the interface.

+ **net-setup**: To configure the network by hand from text mode, type :kbd:`net-setup` at the shell prompt.

+ **ifconfig**, **route**: You can also use shell commands to configure a network interface, assigning an IP address and a default gateway. To assign a specific static IP address, enter something such as: :kbd:`ifconfig eth0 192.168.10.17`. Next configure the default route gateway. For example, for an interface at address 192.168.10.17 connected to a gateway at 192.168.10.2, enter :kbd:`route add default gw 192.168.10.2`.
