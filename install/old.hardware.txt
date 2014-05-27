.. _hardware:

#############################
 Reference Hardware System
#############################

Zentyal Server software, based on Ubuntu server, can run on a wide variety of
hardware. But to take advantage of all the capabilities recommended in this 
guide, the server hardware should include the following features:

*  Multi-core processor with hardware virtualization extensions
*  From 4 Gb to 16 Gb of RAM
*  Motherboard with integrated RAID support using SATA-3
*  2 gigabit ethernet ports
*  External eSATA, USB 3.0, or other high-speed data interface

There is still a lot of room for motherboard selection, disk controller, 
RAID configuration, BIOS settings, and so forth. Two approaches to meeting these 
requirements are presented in this guide: an off-the-peg mini-server, and 
bespoke hardware for a desktop server providing the same functionality.

Regardless of the type of server, a compatible keyboard, video monitor, and 
mouse are required when installing a server. These items could be removed after 
installation for security purposes, since Zentyal is administered through a web 
browser.

Beyond a server, additional components are required to build a complete office 
network. The following items are required regardless of the type of server used:

+-----+----------------+-------------------------------------------------------+
| Qty | Product        | Description                                           |
+=====+================+=======================================================+	
|   1 | UPS            | CyberPower CP1350AVRLCD 1350VA 900W UP                |
+-----+----------------+-------------------------------------------------------+
|   2 | NETWORK SWITCH | D-Link DGS-2208 10/100/1000Mbps 8-Port switch         | 
+-----+----------------+-------------------------------------------------------+
|   1 | BACKUP DRIVE   | 1 TB External drive with eSATA or USB 3.0 interface   |
+-----+----------------+-------------------------------------------------------+

Off-the-Peg Server
=============================

We recommend the Apple Mac mini Server for off-the-shelf prebuilt systems. The 
Apple server has several advantages:

*  Availability: Mac mini Server is a standard stock item in all Apple stores.
*  Service: Apple store Genius Bar service (carry-in) is highly regarded.
*  Convenience: Eliminating custom assembly reduces installation effort.
*  Efficiency: Mac Server draws less power than alternatives.
*  Reliability: The mini's low component count reduces failure.
*  Functionality: A Mac can be repurposed as a workstation without losing value.
*  Price: The Mac mini Server costs significantly less than competing products.

Reference Hardware List
-----------------------------

+-----+------------------+------------------------------------------------------+ 
| Qty | Product          | Description                                          | 
+=====+==================+======================================================+ 
|   1 | MAC MINI SERVER  || Intel quad-core i7 processor, 4 Gb RAM              |  
|     |                  || 2 X 1-Tb hard drive, Intel HD Graphics 4000         |
|     |                  || HDMI port, Thunderbolt MiniDisplay port options     | 
|     |                  || Firewire 800, 4 X USB 3.0, 1 X 10-Gbps Thunderbolt  | 
|     |                  || SDXC card slot, Audio In-Out, IR receiver           | 
|     |                  || 1 Gigabit Ethernet, 802.11n Wireless, Bluetooth 4.0 | 
+-----+------------------+------------------------------------------------------+ 
|   1 | RAM UPGRADE      | 1 or 2 X 8-Gb 204-pin SODIMM DDR3 PC3-16000          | 
+-----+------------------+------------------------------------------------------+ 
|   1 | ETHERNET ADAPTER || Apple Thunderbolt to Gigabit Ethernet Adapter, or   | 
|     |                  || TRENDnet USB 3.0 to Gigabit Ethernet Adapter        |
+-----+------------------+------------------------------------------------------+ 
|   1 | SUPERDRIVE       | APPLE CD/DVD/DVD-RW alternative to USB or SDXC card  | 
+-----+------------------+------------------------------------------------------+ 

Drive setup
-----------------------------

The move from BIOS to EFI and UEFI has meant the end of BIOS RAID configuration. 
The Mac mini Server uses EFI and RAID configuration would occur in the OS. We 
recommend retaining the Mac OS X on :file:`/dev/sda`, and reformatting device
:file:`/dev/sdb` for Zentyal Linux, performing this setup while installing the 
operating system.

Build instructions
-----------------------------

Follow the procedures from article :ref:`resources:macserver` to install the 
rEFInd EFI boot manager and prepare the Mac mini Server to install Zentyal.

.. warning::
   If you are installing a Mac mini Server, ignore the rest of this article.

Bespoke Hardware Server
=============================

This reference hardware list builds a tower server for stand-alone installation, 
with components costing about $1000.00 including taxes and shipping as purchased 
from NewEgg. (Last updated in March 2013.) 

