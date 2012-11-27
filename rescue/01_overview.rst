###################################
System Rescue CD Overview
###################################

.. note::
	This documentation is extracted from the System Rescue CD documentation found on line at http://www.sysresccd.org/Online-Manual-EN. Please refer to the original documentation there.

Background
===================

SystemRescueCd is a Linux system available on a bootable CD-ROM that allows you to repair your system and your data after a crash. It also aims to provide an easy way to do administrative tasks on your computer, such as creating and editing the partitions of the hard disk. It contains a lot of system utilities (parted, partimage, fstools, ...) and basic functions (editors, midnight commander, network tools). It aims to be very easy to use: just boot from the CD-ROM, and you can do everything. The kernel of the system supports most important file systems (ext2/ext3, reiserfs, reiser4, xfs, jfs, vfat, ntfs, iso9660), and network ones (samba and nfs).

You can use SystemRescueCd for many tasks:

+ The first time you use the computer, when no operating system is installed. The first task is creating partitions on the hard disk, and installing the operating system. With this CD-ROM, you can make partitions easily with the graphical partition tool GParted, and you can install Gentoo Linux.
+ After a crash, or a mistake, you may have problems booting. For example, after installing Windows, your bootloader (LILO, Grub) may have been erased from the MBR. With this CD-ROM, you have all you need for reinstalling Grub or Lilo.
+ For windows users that don not have Linux installed, it provides a tiny Linux System with most important system tools. For example, Windows users can backup their system partition using Partimage. They need Linux to run partimage.

Contents
=====================

Here is a short list that describes what you will find on this CD-ROM:

+ A recent Linux kernel, that supports most important file systems, and the most important hardware. Supported file systems include: Ext2/Ext3, Reiserfs, Reiser4, Fat16/Fat32, XFS, JFS, NTFS, and others. The kernel supports NFS and Samba.
+ Graphical partition tools, that aim to be free partition-magic clones for Linux. You can use GParted.
+ Most important console system tools for Linux. Of course, you have GNU Parted (partition editor), Partimage (drive image clone) for backing up partitions to an image file, File system tools (e2fsprogs for ext2/ext3, reiserfsprogs for ReiserFS, reiser4progs for reiser4, xfsprogs for XFS, jfsutils for JFS, dosfstools for FAT, NtfsProgs for NTFS). You can use dump/restore for backing up an ext2/ext3 partition.
+ Ntfs-3g (Ntfs driver third generation) provides a full read-write support for NTFS partitions from Linux.
+ Clam-AntiVirus. This is a free AntiVirus software.
+ Usual tools for Linux users: tar/gzip/bzip2 for archiving files. The same tools for Windows users: zip/unzip, rar/unrar, p7zip are provided. This means that you are able to backup/restore your windows data. We have added DAR (Disk Archiver). This is a program like tar, but more powerful.
+ Midnight-Commander (type "mc" on the console command line) is a free Norton Commander clone for Linux. With mc, it's easy to browse, copy, move, edit all files on your computer. If you don't know all the linux shell commands well, you can start with mc.
+ Lightweight web browsers lynx or links. Under FrameBuffer mode, you can pass parameters to the command line of the links program. It will allow you to enable the graphical mode. It would show images, and you get a nice interface.
+ Of course, editors are important when you have problems. Nano (easy editor),vim (vi improved) and qemacs (emacs clone) are provided for the text mode.
+ The X.Org / Xvesa graphical environments and the WindowMaker window manager. It allows you to use graphical programs such as GParted, editors (gvim and leafpad), and Firefox-2.0 (you may need help from internet).

Getting Started
======================

+ System messages are important. Read the text of messages for information about your system.
+ You can login on another console.
+ The root password is empty.
+ To auto-configure networking, type :kbd:`dhcpcd eth0` (or similar). To set network addresses by hand, use the command :kbd:`net-setup eth0`.
+ To start an ssh server on this system, type :kbd:`/etc/init.d/sshd start`. If you need to log in remotely as root, type :kbd:`passwd root` to reset the root password to a known value.
+ To use graphical tools such as *GParted*, you can use a graphical environment by typing :kbd:`wizard` in the console. You will have the choice between two graphical environments: *Xorg* and *Xvesa*. Try Xorg first, but if it fails to start, run :kbd:`wizard` again and choose *Xvesa*. *Xvesa* should always work, provided you are using a 32bit kernel. (Xvesa does not work on 64bits kernels *rescue64* and *altker64*.)
+ Available editors include: *vim*, *nano*, *qemacs* in console mode. You can also use *gvim* and *leafpad* in the graphical environment.

.. Warning::
	Mounting anything on */mnt* will freeze the system! Use :kbd:`mkdir /mnt/mydir` and :kbd:`mount xxx /mnt/mydir` instead.

