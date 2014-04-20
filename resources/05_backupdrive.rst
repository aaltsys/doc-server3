.. _backupdrive:

#############################
Automount Drive Setup
#############################

.. warning:: 
   (1) Connecting external drives over eSATA for scheduled backups can result in 
   corrupted RAID arrays on some  motherboards which do not isolate SATA 
   based on boot status.
   
   (2) Zentyal 3.0 through 3.3 automounts USB devices, which interferes with 
   fuse autofs mounts for backup drives connected using USB. 

In this example, an eSATA backup drive is configured as an extended partition 
hard drive formatted NTFS. Since Linux does not honor file permissions on NTFS 
volumes, the backup will be readable by anyone.

Part 1: Install autofs [#]_
-----------------------------

Display a terminal command line on the server console, or ``ssh`` to a server 
command shell. At the command prompt, type::

   sudo apt-get install autofs ntfsprogs

Part 2. Format drive NTFS
-----------------------------

A drive must be formatted before use. We recommend NTFS file system for the 
external backup drive, as then it can be read from either Linux or Windows. 
Use the following instructions to perform this format:

.. Warning:: These instructions assume that the external drive is device 
   **sdc**, and you are using data partition **sdc1**. Verify this, or replace 
   **sdc1** in the following instructions with the correct parameter for your 
   specific system. All instructions are intended to be executed at a terminal 
   command prompt.

#. Identify the device to format::

     ls -al /dev/sd*

#. If mounted, unmount the drive volume with one of the following commands::

     sudo service autofs stop (for an automounted drive).
     sudo umount /dev/sdc (For a standard mount point). 

.. note::
   For Zentyal 3.0 and later, modify the udev rules to prevent USB drives from 
   automounting. [#]_
   
   ::
      sudo bash < <(echo 'echo "SUBSYSTEM==\"usb\", ENV{UDISKS_AUTO}=\"0\"" >> /etc/udev/rules.d/85-no-automount.rules')
      sudo service udev restart

     
#. Verify the device is unmounted::

     mount

#. Use **fdisk** to remove partitions, create a fresh partition, set type to 7
   (NTFS/HPFS):: 

     sudo fdisk /dev/sdc
     u
     c
     n,p,<Enter>,<Enter>
     t,7
     w

#. Format the new partition NTFS, label it BACKUP::

     sudo mkntfs -L BACKUP -f /dev/sdc1

.. warning:: Creating a new drive partition changes the UUID for the drive 
   mount. When a drive has been automounted in the past, partitioning  must be 
   followed by the automount steps below before autofs can mount the drive.

Part 3: Identify the device
-----------------------------

.. note:: Once a drive is formatted, a bash script is provided to perform Parts 
   2 and 3 of this document. From the web browser on the server, download 
   :download:`this script <_downloads/backupdrive.sh>` and save it 
   in your home folder. Then execute the script with the commands::

      cd ~/Downloads
      bash backupdrive.sh BACKUP
      rm backupdrive.sh

The drive device will be discovered and then mounted to logical mount point 
``/home/mnt/backup``. [#]_

#. Plug in the hot-pluggable device on a **USB** port (eSATA is risky).
#. At the command prompt, type::

     sudo blkid

#. Output similar to the following will be displayed::

     /dev/sda1: UUID="27d7b97c-d615-4fff-9c55-ab714176ab29" TYPE="ext4"
     /dev/sda5: UUID="25630530-a7b8-442c-9c2d-57ea5eab109b" TYPE="swap"
     /dev/sda6: UUID="cf5aed21-730f-42bc-8a63-b068884772b5" TYPE="ext4"
     /dev/sdb1: UUID="27d7b97c-d615-4fff-9c55-ab714176ab29" TYPE="ext4"
     /dev/sdb5: UUID="25630530-a7b8-442c-9c2d-57ea5eab109b" TYPE="swap"
     /dev/sdb6: UUID="cf5aed21-730f-42bc-8a63-b068884772b5" TYPE="ext4"
     /dev/mapper/ddf1_aaltsys1: UUID="27d7b97c-d615-4fff-9c55-ab714176ab29" TYPE="ext4"
     /dev/mapper/ddf1_aaltsys5: UUID="25630530-a7b8-442c-9c2d-57ea5eab109b" TYPE="swap"
     /dev/mapper/ddf1_aaltsys6: UUID="cf5aed21-730f-42bc-8a63-b068884772b5" TYPE="ext4"
     /dev/sdc5: LABEL="HD-HSQ" UUID="363404743404397F" TYPE="ntfs"

This example shows block device ``/dev/sdc5``, UUID ``363404743404397F``, of 
``TYPE="ntfs"``.

.. warning:: In the following commands, replace **$UUID** with the identifier 
   **YOU OBTAINED** from the instructions in Part 3.

.. note:: 
   The output above shows `LABEL="HD-HSQ"`. If desired, change the volume label 
   with the command::
   
     sudo ntfslabel {block_device} {new_label}
   
   For example, the command :command:`sudo ntfslabel /dev/sdc5 BACKUP` would 
   change the label from `HD-HSQ` to `BACKUP` in the previous output.

At the command prompt, type::

   sudo service autofs stop
   sudo mkdir -p /home/mnt/backup/source_config
   sudo bash < <(echo 'echo "/-  /etc/auto.backup  --timeout=30 --ghost" >> /etc/auto.master')
   sudo bash < <(echo 'echo "/home/mnt/backup  -fstype=auto,sync  :/dev/disk/by-uuid/$UUID" >> /etc/auto.backup')
   sudo service autofs start

.. hint:: Did you remember to replace $UUID with your partition identifier?

Part 4: Verify drive mounting
-----------------------------

Type the commands::

   ls /home/mnt/backup
   touch /home/mnt/backup/@@external@@

.. Note:: This procedure created a file directory on the local drive as well as 
   the target directory on the external drive. When the external drive is 
   disconnected, turned off, or failed, the file ``@@external@@`` will not 
   display with the command ``ls /home/mnt/backup/@@*``.

Disconnect automounted drive
-----------------------------

Your device is mounted with a 30-second timeout. To avoid corruption, count 
to 60 before disconnecting the drive. When a drive will remain disconnected, 
autofs interferes with using the underlying file system of the system drive.
Reconfigure autofs to ignore the file system mount point as follows::

   sudo sed -i '$d' /etc/auto.master
   sudo service autofs restart

-----------------------------

.. rubric:: Footnotes

.. [#] https://help.ubuntu.com/community/Autofs

.. [#] http://unix.stackexchange.com/questions/85061/automount-not-disabling-in-ubuntu-12-04-or-13-04

.. [#] https://help.ubuntu.com/community/Mount/USB
 
