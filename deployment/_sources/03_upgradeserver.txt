.. _upgradeserver:

#############################
Upgrading a Zentyal Server 
#############################

Configuration databases and file permissions on older versions of Zentyal may 
not be compatible with newer Zentyal releases. Upgrade older servers using the 
following instructions.

Copy shares from old server
=============================

At a workstation, use the command line to create directories for each server 
share, and then copy the shared files into the new local directories. Open the 
command line by clicking :guilabel:`Start` and entering :kbd:`cmd.exe` in the
the search window, then selecting :program:`cmd.exe` from the search results.

Copy files from share :file:`\\\\AAltsysserver\\shared`, mapped to drive 
:file:`S:`, by typing the commands::

   md \shared
   cd \shared
   xcopy S:\*.* . /s/e

Use the preceding commands as a template for copying other server shares to a 
workstation. For example, copy a user's server private home directory, mapped to 
drive :file:`H:`, by replacing :file:`shared` with :file:`home` and :file:`S:` 
with :file:`H:` in the preceding commands.

Swap to new server
=============================

Shutdown and disconnect the old server, then connect the new server using the 
diagram shown previously. Then power on the new server, and access its 
administration at https://192.168.2.241 from a workstation web browser.

Enter office configuration 
=============================

Use the instructions at :ref:`installoffice` to configure file sharing, 
printers, and users and groups.

Copy shares to new server
=============================

For each share directory saved on a workstation, first map the share to its 
corresponding drive letter. In Windows 7, shares are mapped to drives by opening 
:guilabel:`Computer`, pressing :kbd:`[F10]` to display the menu, and selecting 
:menuselection:`Tools --> Map Network Drive`. 

.. note::
   Download script :download:`NETSHARE.BAT <../install/_downloads/netshare.bat>` to the 
   workstation desktop as an alternative to mapping drives. Then edit the batch
   script to reference the new server, and run the script to map drives. 

After mapping a share to a drive letter, open the command line, then use the 
following commands to copy the share files back to the server, remembering to 
replace :file:`S:` and :file:`shared` with the respective share drive letter and 
directory name for a share::

   cd \shared
   xcopy . S:\ /s/e
