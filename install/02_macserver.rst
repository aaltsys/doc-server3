.. _bootableusb:

#############################
Make a Mac-Bootable USB
#############################

An alternative to using Apple's Superdrive would be a bootable USB drive, as 
created with the following directions for Apple's OS-X.

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

Install Zentyal from USB
=============================

These instructions supplement :ref:`install` to clarify using a USB drive 
instead of a DVD for Zentyal installation.

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
   first create a 16 Gb swap partition and then an install partition of type 
   ``ext4`` mounted as ``/``.
#. Continue with Linux installation in the newly-created partitions.
#. Reboot when installation is finished, removing the USB flash drive or media. 
   The :program:`rEFInd` boot selector should now contain options to boot Linux.

.. note::
   Either Linux will ask for a location to install the Grub boot loader, or a 
   boot loader installation error will be thrown at the end of the install. 
   Grub is not needed if we are using :program:`rEFInd` to manage booting.


