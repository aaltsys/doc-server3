.. _install:

#############################
 Installation Instructions
#############################

Purpose and Requirements
=============================

This document is a quick guide to configuring hardware and installing a Zentyal 
office server which may then be registered for support with the AAltSys VPN.

Before starting this procedure, you should have the following information::

	 __Hostname__:            __________________________________ (_____server)
	 __Username__:            __________________________________ (admin1)
	 __Password__:            __________________________________
	 __Registration number__: __________________________________
	 __Activation code__:     __________________________________
	 __Administrator email__: __________________________________

For servers used as LAN peers instead of network gateways, additional 
information is required::

	 __Static IP address__:   __________________________________
	 __Netmask__:             __________________________________
	 __Gateway__:             __________________________________
	 __DNS server1__:         __________________________________
	 __DNS server2__:         __________________________________

Recommended Hardware
=============================

Minimum server hardware requirements start with a multicore processor capable 
of virtualization. Other requirements are as follows:

+ Dual Core x64 Processor with Virtualization *(either Intel VT-x or AMD-V)*
+ 2 Gb RAM, *minimum*
+ 80 Gb Hard Disk Drive, *minimum*
+ Gigabit Ethernet Adapter
+ DVD-ROM Drive, *required for installation*

Our recommended hardware configuration is provided in :doc:`01_hardware`. 

Hardware Configuration
=============================

Connect the computer components and network cables as described in the hardware 
documentation, or as required for the specific hardware you are using. 

If your server is intended as a gateway computer, connect the primary Ethernet 
port ``eth0`` to your Internet gateway or WAN, and the secondary port ``eth1`` 
to your local LAN. If your server will operate only as a file server on a 
local LAN, connect ``eth0`` to your LAN and leave other network ports 
unconnected.

Power on the computer, and enter the BIOS. Make any necessary setup changes, 
such as boot device settings or boot order. Be sure of the following:

+ That ``SATA RAID`` is enabled, using the ``Intel`` codebase.
+ That ``Intel Virtualization Techmology`` is ``Enabled``.
+ That Booting is enabled from your DVD (CDROM) drive.
 
Save any BIOS changes and reboot.

If you are using mirrored drives, press :kbd:`<Tab>` during boot for the POST 
display, followed by :kbd:`<Ctrl-I>` to enter the 
:guilabel:`Intel Matrix Storage Manager`. If a RAID array is present, delete it 
and recreate an array named :kbd:`aaltsys` of type ``RAID1``.
         
Installing Zentyal
=============================

Boot the server from the Zentyal Install DVD.  

.. tip::
	 *A function key press such as* :kbd:`[F8]` *or* :kbd:`[F12]` *may be 
	 required to select the boot device.*

+ Press :kbd:`<Enter>` at selection :menuselection:`English` to choose the installer 
  language default: ``English``.
+ **Choose the second option on the Installation menu**, 
  ``Install Zentyal (expert mode)``.
+ Press :kbd:`<Enter>` to select :menuselection:`English` as the system
  language, ``English``.
+ Press :kbd:`<Enter>` to select :menuselection:`United States` or choose 
  another :guilabel:`Country, territory or area:`. 
+ Press :kbd:`<Enter>` for the default ``<No>`` at the question, 
  :guilabel:`Detect keyboard layout?`
  
.. note:: Zentyal 2.2 keyboard instructions:

  + Press :kbd:`<Enter>` to use the default ``US keymap``, or select your local 
    keymap.
  + Press :kbd:`<Enter>` to accept a generic keyboard, or choose your exact 
    keyboard from the subsequent list.
  
+ Press :kbd:`<Enter>` to use the :menuselection:`English US` country of origin 
  for the keyboard, or select your country of origin.
+ Press :kbd:`<Enter>` to use the default :menuselection:`English US` keyboard 
  layout, or select your local keyboard.

+ Press :kbd:`<Enter>` to select :menuselection:`eth0: ...` as your 
  :guilabel:`Primary Network Interface`.
