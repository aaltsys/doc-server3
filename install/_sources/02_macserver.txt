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

Installing Linux
=============================

.. tip:: 
   Throughout this section, replace the token ``{linux.iso}`` with the
   actual download filename of the Linux being installed.

Free up Space on Spare Drive
-----------------------------

#. Open :menuselection:`Launchpad --> Other --> Disk Utility`
#. Choose a media drive to repartition, and select :menuselection:`Partition`
   from the dialog border menu. We recommend installing on /dev/disk02, aka
   "Recovery HD"
#. Remove Apple HFS data partitions on the drive, leaving only the EFI partition 
   and the remainder as free space. 

Make a Linux installer DVD
-----------------------------

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

Install Linux from USB or DVD
-----------------------------

.. note::
   These instructions create a multi-boot machine based on the Mac mini Server.
   Please refer to separate :ref:`install` instructions for a detailed procedure 
   specific to the Linux/Zentyal operating system.

#. Restart the Mac, holding down the :kbd:`alt/option` key to choose the 
   boot device, either the USB drive or the Superdrive.
#. Choose the boot media, which Apple humorously refers to as "Windows".
#. Boot the Linux installation drive, and install by menu selection or Grub 
   option :menuselection:`(expert mode)`.
#. Use manual partitioning option, and in the free space created previously, 
   first create a 16 Gb swap partition and then an install partition of type 
   ``ext4`` mounted as ``/`` in the remaining space.
#. Continue with Linux installation in the newly-created partitions.
#. When installation is finished, remove the USB flash drive or media and 
   reboot, holding down :kbd:`alt/option` to choose a boot device.

.. note::
   Linux will probably install the :program:`Grub` boot loader and perform a 
   `Boot Coup <http://www.rodsbooks.com/refind/bootcoup.html>`_, taking over 
   boot management from :program:`OS-X`. Next we will bypass both the Mac boot 
   and Linux :program:`Grub` by installing multi-OS loader :program:`REFInd`.

----------

Download and Install rEFInd 
=============================

**Roderick Smith** has written an excellent boot manager supporting multiple 
hardware platforms and various operating systems, particularly :program:`Linux` 
and Macintosh :program:`OS-X`. Further, he maintains an extensive on-line 
`book <http://www.rodsbooks.com/refind/>`_ on the subject of boot loaders. 
These brief instructions are based on Rod's book, which is the actual 
authoritative documentation of this subject.

Install rEFInd software
-----------------------------

#. From `Rod's Books website <http://www.rodsbooks.com/refind/getting.html>`_,
   download the latest version of :program:`REFInd` to your :file:`Downloads` 
   folder.
#. On later Macs with **SIP** [#]_, press :kbd:`alt/option` to reboot to the 
   :file:`Recovery HD` volume and then disable **SIP** with the command::

      csrutil disable

   Then reboot to the Mac OS-X system on volume :file:`Macintosh HD`.
#. Open a terminal session, change directory to the :file:`Downloads` folder,
   and unzip and install :program:`Refind` with the commands::

      cd ~/Downloads
      unzip refind <Tab> <Enter>
      cd refind <Tab> <Enter>
      ./refind.install

#. Read the installation messages to see where :program:`REFInd` is installed. 
   For message ``Installing rEFInd to the partition mounted at /Volumes/ESP``,
   bless :program:`REFInd` with the command::

      sudo bless --mount /Volumes/ESP --setBoot --file /Volumes/ESP/efi/refind/refind_x64.efi --shortform

   Otherwise for :program:`REFInd` installed in folder :file:`\EFI`, use::

      sudo bless --setBoot --folder /efi/refind --file /efi/refind/refind_x64.efi

Configure rEFInd
-----------------------------

#. After installing :program:`rEFInd`, copy or rename the default 
   :file:`refind.conf` configuration file to preserve it. 
#. Restart the server, and press :kbd:`right-arrow` in :program:`rEFInd` to 
   stop booting.
#. Write down each main boot option to decide which should be displayed.
#. Determine any other configuration options to change. [#]_

Edit rEFInd configuration
-----------------------------

#. Start a terminal from :menuselection:`Launchpad --> Other --> Terminal`.
#. Edit the :program:`rEFInd` configuration file with the command::

      sudo nano /Volumes/ESP/efi/refind/refind.conf

   or for older Macs with an :file:`EFI` folder and no :file:`ESP` volume, ::

      sudo nano /efi/refind/refind.conf

   and enter your password when prompted.

   .. note::
      The Mac approach of displaying files in the Finder and then editing 
      configuration text in :program:`TextEdit` will not to work with boot 
      manager files. This section uses a Linux-y approach to editing the :program:`rEFInd` configuration instead.

#. Modify the configuration options as desired, then press :kbd:`control-X` to
   save changes.
#. Exit all programs and restart the server to test the new configuration.

Repeat these instructions until desired results are achieved. 

.. tip:: 
   Save a copy of the modified :file:`refind.conf` in your :file:`~/Documents`
   folder, as updates to Mac OS X might wipe out the EFI configuration.

After achieving a good :program:`rEFInd` configuration, turn SIP back on with 
either:

*  Rebooting from a :program:`rEFInd` CD and selecting :command:`SIP Policy` 
   from the tools, 
*  Rebooting from the Apple Recovery partition and executing the command
   :command:`csrutil enable`, 
*  Rebooting and selecting :command:`SIP Policy` from the :program:`rEFInd` 
   tools, provided you have enabled tool :program:`csr_rotate`. 

Example Refind Configuration
-----------------------------

A sample :program:`rEFInd` configuration file for a dual-boot Linux/Macintosh system which defaults to booting Linux is shown below:

.. include:: ./downloads/refind.conf

Download :download:`refind.conf <./_downloads/refind.conf>` to directory 
:file:`refind`, overwriting the default configuration, to install this set of 
options.

Recovering from a Boot Coup
=============================
 
The :file:`efi` directory is cleared and rewritten when updating Mac OS-X. Keep 
program :program:`rEFInd` in your :file:`~/Downloads` folder, and keep a copy 
of :file:`refind.conf` in your :file:`~/Documents` folder. Restore a lost
:program:`rEFInd` installation in Mac OS X as follows:

#. Start a terminal from :menuselection:`Launchpad --> Other --> Terminal`
#. Reinstall :program:`rEFInd` with the commands::

      cd ~/Downloads/refind <Tab> <Enter>
      ./install.refind
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
      and choose :menuselection:`Convert ``{linux_.iso}```. 
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

.. [#] http://www.apple.com/mac-mini/server/ 

.. [#] http://www.rodsbooks.com/refind/getting.html

.. [#] http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx

.. [#] https://help.ubuntu.com/community/MactelSupportTeam/AppleIntelInstallation

.. [#] http://www.rodsbooks.com/refind/sip.html

.. [#] http://www.rodsbooks.com/refind/configfile.html 

