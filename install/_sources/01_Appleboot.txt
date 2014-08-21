.. _appleboot:
 
###############################
Apple First Boot Instructions
###############################

Before installing Xentyal on your machine, there are several steps you should take in the apple OS first.


Installing Google Chrome
============================

You'll want to install Google Chrome for your server, as it will be useful later on.

This is a quick step by step instructional on how to install Google Chrome on a mac.

#. First you'll need to download the installer file at https://www.google.com/chrome?brand=CHMO#eula

#. Next, open the file called Google Chrome.dmg once it's finished downloading.
   
#. In the window that opens, drag the Chrome icon into the Application folder.
   
#. When you first open Chrome, the finder will ask if you want to open the Application downloaded from the internet. click open.
   
#. Unmount the Google Chrome disk image on your Desktop by right clicking it and choosing "Eject"

Install rEFInd and Linux
=============================

Install rEFInd software
-----------------------------

#. Download the binary zip of rEFInd software from 
   http://www.rodsbooks.com/refind/getting.html.
#. Open a terminal session, and change directory to the Downloads folder.
#. Unzip the rEFInd download:: 

      unzip refind <Tab> <Enter>

#. install the software::

      cd refind <Tab> <Enter>
      ./install.sh --alldrivers

Make free space on drive
-----------------------------

#. Open :menuselection:`Launchpad --> Other --> Disk Utility`
#. Choose a media drive to repartition, and select :menuselection:`Partition`
   from the dialog border menu. We recommend installing on /dev/disk02, aka
   "Recovery HD"
#. Remove Apple HFS data partitions on the drive, leaving only the EFI partition 
   and the remainder as free space. 

Install Linux from USB
-----------------------------

.. note::
   These instructions create a multi-boot machine based on the Mac mini Server.
   Please refer to separate Zentyal server installation instructions for a 
   detailed procedure specific to that operating system.

#. Restart the Mac, holding down the :kbd:`alt/option` key to choose the 
   boot device, either the USB drive or the Superdrive.
#. Choose the boot media, which Apple humorously refers to as "Windows".
#. Boot the Linux installation, select the installation language, and then 
   choose to install by :menuselection:`(expert mode)`.
#. Use manual partitioning option, and in the free space created previously, 
   first create an 8 Gb swap partition and then an install partition of type 
   ``ext4`` mounted as ``/``.
#. Continue with Linux installation in the newly-created partitions.
#. Reboot when installation is finished, removing the USB flash drive or media. 
   The :program:`rEFInd` boot selector should now contain options to boot Linux.

.. note::
   Either Linux will ask for a location to install the Grub boot loader, or a 
   boot loader installation error will be thrown at the end of the install. 
   Grub is not needed because we are using :program:`rEFInd` to manage booting.

Configure rEFInd
=============================

.. note::
   The Mac approach of displaying files in the Finder and then editing 
   configuration text in :program:`TextEdit` seems not to work here. But then,
   our intention is to use Linux in place of the Mac OS. This section uses a
   Linux-y approach to editing the :program:`rEFInd` configuration instead.

Diagnose rEFInd behavior
-----------------------------

#. Restart the server, and press :kbd:`right-arrow` in :program:`rEFInd` to stop
   boot.
#. Write down each main boot option to decide which should be displayed.
#. Determine configuration options to change. [#]_

Edit rEFInd configuration
-----------------------------

#. Start a terminal from :menuselection:`Launchpad --> Other --> Terminal`.
#. Edit the :program:`rEFInd` configuration file with the command::
   
      sudo nano /efi/refind/refind.conf
   
   and enter your password when prompted.
#. Modify the configuration options as desired, then press :kbd:`control-X` to
   save changes.
#. Exit all programs and restart the server to test the new configuration.

Repeat these instructions until desired results are achieved. 

.. tip:: 
   Save a copy of :file:`refind.conf` in your :file:`~/Documents`
   folder, as updates to Mac OS X will wipe out the EFI configuration.

Example configuration
-----------------------------

The goal for this installation was to provide a testing server running Ubuntu,
but also capable of being used as a Mac server or workstation when not testing. 
Therefore the server by default would boot Linux with minimal delay, while still 
providing a ``Mac OS X`` boot option. The configuration options used were::

   timeout 5
   use_graphics_for osx, linux
   dont_scan_volumes "Backup", "Recovery HD"
   dont_scan_dirs EFI/ubuntu
   dont_scan_files shim.efi, MokManager.efi
   scan_all_linux_kernels
   max_tags 2
   default_selection "vmlinuz"

Restoring rEFInd installation
=============================
 
The efi directory is cleared and rewritten when updating Mac OS X. Keep program
:program:`rEFInd` in your :file:`~/Downloads` folder, and keep a copy of 
:file:`refind.conf` in your :file:`~/Documents` folder. Restore a lost
:program:`rEFInd` installation in Mac OS X as follows:

#. Start a terminal from :menuselection:`Launchpad --> Other --> Terminal`
#. Reinstall :program:`rEFInd` with the commands::

      cd ~/Downloads/refind <Tab> <Enter>
      ./install.sh
      sudo cp ~/Documents/refind.conf /efi/refind/ 

----------

.. rubric: Footnotes

.. [#] `rEFInd configuration documentation <http://www.rodsbooks.com/refind/configfile.html>`_.