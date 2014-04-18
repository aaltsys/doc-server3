.. _firstboot:

#############################
First Boot Configuration
#############################

On first boot, the Zentyal desktop loads Firefox and opens the local server 
administration console. First, in Firefox 
:menuselection:`Edit --> Preferences --> Security`, uncheck item 
:guilabel:`Remember passwords for sites`. Then login to Zentyal for the first 
boot configuration::

   :guilabel:`Username:`  :kbd:`__username__`
   :guilabel:`Password:`  :kbd:`__password__`

.. NOTE:: Following section titles correspond to items on the Zentyal 
   :guilabel:`Initial Steps` menu, at the left of the Zentyal pages.

Package Selection:
-----------------------------

At :guilabel:`Choose Zentyal packages to install`, select the following modules::

   Backup
   Bandwidth Monitor
   Certification Authority
   DHCP Service
   DNS Service
   FTP
   Firewall
   IPsec
   Intrusion Detection System
   Layer 7 Filter
   NTP Service
   Network Configuration
   Printer Sharing Service
   RADIUS
   Traffic Shaping
   UPS Management (Zentyal 3.0)
   Users and Groups
   VPN Service

Click :guilabel:`Install`.

Confirmation:
-----------------------------

On the :Guilabel:`Confirmation` page, click :guilabel:`OK`.

Installation:
-----------------------------

Packages will be downloaded and installed now (10-30 minutes).

Initial Configuration:
=============================

.. warning:: At :guilabel:`Initial configuration wizard`, do not click 
   :guilabel:`SKIP` or :guilabel:`NEXT`.

Network Interfaces
-----------------------------

.. note:: There are two principal installation types for an AAltsys server: as 
   a network gateway server, or as a LAN peer server. Follow one of the columns 
   below, either the right-hand side or the left.

*  Check the :guilabel:`Configure interface types` radio buttons according to 
   your installation type.
*  Click :kbd:`NEXT` to continue.

+---------------------------------------+-+----------------------------------------+
| NETWORK GATEWAY SERVER                | | LAN PEER SERVER                        |
+=======================================+=+========================================+
| **Configure Interface Types:**        | | **Configure Interface types:**         |
+---------------------------------------+-+----------------------------------------+
| eth0 --> ``External``                 | | eth0 --> ``Internal``                  |
+---------------------------------------+-+----------------------------------------+
| eth1 --> ``Internal``                 | | eth1 --> ``Internal``                  |
+---------------------------------------+-+----------------------------------------+

*  Click :guilabel:`Next`.

+---------------------------------------+-+----------------------------------------+
| NETWORK GATEWAY SERVER                | | LAN PEER SERVER                        |
+=======================================+=+========================================+
| **Configure network for external ...**| | **Configure network for external ...** |
+---------------------------------------+-+----------------------------------------+
| eth0 --> ``DHCP``                     | | eth0 --> ``static``                    |
+---------------------------------------+-+----------------------------------------+
|                                       | | IP address --> ``__nnn.nnn.nnn.nnn__`` |
+---------------------------------------+-+----------------------------------------+
|                                       | | Netmask --> ``__255.nnn.nnn.0__``      |
+---------------------------------------+-+----------------------------------------+
|                                       | | Gateway --> ``__nnn.nnn.nnn.nnn__``    |
+---------------------------------------+-+----------------------------------------+
|                                       | | DNS server1 --> ``__8.8.8.8__``?       |
+---------------------------------------+-+----------------------------------------+
|                                       | | DNS server2 --> ``__8.8.4.4__``?       |
+---------------------------------------+-+----------------------------------------+
+---------------------------------------+-+----------------------------------------+
| eth1 --> ``Static``                   | | eth1 --> ``Don't Configure``           |
+---------------------------------------+-+----------------------------------------+
| IP address --> ``192.168.2.241``      | |                                        |
+---------------------------------------+-+----------------------------------------+
| Netmask --> ``255.255.255.0``         | |                                        |
+---------------------------------------+-+----------------------------------------+

*  Click :guilabel:`Next`.

.. Note:: Zentyal 2.2: 

   *  At :guilabel:`Select the type of the server`, choose 
      :guilabel:`Standalone Server`.
   *  Click :guilabel:`Finish`.
   *  Click :guilabel:`Save Changes`.

*  Zentyal 3.0: At :guilabel:`Host domain name`, accept the default name
   :guilabel:`__domain__.aaltsys.net`.
*  Click :guilabel:`NEXT`.
*  At :guilabel:`Initial configuration wizard`, click :guilabel:`FINISH`. (To 
   avoid registering, you may need to click :guilabel:`SKIP` and then 
   :guilabel:`FINISH`.)

Saving Changes
------------------------------

Packages will be configured now (1-5 minutes).

When finished, click on :guilabel:`GO TO THE DASHBOARD`.

To exit Zentyal, choose :guilabel:`Logout` from the Zentyal top bar, then click 
:guilabel:`Exit`.

Connecting External Drive
=============================

An external drive may be connected for storing backups. Provided you have a 
drive, formatted already with ntfs, then download this 
:download:`backup drive configuration script <_downloads/backupdrive.sh>` and 
then run it with the commands::

   cd ~/Downloads
   bash backupdrive.sh BACKUP
   rm backupdrive.sh

.. note::
   Instructions for preparing a backup drive, formatting it for NTFS, and the 
   sequence of commands to automount the drive as used in the above script are 
   provided in the article :ref:`backup_drive_setup`.

Installing AAltSys VPN
=============================

*  Download this :download:`registration script <_downloads/aas.sh>`

*  Double-click the :guilabel:`Console` icon from the server desktop.

*  Type the following commands in the exact case shown::

      cd ~/Downloads
      bash aas.sh
      rm aas.sh

*  Type in your :kbd:`__password__`.When prompted for it. 
  
*  Additional packages may be installed now (10-20 minutes).

*  Enter the following information when prompted::

      Registration number: ________________________________
      Activation code:     ________________________________
      email address:       ________________________________

An upgrade to all installed packages will be performed, taking 10-30 minutes. 
When all command activity finishes and installation is complete, the server 
should restart.

Restarting Server
=============================

From a console terminal window, restart your server with the command::

   sudo reboot <Enter>

Congratulations. Your AAltSys server is ready for local configuration. 
