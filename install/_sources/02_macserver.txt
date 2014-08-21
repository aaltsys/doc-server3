.. _macserver:

#############################
Dual-Booting Mac Servers
#############################

The Mac mini Server is a modern alternative to the large desktop tower server. 
With the addition of a thunderbolt to ethernet port, needed for gateway 
operation, and a USB connected optical drive, this computer provides every 
server hardware feature required for Zentyal. [#]_

Requirements
=============================

Hardware
-----------------------------

*  Mac mini Server with OS X Server [#]_
*  8 Gb 1600MHz DDR3 memory SODIMM netbook (single stick)
*  Thunderbolt to Gigabit Ethernet Adapter
*  Apple USB SuperDrive CD / DVD /DVD-RW (used for OS installation only)

Software
-----------------------------

*  rEFInd boot manager for Mac [#]_ 
*  Current Mac OS X
*  Linux with EFI stub loader support (e.g., Ubuntu 12.10 and later)

.. note::
   Earlier Linux kernels, before 3.3.0, can be installed as documented in this
   footnote. [#]_

Make a Linux installer DVD
=============================

.. tip:: 
   Throughout this section, replace the token ``{linux.iso}`` with the
   actual download filename of the Linux being installed.

Download a Linux install ``{linux.iso}`` disk image, then burn the image to a 
DVD using the Apple Superdrive.

#. Open :program:`Disk Utility` from :menuselection:`Launchpad --> Other`.
#. Click the {linux.iso} file in the left panel, then click :guilabel:`Burn` 
   from the icon bar.
#. Insert a DVD in the Superdrive and click :guilabel:`Burn` to continue.

.. note::
   #. As an alternative to the Apple Superdrive, :ref:`bootableusb` describes 
      writing a device image file to a bootable USB thumb drive.
   
   #. This section is based on official Ubuntu documentation [#]_

----------

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
=============================

.. note::
   These instructions create a multi-boot machine based on the Mac mini Server.
   Please refer to separate :ref:`install` instructions for a detailed procedure 
   specific to that operating system.

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
   Linux will ask for a location to install the Grub boot loader, or a boot 
   loader installation error will be thrown at the end of the install. 
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

.. _bootableusb:

#############################
Make a Mac-Bootable USB
#############################

An alternative to using Apple's Superdrive would be a bootable USB drive, as 
created with the following directions.

Prepare bootable USB image
=============================

#. Select :menuselection:`Launchpad --> Other --> Terminal` to open a terminal.
#. Convert the downloaded ``{linux.iso}`` to a mac disk image with the 
   command::
   
      hdiutil convert -format UDRW -o ~/Documents/{linux} ~/Downloads/{linux.iso}

.. note::
   For the terminal phobic, the following instructions could replace the
   preceding command:
 
   #. Open a :program:`Finder` window, and display the :file:`Downloads` folder.
   #. Right-Click the ``{linux.iso}`` image file, and choose 
      :menuselection:`Open With --> Disk Utility`.
   #. In :program:`Disk Utility`, Right-Click the ``{linux.iso}`` file 
      and choose :menuselection:`Convert ``{linux_.iso}`` `.
   #. In the :guilabel:`Convert` dialog, use the default name and location 
      :file:`Documents`, and click :guilabel:`Save` to write.
      ``{linux.dmg}`` (The :file:`.dmg` extension is added automatically.)

Copy Linux image to USB
=============================

.. tip::
   Throughout these instructions, replace the expression :file:`/dev/diskN` 
   with the actual identifier of the USB device, e.g., :file:`/dev/disk2`.

#. Insert the USB flash media
#. To get the current list of disk devices, open a terminal with 
   :menuselection:`Launchpad --> Other --> Terminal`, and run the command::
   
      diskutil list

#. Find the device node assigned to the USB media (e.g. :file:`/dev/diskN`), 
   which should be last listed device
#. Unmount the USB drive (where ``N`` is the disk number) with the command::
   
      diskutil unmountDisk /dev/diskN
   
#. Copy the disk image to the USB device (again ``N`` is the disk number)::

      sudo dd if=~/Documents/{linux.dmg} of=/dev/diskN bs=1m 
   
   .. note:: 
      #. The error "dd: Invalid number '1m'" will appear on Linux. The correct 
         entries are ``bs=1M`` on Linux and ``bs=1m`` on OS X.
      #. The error "dd: /dev/diskN: Resource busy" will appear if the USB drive
         was not unmounted in step 3.

#. Eject the USB device before removing it with the command::

      diskutil eject /dev/diskN
 
---------

.. rubric:: Footnotes

.. [#] See http://www.macminiserver.com/ for more information on the Mac mini 
   Server.

.. [#] https://help.ubuntu.com/community/MactelSupportTeam/AppleIntelInstallation

.. [#] http://www.apple.com/mac-mini/server/ 

.. [#] http://www.rodsbooks.com/refind/getting.html

.. [#] http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx

.. [#] Refer to http://www.rodsbooks.com/refind/configfile.html for guidance
