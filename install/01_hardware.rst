.. _hardware:

###########################
 Reference Hardware System
###########################

The Zentyal Install DVD requires a multi-core 64-bit CPU with hardware virtualization
extensions. This still leaves a lot of room for motherboard selection, disk controller, 
RAID configuration, BIOS settings, and so forth. To save effort through simplicity, 
a reference hardware system is described which can be purchased from a single vendor 
and assembled in under two hours.

Hardware Components
====================

This reference hardware list builds a tower server for stand-alone installation, with 
a build cost of about $1000.00 including tax and shipping as purchased from NewEgg.   

+-----+--------------+-----------------+---------------------------------------+
| Qty | Product      | NewEgg Number   | Description                           |
+=====+==============+=================+=======================================+	
|   1 | CASE         | N82E16811154098 | APEX Vortex 3620 SGCC / ABS ATX Case  |
+-----+--------------+-----------------+---------------------------------------+
|   2 | POWER SUPPLY | N82E16817182022 | Rosewill Stallion RD450-2-DB 450W ATX |
+-----+--------------+-----------------+---------------------------------------+
|   1 | CONNECTOR    | N82E16812226003 | KINGWIN eSATA PCI Bracket ESAC-02     |
+-----+--------------+-----------------+---------------------------------------+
|   1 | DVD-RW       | N82E16827151233 | SAMSUNG CD/DVD Burner Black SH-222AB  |
+-----+--------------+-----------------+---------------------------------------+
|   2 | HARD DRIVE   | N82E16822136769 | WD Caviar WD5000AAKX 500GB 7200 RPM   |
+-----+--------------+-----------------+---------------------------------------+
|   1 | MOTHERBOARD  | N82E16813182254 | SUPERMICRO MBD-X9SCM-O C204 Micro ATX |
+-----+--------------+-----------------+---------------------------------------+
|   2 | SDRAM        | N82E16820139077 | Kingston DDR3 SDRAM KVR1333D3E9S/4G   |
+-----+--------------+-----------------+---------------------------------------+
|   1 | PROCESSOR    | N82E16819115084 | Intel Xeon E3-1220 BX80623E31220      |
+-----+--------------+-----------------+---------------------------------------+
|   1 | ETHERNET NIC | N82E16833389009 | NETIS AD-1103 10/100/1000Mbps Adapter |
+-----+--------------+-----------------+---------------------------------------+

Additional hardware is required for a complete network installation.

+-----+--------------+-----------------+---------------------------------------+
| Qty | Product      | NewEgg Number   | Description                           |
+=====+==============+=================+=======================================+	
|   1 | UPS          | N82E16842102048 | CyberPower CP1350AVRLCD 1350VA 900W UP|
+-----+--------------+-----------------+---------------------------------------+
|   2 | NETWK SWITCH | N82E16833127082 | D-Link DGS-2208 10/100/1000Mbps 8-Port| 
+-----+--------------+-----------------+---------------------------------------+
|   1 | EXTERNAL SATA| N82E16817182180 | Rosewill RX35-AT-SC eSATA Enclosure   |
+-----+--------------+-----------------+---------------------------------------+
|   1 | BACKUP DRIVE | N82E16822148725 | Seagate Barracuda ST1500DL003 1.5TB   |
+-----+--------------+-----------------+---------------------------------------+

.. tip:: 
	 The preceding build list does not include a VGA monitor, USB keyboard, and
	 USB mouse. These components are required when installing and configuring a 
	 server, but may be removed (for security reasons) once the server is installed.

Connect Components
====================

+ Connect an Ethernet cable from your WAN router or gateway into eth0 (in the reference system, this would be the add-in card).
+ Plug an Ethernet cable from your LAN data switch into eth1 (the upper network port on the motherboard of the reference system).
+ Plug in a USB mouse and a USB keyboard.
+ Connect a VGA monitor cable to the VGA connector (server motherboards generally do not support video other than VGA).
+ Connect the external backup drive using either an eSATA cable or a USB cable.
+ Plug a power cord from your Uninterruptible Power Supply (UPS) to the back of the server.

.. warning::
	 Make sure the battery inside the UPS is actually connected. 
	 Plug the server into an outlet on the UPS with battery backup and not just 
	 line conditioning.

Set up the System BIOS
==================================

System BIOS settings are available for motherboard configurations which have 
been tested and used, even though only the most recent motherboards are still 
available in the market place. Click one of the links below to see settings 
for a specific board.

:ref:`BIOS settings for ASUS P5BV-C <bios-p5bv-c>`

Setting up RAID array BIOS
==================================

(To be completed later)

.. note::
	 A registration procedure is required in Linux to connect the external backup 
	 drive. This procedure cannot be performed until after the OS is installed 
	 and configured.