.. _install:

#############################
 Installation Instructions
#############################

.. note::
   Only the most current version of Zentyal is supported. Some directions may be 
   out of order or wrong, haaving been written based on previous Zentyal 
   versions. Mac instructions were written based on Zentyal 3.4, current as of 
   4/1/2014.

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

Some of this information can be found at manage.aaltsys.net   
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

Our recommended hardware configuration is provided in :ref:`hardware`. 

Hardware Configuration
=============================

Connect the computer components and network cables as described in the hardware 
documentation, or as required for the specific hardware you are using. 

If your server is intended as a gateway computer, connect the primary Ethernet 
port ``eth0`` to your Internet gateway or WAN, and the secondary port ``eth1`` 
to your local LAN. If your server will operate only as a file server on a 
local LAN, connect ``eth0`` to your LAN and leave other network ports 
unconnected.

Installing Zentyal
=============================

Power on the computer, and boot from the Zentyal Install DVD. 

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
    
   .. warning:: Use your site hostname and domain in the following entry, not 
      ":kbd:`{hostname}`" and ":kbd:`{domain}`". **hostname** and **domain** 
      cannot be changed on fully configured systems.

   +-----------------------------+---------------------------------------------+
   | Selection prompt            | Recommended entry or action                 |
   +=============================+=============================================+
   | Primary Network Interface   | :menuselection:`eth0: ...` (PC)             |
   +-----------------------------+---------------------------------------------+
   | Hostname:                   || either :kbd:`{hostname}.local`             |
   |                             || or :kbd:`{hostname}.local.{domain}`        |
   |                             || or :kbd:`{hostname}.local.aaltsys.net`     |
   |                             || or :kbd: `aaltsysserver` for local'        |
   +-----------------------------+---------------------------------------------+
   | Administrator username      | :kbd:`admin1` (if registering with AAltsys) |
   +-----------------------------+---------------------------------------------+
   | Password                    | :kbd:`{password}`                           |
   +-----------------------------+---------------------------------------------+
   | Use weak password?          | Yes                                         |
   +-----------------------------+---------------------------------------------+
*  The network should configure using DHCP. If DHCP does not work, fix your 
   network connection.

Configure the Clock
-----------------------------
  
*  Verify that the displayed timezone, such as ``America/Chicago``, is correct
   for your physical location. Otherwise, enter :kbd:`No` to pick your timezone 
   from a list.

Partition disks (BIOS RAID)
-----------------------------

.. warning::
   For **Mac**, skip this section and continue at :ref:`partition-mac`. These 
   instructions apply to custom-built PCs with BIOS RAID on the motherboard.

*  Answer the following questions:

   +--------------------------------------+------------------------------------+
   | Installation prompt                  | Response                           |
   +======================================+====================================+
   | Activate serial ATA RAID devices?    | <Yes>                              |
   +--------------------------------------+------------------------------------+
   | Partitioning method                  | Guided -- use entire disk          |
   +--------------------------------------+------------------------------------+
   | select the disk to partition         | Serial ATA RAID, isw-------aaltsys |
   +--------------------------------------+------------------------------------+
   | ... partition for boot loader code?  | <Yes>                              |
   +--------------------------------------+------------------------------------+
   | Write the changes to disks?          | <Yes>                              |
   +--------------------------------------+------------------------------------+
   
   .. warning:: 
      When installing Zentyal 3.0, a bug makes it necessary to write down the
      ATA RAID identifier, :guilabel:`isw_----------_aaltsys`, for later use. 

.. _partition-mac: 

Partition disks (Mac)
-----------------------------

*  If asked to :guilabel:`unmount partitions that are in use`, answer :kbd:`No`.
*  Select :guilabel:`Partitioning method` as :kbd:`Manual`.
*  Partition drive :guilabel:`SCSI2 (0.0.0) (sdb)` for installation, creating 
   partitions for EFI boot, swap, and ext4 ZENTYAL as shown following:
   
   +---------+------------+-------+---------------+-------------------+-------+
   | Area    | Size       | Flags | Type          | Label             | Mount |
   +=========+============+=======+===============+===================+=======+
   |         |    1.0 MB  |       | FREE SPACE    |                   |       |
   +---------+------------+-------+---------------+-------------------+-------+
   | #1      |  209.7 MB  | B  F  | EFIboot       | EFI system p ...  |       |
   +---------+------------+-------+---------------+-------------------+-------+
   | #2      |   16.0 GB  |    F  | swap          |                   | swap  |
   +---------+------------+-------+---------------+-------------------+-------+
   | #3      |  983.3 GB  |    F  | ext4          | ZENTYAL           | /     |
   +---------+------------+-------+---------------+-------------------+-------+
   |         |  728.6 KB  |       | FREE SPACE    |                   |       |
   +---------+------------+-------+---------------+-------------------+-------+
   
   .. note::
      The ``ZENTYAL`` partition does not have to be set :kbd:`bootable`, as 
      :program:`rEFInd` will act as boot manager. An empty EFIboot partition is
      maintained for possibly restoring the drive to OS X.

*  Select :guilabel:`Finish partitioning and write changes to disk`. 

   .. note::
      Zentyal wants to use Grub in place of Apple's EFI boot partition, and so a
      question appears regarding a "separate partition for boot loader code". 

*  At the prompt :guilabel:`Go back to the menu and correct this problem?`, 
   enter :kbd:`<No>`.
   
* If you see a prompt :guilabel: `do you want to return to the partitioner` select 
  :kbd: `<No>`
   
* At the prompt :guilabel: `Write changes to the disks?`,
  Enter :kbd: `<Yes>`.

Finish Installation
=============================

Answer these questions, each of which involves installation activity:

.. warning::
   For Zentyal 3.0, question :guilabel:`Device for boot loader installation:`
   must be answered with :kbd:`/dev/mapper/isw_----------_aaltsys <Tab><Enter>`.

+-----------------------------------------------------+--------------------+
| Question                                            | Answer             |
+=====================================================+====================+
+-----------------------------------------------------+--------------------+
| Proceed installation without graphical environment? | <No>               |
+-----------------------------------------------------+--------------------+
| HTTP proxy information (blank for none):            | (blank) <Continue> |
+-----------------------------------------------------+--------------------+
| Device for boot loader installation:                | (blank) <Continue> |
+-----------------------------------------------------+--------------------+
| Is the system clock set to UTC?                     | <Yes>              |
+-----------------------------------------------------+--------------------+

When the installation finishes, remove the install media and press 
:kbd:`<enter>` to reboot the system.
