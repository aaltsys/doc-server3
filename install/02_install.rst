.. _install:

#############################
 Installation Instructions
#############################

.. note::
   The PC portion of these instructions wa written using Zentyal versions 
   from 2.0 through 3.3. Only the most current version of Zentyal is actually 
   supported, and so some of the directions may be out of order or wrong.
   Mac instructions were written based on Zentyal 3.4, current as of 4/1/2014.

Purpose and Requirements
=============================

This document is a quick guide to configuring hardware and installing a Zentyal 
office server which may then be registered for support with the AAltSys VPN.

Before starting this procedure, you should have the following information::

   {Domain}:              __________________________________
   {Hostname}:            __________________________________ (____server)
   {Username}:            __________________________________ (admin1)
   {Password}:            __________________________________
   {Registration number}: __________________________________
   {Activation code}:     __________________________________
   {Administrator email}: __________________________________

For servers used as LAN peers instead of network gateways, additional 
information is required::

   {Static IP address}:   __________________________________
   {Netmask}:             __________________________________
   {Gateway}:             __________________________________
   {DNS server1}:         __________________________________
   {DNS server2}:         __________________________________

Recommended Hardware
=============================

Minimum server hardware requirements start with a multicore processor capable 
of virtualization. Other requirements are as follows:

*  Dual Core x64 Processor with Virtualization *(either Intel VT-x or AMD-V)*
*  4 Gb RAM, *minimum*
*  80 Gb Hard Disk Drive, *minimum*
*  Gigabit Ethernet Adapter
*  DVD-ROM Drive, *required for installation*

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
such as boot device settings or boot order, as described previously in 
:ref:`bios_setup`.

Installing Zentyal
=============================

Boot the server from the Zentyal Install DVD.  

.. tip:: 
   A function key press such as :kbd:`[F8]` or :kbd:`[F12]`, or holding down 
   :kbd:`alt/option` on the Mac mini Server, may be required to select the boot 
   device.

Installer options
-----------------------------

*  Press :kbd:`<Enter>` at selection :menuselection:`English` to choose the 
   installer language default: ``English``.
*  **Choose the second option on the Installation menu**, 
   :guilabel:`Install Zentyal (expert mode)`.
*  Make the following selections, or press :kbd:`<Enter>` for defaults:
   
   +----------------------+-----------------+---------------------------------+
   | Selection name       | Default         | Suggested action                |
   +======================+=================+=================================+
   | Language             | English         | press :kbd:`<Enter>`            |
   +----------------------+-----------------+---------------------------------+
   | Country              | United States   | press :kbd:`<Enter>`            |
   +----------------------+-----------------+---------------------------------+
   | Detect keyboard      | No              | press :kbd:`<Enter>`            |
   +----------------------+-----------------+---------------------------------+
   | Country of keyboard  | English (US)    | press :kbd:`<Enter>`            |
   +----------------------+-----------------+---------------------------------+
   | Keyboard layout      | English (US)    || press :kbd:`<Enter>` or,       |
   |                      |                 || select ``English (Macintosh)`` |
   +----------------------+-----------------+---------------------------------+

Configure the Network
-----------------------------

*  Choose the Primary Network Interface, enter the fully-qualified host name, 
   and setup the site administrator user.
    
   .. warning:: Use your site domain and hostname in the following entry, not 
      ":kbd:`{hostname}`" and ":kbd:`{domain}`". **domain** and **hostname** 
      cannot be changed on fully configured systems.

   +-----------------------------+---------------------------------------------+
   | Selection prompt            | Recommended entry or action                 |
   +=============================+=============================================+
   | Primary Network Interface   || either :menuselection:`eth0: ...` (PC)     |
   |                             || or :menuselection:`something ...` (Mac)    |
   +-----------------------------+---------------------------------------------+
   | Hostname:                   || either :kbd:`{servername}.{domain}.local`  |
   |                             || or :kbd:`{servername}.local.aaltsys.net`   |
   +-----------------------------+---------------------------------------------+
   | Administrator username      | :kbd:`admin1` (if registering with AAltsys) |
   +-----------------------------+---------------------------------------------+
   | Password                    | :kbd:`{password}`                           |
   +-----------------------------+---------------------------------------------+
*  The network should configure using DHCP. If DHCP does not work, fix your 
   network connection.

Configure the Clock
-----------------------------
  