+ The network should configure using DHCP. If DHCP does not work, fix your 
  network connection.
  
.. warning:: Use your site hostname in the following entry, not 
  ":kbd:`__hostname__`". Once the system is configured, the hostname cannot be
  changed.
  
+ **Enter** :kbd:`__hostname__.local.aaltsys.net` **as the fully qualified** 
  :guilabel:`Hostname:`, then press :kbd:`<Tab>,<Enter>` to :guilabel:`<Continue>`.

+ Zentyal 3.0: At :guilabel:`Username for your accout`, enter an administrator
  name such as :kbd:`admin1`, then press :kbd:`<Tab>,<Enter>` to :guilabel:`<Continue>`.
+ Zentyal 3.0: Enter an administrator password, followed by then press :kbd:`<Tab>,<Enter>`.
+ Zentyal 3.0: Reenter the password, followed by then press :kbd:`<Tab>,<Enter>`.
+ Zentyal 3.0: If necessary, press :kbd:`<Tab>` to accept the weak password.

.. Note:: In the next step, if the default timezone is blank then pick your 
  timezone location from the list.

+ Press :kbd:`<Enter>` for the default timezone at the prompt 
  :guilabel:`Is this timezone correct?`.
+ Press :kbd:`<Enter>` to accept ``<Yes>`` at prompt 
  :guilabel:`Activate serial ATA RAID devices?`.
+ Press :kbd:`<Enter>` to use the :guilabel:`partitioning method`, 
  :guilabel:`Guided -- use entire disk`.

.. warning:: Due to an installation bug in Zentyal 3.0, you must write down the 
  ATA RAID identifier, :kbd:`isw_----------_aaltsys`, for later reentry.

+ Press :kbd:`<Enter>` to :guilabel:`select the disk to partition`, 
  :menuselection:`Serial ATA RAID, isw_xxxxxxxxxxx_aaltsys (mirror) ...`.
+ **Press** :kbd:`<Tab> <Enter>` **to select** ``<Yes>`` **at the question,**
  :guilabel:`Write the changes to disks?`

Please wait as disk partitioning and initial file transfers take place (5-10 minutes).

.. Note:: Zentyal 2.2 administrator username and password instructions.

  + **Enter** :kbd:`AAltsys Administrator <Enter>` **for the prompt,** 
    :guilabel:`Full name for the new user`.
  + **Enter** :kbd:`__username__ <Enter>` **at the prompt,** 
    :guilabel:`Username for your account`.
  + **Enter** :kbd:`__password__ <Enter>` **at the prompt,** 
    :guilabel:`Choose a password for the new user`.
  + **Enter** :kbd:`__password__ <Enter>` **at the prompt,** 
    :guilabel:`Re-enter password to verify`.
  + **Press** :kbd:`<Tab> <Tab> <Enter>` **to answer** ``<Yes>`` at the prompt 
    :guilabel:`Use weak password?`

+ Press :kbd:`<Tab><Enter>` to continue at the entry 
  :guilabel:`HTTP proxy information (blank for none)`.

Installation of downloadable components begins at this point (5-20 minutes).

.. Note:: Actual drive mapper information is taken from the previous warning. 
  The following prompt for boot loader installation occurs on initial installs
  to blank drives only, not on reinstalls to used drives.

+ Zentyal 3.0: At :guilabel:`Device for boot loader installation:`, **Enter**
  :kbd:`/dev/mapper/isw_----------_aaltsys <Tab><Enter>`
+ Press :kbd:`<Enter>` for ``<Yes>`` at the message, 
  :guilabel:`Is the system clock set to UTC?`
+ Remove the CD from the drive when the tray opens.
+ Press :kbd:`<Enter>` at :guilabel:`<Continue>`. The initial installation is complete.

First Boot Configuration
=============================

