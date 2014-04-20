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
   Intrusion Prevention System
   Layer 7 Filter
   NTP Service
   Network Configuration
   Printer Sharing Service
   RADIUS
   Traffic Shaping
   UPS Management
   Users and Computers
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

*  Check the :guilabel:`Configure interface types` radio buttons according to 
   your server type:
   
   +--------------------------------------+-+--------------------------------------+
   | NETWORK GATEWAY SERVER               | | LAN PEER SERVER                      |
   +======================================+=+======================================+
   | **Configure Interface Types:**       | | **Configure Interface types:**       |
   +--------------------------------------+-+--------------------------------------+
   | eth0 --> ``External``                | | eth0 --> ``Internal``                |
   +--------------------------------------+-+--------------------------------------+
   | eth1 --> ``Internal``                | |                                      |
   +--------------------------------------+-+--------------------------------------+

*  Click :guilabel:`Next`
*  Configure network internal and external interfaces as shown below:
   
   +--------------------------------------+-+--------------------------------------+
   | NETWORK GATEWAY SERVER               | | LAN PEER SERVER                      |
   +======================================+=+======================================+
   | **Configure network for external...**| |                                      |
   +--------------------------------------+-+--------------------------------------+
   | eth0 --> ``DHCP``                    | |                                      |
   +--------------------------------------+-+--------------------------------------+
   +--------------------------------------+-+--------------------------------------+
   | **Configure network for internal...**| | **Configure network for internal...**|
   +--------------------------------------+-+--------------------------------------+
   | eth0 --> ``Static``                  | | eth0 --> ``DHCP``                    |
   +--------------------------------------+-+--------------------------------------+
   | IP address --> ``192.1658.2.241``    | |                                      |
   +--------------------------------------+-+--------------------------------------+
   | Netmask --> ``255.255.255.0``        | |                                      |
   +--------------------------------------+-+--------------------------------------+
   
   .. note::
      Interfaces are configured according to the server function. For more 
      explanation of network setup, see :ref:`resources/network`. During 
      initial setup, use DHCP to configure a LAN peer server network interface.
   
*  Click :guilabel:`Next`
*  The :guilabel:`Host domain name` prompt displays the domain name from the 
   initial installation, such as :guilabel:`local.aaltsys.net`.
*  Click :guilabel:`NEXT`.
*  Register the server with Zentyal. An existing account ``admin1@aaltsys.com`` 
   with the default password exists for this purpose.
*  At :guilabel:`Initial configuration wizard`, click :guilabel:`FINISH`.

Saving Changes
------------------------------

Packages will be configured now (1-5 minutes).

When finished, click on :guilabel:`GO TO THE DASHBOARD`.

To exit Zentyal, choose :guilabel:`Logout` from the Zentyal top bar, then click 
:guilabel:`Exit`.

Connecting External Drive
=============================

An external drive should be connected for storing backups, such as the Passport
1.0 Tb portable drive with USB 3.0 interface. Follow instructions in article 
:ref:`resources/backupdrive` to partition, format, and configure this drive.

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
