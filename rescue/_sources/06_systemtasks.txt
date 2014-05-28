#############################
 System Task Utilities
#############################

.. note:: This documentation is extracted from the System Rescue CD 
   documentation found on line at http://www.sysresccd.org/Online-Manual-EN. 
   Please refer to the original documentation there.

Back up the partition table
=============================

:program:`sfdisk` is a tiny program which saves the partition table to a 
regular file and only takes a few seconds. As an initial step for system 
recovery before making things worse, backup the system table now! For example::

  sfdisk -d /dev/sda > sda.110601.2345.partTable

Copy the backup to another hard disk, removable media (thumb disk, floppy or 
CD) or ftp it to another computer. To Restore a backed up system table, first 
back up the current partition table, even if it seems to be damaged. This will 
allow you to undo the restoration. Then use the command::

  cat sda.110601.2345.partTable | sfdisk /dev/sda

.. Warning:: This command is very dangerous, because it overwrites the existing 
   partition table.

Back up partition contents
=============================

:program:`Partimage` (client and server) are provided, which will save an 
existing partition into an image file. If something goes wrong, you can restore 
the partition from the image. A semi-text interface is provided, and this 
should not be very hard to use. You need a partition with a lot of free space to 
store the image file.

Two versions of :program:`partimage` are provided: one for local use, and one 
for remote administration. The local version is compiled without SSL and 
without login support. The client is available by typing :command:`partimage`, 
and the server with :command:`partimaged`. You should use this client in most 
cases, and when you want to connect to a **partimaged** server that does not 
support SSL. 

The secured version is compiled with SSL and login support. The client is 
available by typing :command:`partimagessl`, and the server with 
:command:`partimagedssl`. You should use this client when you connect to a 
**partimaged** server that expects an SSL encrypted connection with login.

Archiving
=============================

SystemRescueCd comes with a lot of archive programs. You can use 
:program:`zip/unzip` for the *ZIP* format, and :program:`rar/unrar` for the 
*RAR* format. Even the new :program:`7zip` is supported with the 
:command:`p7zip` command.

:program:`dar` is an archiver similar to :program:`tar`, but it is more 
powerful. Even when using compression, :program:`dar` does not have to read the 
whole backup to extract one file. This way, if you just want to restore one 
file from a huge backup, the process will be much faster than using 
:program:`tar`. :program:`Dar` first reads the catalogue (i.e. the contents of 
the backup), then it goes directly to the location of the saved file(s) which 
you want to restore and then proceeds to restoration. In particular using 
slices, :program:`dar` will ask only for the slice(s) containing the file(s) 
to restore. But you can also restore all files from an archive, :program:`dar` 
will then read sequentially without seeking into the file. Except for the first 
and last slice, :program:`dar` will not ask twice for the same slice.

Clam AntiVirus
=============================

:program:`Clam AntiVirus` is a free anti-virus software which provides several 
important commands:

  :command:`freshclam`: This command updates the virus definitions. Of course, 
  you need to be connected to internet for updating.

  :command:`clamscan`: This utility scans all the files in the named directory 
  and searches for viruses.

Before scanning for viruses, you have to update the virus definitions. Because 
this is run from a CD-ROM, you may have read-only related problems. That is why 
you have to specify a read-write directory for definitions. Here is how to 
update definitions and make a scan:

#. ensure that you are connected to the internet.
#. Download the latest virus definitions by running the following commands::

     chown clamav:clamav /var/lib/clamav
     chown clamav:clamav /var/lib/clamav/*
     freshclam

#. Mount the partition to be scanned::

     mkdir -p /mnt/testpart
     mount /dev/sda1 /mnt/testpart

#. Perform the scan on the files::

     clamscan -r /mnt/testpart

If you really don't have an internet connection, you can scan for viruses 
without updating the virus definitions. Of course, it's less safe because only 
the older viruses can be detected.

Graphical Partition Tools
=============================

:program:`gparted` a Partition-Magic clone which is easy to use and very 
powerful. This tool requires the X.Org graphical environment, so refer to the 
boot process if you do not know how to work in X.Org. You can run 
:program:`GParted` by typing this command: :command:`gparted`, or from the 
contextual menu on the desktop.

Accessing NTFS Partitions
=============================

**NTFS** (New Technology File System) is a very powerful file system provided 
with NT versions of Windows (Windows-NT, Windows-2000, Windows-XP). If you want 
full read-write support for NTFS disks, use :program:`Ntfs-3g` (Ntfs third 
generation driver), which is a userspace program. With :program:`clamav` and 
:program:`Ntfs-3g`, you can check and repair viruses on a MS-Windows system 
without running Windows.

Read only support
-----------------------------

To get read support only on an NTFS disk, mount it with the following command 
(replace xxx with the device name of your disk)::

  mount -t ntfs /dev/xxx /mnt/windows -o ro

This read-only support is safe (you cannot alter or damage your data). Use this 
if, for example, you just want to backup several files, or read a document.

Full Read-Write support
-----------------------------

Use :program:`ntfs-3g` for complete NTFS Write support with the command::

  ntfs-3g /dev/sda1 /mnt/windows

In this example, we suppose the device name of the NTFS partition is 
:file:`/dev/sda1` and the mount point is :file:`/mnt/windows`. If you do not 
know the device name, you may list partitions with 
:command:`cat /proc/partitions` or use :program:`GParted`.
