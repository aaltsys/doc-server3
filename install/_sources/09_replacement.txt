.. _replacement:

#############################
Replacing a Failed Drive
#############################

Fixing a Broken System
=============================

Power outages in particular, and other types of system failure, can result in a 
broken system which cannot be booted, while the hardware is still good. 

Using an Install Boot Disk
-----------------------------

If an installation DVD of the same version as a system is available, then the 
disk may be used to attampt a system repair.

Adding a Replacement Drive
-----------------------------

A replacement SSD drive may be added connected to a USB 3.0, USB 3.1/C, or 
Thunderbolt port. A completely fresh OS install would be performed on the new 
drive, and the Refind boot manager would be added to allow boot selection. See 
:ref:`macserver` and :ref:`install` for details on these steps.

Recovering Partition Data
=============================

Once an OS is fully installed on a replacement drive, system recovery proceeds 
as follows:

*  Configure :program:`rEFInd` to boot from the replacement system drive, then 
   boot from the new system (see :ref:`refind`)

*  Mount the corrupted system partition. For example, to mount sdb3::

      sudo mkdir /mnt/sdb3
      sudo mount -t ext4 /dev/sdb3 /mnt/sdb3

*  Enumerate user folders and shares on the corrupted partition::

      ls -al /mnt/sdb3/home/samba/profiles
      ls -al /mnt/sdb3/home/samba/shares

*  Zentyal: 

   *  Configure file sharing, users, and other services in the new OS
   *  Enter users to the new OS for SAMBA profiles on the corrupted partition
   *  Setup file shares in the new OS for SAMBA shares on the corrupted drive

*  Remove ACLs (Access Control Lists) from profiles on corrupted partition::

      setfacl -bnR /mnt/sdb3/home/samba/profiles/*

*  Copy all user data from profiles to corresponding users in new system::

      cp -r /mnt/sdb3/home/samba/profiles/{user1}/* /home/samba/profiles/{user1}/
      ...

*  Remove ACLs (Access Control Lists) from shares on corrupted partition::

      setfacl -bnR /mnt/sdb3/home/samba/shares/*

*  Copy all SAMBA shares from corrupted partition to new system::

      cp -r /mnt/sdb3/home/samba/shares/{share1}/* /home/samba/shares/{share1}
      ...

*  Unmount the corrupted partition::

      umount /mnt/sdb3

*  Reboot system and test access to all shares.

Commands for Recovery
=============================

Identifying a Partition
-----------------------------

Boot from a new OS, probably on an SSD drive. Open a terminal window, then 
verify the drive volume to mount. The following commands may help identify the 
device to mount::

   df -h | grep "/sd"
   mount | grep "/sd"
   ls -al /dev/sd*

Reading and setting Mode
-----------------------------

The long-form file directory listing displays file mode permissions::

   ls -al {directory} 

A plus sign (+) displays to the right of the mode when ACLs apply to an entry.

The :command:`chmod` changes the permissions mode for a file or directory::

   chmod -Rf 744 ~/Downloads

The :command:`chown` changes the owner and group for a file or directory::

   chown admin:__users__ /home/samba/shares/shared

Reading ACLs
-----------------------------

To read or display ACLs on a file, use command::

   getfacl [-a | -d] {filename} {...}

where:

|  -a -- Displays the file name, owner, group, and ACL entries of a file or directory
|  -d -- Displays the file name, owner, group, and default ACL entries for a  file or directory.

Setting ACLs
-----------------------------

Display the :command:`setfacl` manpage for command explanation::

   setfacl [-bkndRLPvh] [{-m|-x} acl_spec] [{-M|-X} acl_file] file ...

The most common use for this command would be when copying or deleting ACLs, as 
described following.

Copying ACL from Another File
-----------------------------

Copy an ACL from one file to another by piping :command:`getfacl` output to
:command:`setfacl`::

   getfacl {filename1} | setfacl -f - {filename2}

where {filename1} has the source ACL and {filename2} specifies the destination.

Deleting ACLs from a File
-----------------------------

Delete ACL entries from a file or directory using :command:`setfacl`::

   setfacl -d acl-entry-list {filename} {...} 
