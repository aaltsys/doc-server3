.. _macserver:
 
###############################
Configuring a Mac Mini Server
###############################

AAltsys Server Introduction
===============================

Desktop and tower computers are bulky, inefficient, and expensive. These 
computers are undesirable for office servers, which is why we recommend the 
Apple Mac mini, which is powerful, unobtrusive, and reliable. 

We use Apple Mac mini hardware as a server running the Zentyal office server 
operating system. (Zentyal is based on the popular Linux OS Ubuntu.) An added 
SSD storage drive will be used for Zentyal server and data, and the original 
Apple OS-X installation will be retained on the internal drive. A boot selector 
program, rEFInd, will be used to permit operating system selection.

Mac mini Configuration
=============================

The components of the Mac mini, and the available accessories for it, change 
over time. Older Mac minis include the Mac mini Server, now discontinued, which 
offered two internal drives and a quad-core i7 hyper-threaded processor. Newer 
Mac minis have dual-core i5 processors with hyper threading, providing a 
maximum of four execution threads. This is adequate for an office server.

As of 10-15-2017, Apple's Mac mini configuration [#]_ used for this server is: 

*  2.6GHz Intel Dual-Core i5 (Turbo Boost up to 3.1GHz)
*  16GB 1600MHz LPDDR3 SDRAM
*  1TB Serial ATA Drive @ 5400 rpm

The following additional components convert the Mac mini to a server:

*  Samsung T5 256 GB SSD drive w/ USB 3.1 to 3.0 cable (for server storage),
*  Thunderbolt to Gigabit Ethernet adapter (for Internet gateway function),
*  Zentyal - windows-compatible office server operating system replaces OS-X,
*  rEFInd - multi-boot program for EFI and UEFI systems, particularly Macs,
*  Chrome - Google's browser is installed in OS-X as part of initial setup.

Additional generic hardware components will be used during system configuration 
or are required for site setup and administration:

*  Superdrive - or any USB-connected CD-ROM drive (during installation only),
*  USB Keyboard and mouse, HDMI-connected 1080p monitor (for administration),

Installing Google Chrome
=============================

Follow these step by step instructions to install Google Chrome on OS-X: 

#. Launch the Safari browser fror the Activity task bar
#. `Download the Chrome installer <https://www.google.com/chrome/browser>`_ 
#. Launch file :file:`Google Chrome.dmg` from the downloads
#. In the window that opens, drag the Chrome icon into the Application folder
#. When first opening Chrome, the Finder will ask if you want to open the 
   Application downloaded from the Internet. Click open.
#. Unmount the Google Chrome disk image on your Desktop by right clicking it and 
   choosing "Eject".

.. _refind:

Download and Install rEFInd 
=============================

Apple replaced BIOS booting with EFI (Extensible Firmware Interface), allowing 
software to control the computer boot process. Apple offers :program:`BootCamp` 
software to boot Windows on Macs, but this only works with Windows. 

**Roderick Smith** has written an excellent boot manager supporting multiple 
hardware platforms and various operating systems, particularly :program:`Linux` 
and Macintosh :program:`OS-X`. Further, he maintains a reference book on EFI 
booting using his `rEFInd program <http://www.rodsbooks.com/refind/>`_.

Install rEFInd software
-----------------------------

#. `Download rEFInd software <http://www.rodsbooks.com/refind/getting.html>`_
   to your :file:`Downloads` folder. [#]_

#. On later Macs with **SIP**, press :kbd:`alt/option` to reboot to the 
   :file:`Recovery HD` volume and then disable **SIP** with the command::

      csrutil disable

   Then reboot to the Mac OS-X system on volume :file:`Macintosh HD`. 
   (As an alternative, use Rod's guide to install :program:`rEFInd` from the 
   Recovery boot [#]_ in place of this step and the next step.)
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

#. After installing :program:`rEFInd`, copy or rename the default configuration
   file :file:`refind.conf` to preserve it. This file should be in one of the 
   following locations::
   /Volumes/ESP/efi/refind/
   /efi/refind/

#. To boot Zentyal by default, download the customized refind configuration 
   :download:`refind.conf <./_downloads/refind.conf>` to folder :file:`refind`. 

#. For Macs with SIP, reboot and press a cursor key to stop :program:`rEFInd`. 
   Use the mouse or cursor keys to select small icons items::
   *i* -- the info icon will say whether SIP is off or on
   *shield* -- toggles the SIP state off and on
   *circle-arrows* -- reboot the system after any changes

Reconfiguring rEFInd 
=============================

The :program:`rEFInd` configuration which defaults to booting Linux, as used in 
this guide, is shown below:

.. include:: ./downloads/refind.conf

Use the instructions in this section if you wish to change boot configuration 
options. 

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

Recovering from a Boot Coup
=============================
 
The :file:`efi` directory may get rewritten when updating either Mac OS-X or 
Linux. Keep program :program:`rEFInd` in your :file:`~/Downloads` folder, and 
keep a copy of :file:`refind.conf` in your :file:`~/Documents` folder. Restore 
a lost :program:`rEFInd` installation in Mac OS X as follows:

#. Start a terminal from :menuselection:`Launchpad --> Other --> Terminal`
#. Reinstall :program:`rEFInd` with the commands::

      cd ~/Downloads/refind <Tab> <Enter>
      ./install.refind
      sudo cp ~/Documents/refind.conf /efi/refind/ 
        -- or --
      sudo cp ~/Documents/refind.conf Volumes/ESP/efi/refind/ 
----------

.. rubric:: Footnotes

.. [#] `Mac mini specifications <https://www.apple.com/mac-mini/specs/>`_. 

.. [#] `How to obtain rEFInd <http://www.rodsbooks.com/refind/getting.html>`_. 

.. [#] `Install rEFInd <http://www.rodsbooks.com/refind/sip.html#recovery>`_.

.. [#] `Configuring rEFInd <http://www.rodsbooks.com/refind/configfile.html>`_. 