On first boot, the Zentyal desktop loads Firefox and opens the local server 
administration console. First, in Firefox 
:menuselection:`Edit --> Preferences --> Security`, uncheck item 
:guilabel:`Remember passwords for sites`. Then login to Zentyal for the first 
boot configuration:

  :guilabel:`Username:`  :kbd:`__username__`
  :guilabel:`Password:`  :kbd:`__password__`

.. NOTE:: Following section titles correspond to items on the Zentyal 
  :guilabel:`Initial Steps` menu, at the left of the Zentyal pages.

Package Selection:
"""""""""""""""""""""""""""""

At :guilabel:`Choose Zentyal packages to install`, select the following modules::

	 Backup
	 Bandwidth Monitor
	 Certification Authority
	 DHCP Service
	 DNS Service
	 FTP
	 File Sharing Service
	 Firewall
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

Click ``Install``.

Confirmation:
"""""""""""""""""""""""""""""

On the :Guilabel:`Confirmation` page, click ``OK``.

Installation:
"""""""""""""""""""""""""""""

Packages will be downloaded and installed now (10-30 minutes).

Initial Configuration:
"""""""""""""""""""""""""""""

.. warning:: At :guilabel:`Initial configuration wizard`, do not click 
  :kbd:`SKIP` or :kbd:`NEXT`.

Network Interfaces
-----------------------------

.. note:: There are two principal installation types for an AAltsys server: as 
  a network gateway server, or as a LAN peer server. Follow one of the columns 
  below, either the right-hand side or the left.

+ Check the :guilabel:`Configure interface types` radio buttons according to 
  your installation type.
+ Click :kbd:`NEXT` to continue.

+---------------------------------------+-+----------------------------------------+
| NETWORK GATEWAY SERVER                | | LAN PEER SERVER                        |
+=======================================+=+========================================+
| **Configure Interface Types:**        | | **Configure Interface types:**         |
+---------------------------------------+-+----------------------------------------+
| eth0 --> ``External``                 | | eth0 --> ``Internal``                  |
+---------------------------------------+-+----------------------------------------+
| eth1 --> ``Internal``                 | | eth1 --> ``Internal``                  |
+---------------------------------------+-+----------------------------------------+

+ Click ``Next``.

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

+ Click ``Next``.

.. Note:: Zentyal 2.2: 

  + At :guilabel:`Select the type of the server`, choose ``Standalone Server``.
  + Click ``Finish``.
  + Click ``Save Changes``.

+ Zentyal 3.0: At :guilabel:`Host domain name`, accept the default name
  :kbd:`local.aaltsys.net`.
+ Click ``NEXT``.
+ At :guilabel:`Initial configuration wizard`, click :kbd:`FINISH`. (To avoid 
  registering, you may need to click :kbd:`SKIP` and then :kbd:`FINISH`.)

Saving Changes
"""""""""""""""""""""""""""""

Packages will be configured now (1-5 minutes).

When finished, click on ``GO TO THE DASHBOARD``.

To exit Zentyal, choose :guilabel:`Logout` from the Zentyal top bar, then click ``Exit``.

Connect External Drive
=============================

You may choose to install an external backup drive at this point. While this is 
relatively simple and quick, an entire article is devoted to this topic:
:ref:`backup_drive_setup`.

Installing AAltSys VPN
=============================

Note:: AAltSys VPN installation is performed using sudo privileges.

Double-click the icon :guilabel:`Administrator Console` from the server desktop.
When prompted for :guilabel:`Your Password`, type in your :kbd:`__password__`.

At the command prompt, typing the exact case shown, enter the following command::

	 wget http://git.io/aas -O aas.sh; bash aas.sh; rm aas.sh

Additional packages will be installed now (10-20 minutes).

Enter the following information when prompted::

	 Registration number: ________________________________
	 Activation code:     ________________________________
	 email address:       ________________________________

An upgrade to all installed packages will now be performed (10-30 minutes).

When all command activity finishes, installation is complete.
Restart your server with the command::

	 reboot <Enter>

Congratulations. Your AAltSys server is ready for local configuration.