Reference Hardware List
-----------------------------

+-----+--------------+--------------------------------------------------------+
| Qty | Product      |  Description                                           |
+=====+==============+========================================================+	
|   1 | ATX CASE     | ABS ATX Mid-tower Case (APEX Vortex)                   |
+-----+--------------+--------------------------------------------------------+
|   2 | POWER SUPPLY | 450W ATX (Rosewill Stallion)                           |
+-----+--------------+--------------------------------------------------------+
|   1 | CONNECTOR    | SATA to eSATA Bracket (Nippon Labs)                    |
+-----+--------------+--------------------------------------------------------+
|   1 | DVD-RW       | CD/DVD Burner Black (LG)                               |
+-----+--------------+--------------------------------------------------------+
|   2 | HARD DRIVE   | 500GB 7200 RPM (WD Caviar WD5000AAKX)                  |
+-----+--------------+--------------------------------------------------------+
|   1 | MOTHERBOARD  | Micro ATX (SUPERMICRO MBD-X9SCM-O)                     |
+-----+--------------+--------------------------------------------------------+
|   2 | SDRAM        | DDR3 SDRAM KVR1333D3E9S/4G (Kingston)                  |
+-----+--------------+--------------------------------------------------------+
|   1 | PROCESSOR    | Intel Xeon E3-1220 BX80623E31220                       |
+-----+--------------+--------------------------------------------------------+

Build Instructions
-----------------------------

You should not attempt to build a computer if you do not know how to. Seriously, 
reading this guide could not possibly create a computer technician. If you 
require a pre-built system then order the computer fully installed, as described 
previously.

Connect Components
-----------------------------

*  Connect an Ethernet cable from your WAN router or gateway into eth0.
*  Plug an Ethernet cable from your LAN data switch into eth1.
*  Plug in a USB mouse and a USB keyboard.
*  Connect a VGA monitor cable to the VGA connector. (Server motherboards 
   generally do not support video other than VGA; the Mac mini uses HDMI.)
*  Connect the external backup drive using a USB 3.0 cable. 
*  Plug a power cord from your Uninterruptible Power Supply (UPS) to the back 
   of the server.

.. warning:: 
   Make sure the battery inside the UPS is actually connected. Plug the server 
   into an outlet on the UPS with battery backup and not just line conditioning.

.. _bios_setup:

System BIOS Settings
-----------------------------

System BIOS settings are available for motherboard configurations which have 
been tested and used, even though only the most recent motherboards are still 
available in the market place. Click one of the links below to see settings 
for a specific board.

| :ref:`resources:bios-x9scm-o`
| :ref:`resources:bios-p5bv-c`
| :ref:`resources:bios-955x7aa`
| :ref:`resources:bios-fi90hd`

RAID array Setup
-----------------------------

.. warning:: If another Fake-RAID array BIOS has been used to configure drives,
   the motherboard Intel Matrix RAID will not display when :kbd:`<Ctrl-I>` is 
   pressed, and the drives cannot be reconfigured. Particularly, if an Adaptec
   RAID array exists the drives cannot be reinstalled because the Zentyal/Ubuntu 
   installer is not compatible with Adaptec RAID.

.. note:: The SuperMicro motherboard BIOS setup, described in the link above, 
   includes RAID array setup. Other motherboards which permit RAID array setup 
   without BIOS setting changes should use the instructions below.

#. Press :kbd:`<Ctrl-I>` multiple times to enter the :guilabel:`Intel RAID` 
   utility.
#. Press :kbd:`3` for :guilabel:`Reset Disks to non-RAID`. Press :kbd:`<Space>` 
   to select disks, then press :kbd:`<Enter>` to finish the operation.
#. Press :kbd:`1` for :guilabel:`Create RAID volume`.

   #. At :guilabel:`Name:`, enter :kbd:`aaltsys <Enter>`.
   #. At :guilabel:`RAID Level:`, press :kbd:`<Down>` to display 
      :guilabel:`RAID1(Mirror)`.
   #. At :guilabel:`Capacity`, press :kbd:`<Enter>` to select the entire drive. 
   #. Respond to the :guilabel:`Create Volume` prompt with :kbd:`<Enter>`, and 
      confirm the :guilabel:`Are you sure ...?` question with :kbd:`Y`.

#. Press :kbd:`6` to :guilabel:`Exit` the RAID utility, and confirm the 
   :guilabel:`Are you sure ...?` question with :kbd:`Y`.

.. note:: The external drive setup is not described here, as a registration 
   procedure is required in Linux to connect the external backup drive. This 
   procedure is described later in the OS installation.