*  Verify that the displayed timezone, such as ``America/Chicago``, is correct
   for your physical location. Otherwise, enter :kbd:`No` to pick your timezone 
   from a list.

.. warning::
   Here, follow either **PC** or **Mac** instructions depending on hardware.

Partition disks (PC)
-----------------------------

*  Press :kbd:`<Enter>` to accept :guilabel:`<Yes>` at prompt 
   :guilabel:`Activate serial ATA RAID devices?`.
*  Press :kbd:`<Enter>` to use the :guilabel:`partitioning method`, 
   :guilabel:`Guided -- use entire disk`.

   .. warning:: Due to an installation bug in Zentyal 3.0, you must write down 
      the ATA RAID identifier, :guilabel:`isw_----------_aaltsys`, for later 
      reentry. 

*  Press :kbd:`<Enter>` to :guilabel:`select the disk to partition`, 
   :menuselection:`Serial ATA RAID, isw_xxxxxxxxxxx_aaltsys (mirror) ...`.
*  **Press** :kbd:`<Tab> <Enter>` **to select** :guilabel:`<Yes>` **at the 
   question,** :guilabel:`Write the changes to disks?`

Please wait as disk partitioning and initial file transfers take place 
(5-10 minutes).

Installation of downloadable components begins at this point (5-20 minutes). 

.. tip:: Zentyal 3.0: Actual drive mapper information is taken from the 
   previous warning. The following prompt for boot loader installation occurs 
   on initial installs to blank drives only, not on reinstalls to used drives.

*  Zentyal 3.0: **Enter** :kbd:`/dev/mapper/isw_----------_aaltsys <Tab><Enter>` 
   at :guilabel:`Device for boot loader installation:`. 
*  Press :kbd:`<Enter>` for :guilabel:`<Yes>` at the message, 
   :guilabel:`Is the system clock set to UTC?`
*  Remove the CD from the drive when the tray opens.
*  Press :kbd:`<Enter>` at :guilabel:`<Continue>`. The initial installation is 
   complete.

Partition disks (Mac)
-----------------------------

*  If asked to :guilabel:`unmount partitions that are in use`, answer :kbd:`No`.
*  Select :guilabel:`Partitioning method` as :kbd:`Manual`.
*  Partition drive :guilabel:`SCSI2 (0.0.0) (sdb)` for installation, leaving the 
   EFI partition and then adding a swap partition followed by an OS partition
   as shown following:
   
   +---------+--------------+---------------+-------------------+-----------+
   | Area    | Size         | Type          | Label             | Mount as  |
   +=========+==============+===============+===================+===========+
   |         |      3.1 MB  | FREE SPACE    |                   |           |
   +---------+--------------+---------------+-------------------+-----------+
   | #1      |    209.7 MB  | EFI boot      | EFI system p ...  |           |
   +---------+--------------+---------------+-------------------+-----------+
   |         |      1.0 MB  | FREE SPACE    |                   |           |
   +---------+--------------+---------------+-------------------+-----------+
   | #2      |     10.0 GB  | swap          |                   | swap      |
   +---------+--------------+---------------+-------------------+-----------+
   | #3      |    990.0 GB  | ext4          | ZENTYAL           | /         |
   +---------+--------------+---------------+-------------------+-----------+
   |         |    728.6 KB  | FREE SPACE    |                   |           |
   +---------+--------------+---------------+-------------------+-----------+
   
   .. note::
      The ``ZENTYAL`` partition does not have to be set :kbd:`bootable`, as 
      :program:`rEFInd` will act as boot manager.

*  Select :guilabel:`Finish partitioning and write changes to disk`. Then answer 
   the following questions:
   
   +-----------------------------------------------------+--------------------+
   | Question                                            | Answer             |
   +=====================================================+====================+
   | create a separate partition for boot loader code?   | <No>               |
   +-----------------------------------------------------+--------------------+
   | Write the changes to disks?                         | <Yes>              |
   +-----------------------------------------------------+--------------------+
   | Proceed installation without graphical environment? | <No>               |
   +-----------------------------------------------------+--------------------+
   | HTTP proxy information (blank for none):            | (blank) <Continue> |
   +-----------------------------------------------------+--------------------+
   | Device for boot loader installation:                | (blank) <Continue> |
   +-----------------------------------------------------+--------------------+
   | Is the system clock set to UTC?                     | <Yes>              |
   +-----------------------------------------------------+--------------------+

When the installation finishes, remove the install media and reboot the system.
