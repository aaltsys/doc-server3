.. _hardware:

#############################
Mac mini Server Hardware
#############################

.. note::
   Apple products are available at any Apple store. All products described here 
   including Apple hardware are sold by and shipped from Amazon. Return policies 
   and product warranties may differ from in-store purchases for Apple products.

Apple's Mac mini Server provides a highly integrated CPU. As provided by AAltsys 
Technology, the hardware specifications for an Apple mac Mini server are:

+-----+------------------+-----------------------------------------------------+ 
| Qty | Product          | Description                                         | 
+=====+==================+=====================================================+ 
|   1 | MAC MINI SERVER  || Intel quad-core i7 processor, 4 Gb RAM             |  
|     |                  || 2 X 1-Tb hard drive, Intel HD Graphics 4000        |
|     |                  || HDMI port, Thunderbolt MiniDisplay port options    | 
|     |                  || Firewire 800, 4 X USB 3.0, 1 X 10-Gbps Thunderbolt | 
|     |                  || SDXC card slot, Audio In-Out, IR receiver          | 
|     |                  || 1 Gb Ethernet, 802.11n Wireless, Bluetooth 4.0     | 
+-----+------------------+-----------------------------------------------------+ 
|   1 | 8 Gb RAM UPGRADE | 1 X 8-Gb 204-pin SODIMM DDR3 PC3-16000              | 
+-----+------------------+-----------------------------------------------------+ 
|   1 | ETHERNET ADAPTER | Apple Thunderbolt to Gigabit Ethernet Adapter       | 
+-----+------------------+-----------------------------------------------------+ 
|   1 | MYPASSPORT DRIVE | WD Ultra 1 Tb USB 3.0 external drive for backup     | 
+-----+------------------+-----------------------------------------------------+ 

Additional components are required for a headless server installation, and 
console components are needed while installing operating system software:

+-----+------------------+-----------------------------------------------------+ 
| Qty | Product          | Description of Required Installation Components     | 
+=====+==================+=====================================================+ 
|   1 | CABLE MODEM      | WAN: an ISP's broadband connection to the Internet  |
+-----+------------------+-----------------------------------------------------+ 
|   2 | NETWORK SWITCH   | LAN: NETGEAR GS108NA ProSafe 8-Port Gigabit Switch  | 
+-----+------------------+-----------------------------------------------------+
|   1 | UPS              | CyberPower CP1350AVRLCD Series UPS 1350VA 810W      |
+-----+------------------+-----------------------------------------------------+ 

+-----+------------------+-----------------------------------------------------+ 
| Qty | Product          | Description of Console Components                   | 
+=====+==================+=====================================================+ 
|   1 | HDMI/DVI MONITOR | ASUS VE248H 24-Inch LED Monitor with Speakers       |
+-----+------------------+-----------------------------------------------------+
|   1 | USB KEYBOARD     | Apple MB110LL/B Keyboard w/ Numeric Keypad (White)  | 
+-----+------------------+-----------------------------------------------------+ 
|   1 | USB MOUSE        | AmazonBasics 3-Button USB Wired Mouse (Black)       |
+-----+------------------+-----------------------------------------------------+ 
|   1 | USB SUPERDRIVE   || APPLE CD-RW/DVD-RW alternative to USB or SDXC card |
|     |                  || (used during OS installation only)                 |
+-----+------------------+-----------------------------------------------------+ 

.. note::
   #. The Mac mini Server comes with video connectors for HDMI and DVI, but not 
      VGA, and no display cable is included. Provide a combination of cable and 
      display compatible with HDMI or DVI. 
   #. The server requires USB keyboard and mouse; not PS/2 style devices.
   #. The Apple Superdrive works with Apple devices only. Other brands or types 
      of USB optical drives are not recognized by Apple servers.

-----------------------------

.. _connectserver:

#############################
Mac mini Server Connections
#############################

.. image:: _images/macmini_MD389LLA.png

The connector side of the Mac mini Server is illustrated above. Plug up cable 
connectors as follows:

+------------------+--------------------+--------------------------------------+
| Connector        | Cable              | Provided                             |
+==================+====================+======================================+
| Power supply     | white power cable  | Special power cable included         |
+------------------+--------------------+--------------------------------------+
| Gigabit Ethernet | Ethernet to LAN    |                                      |
+------------------+--------------------+--------------------------------------+
| Firewire         | (unconnected)      |                                      |
+------------------+--------------------+--------------------------------------+
| HDMI             | HDMI to monitor    | HDMI-to-DVI converter included       |
+------------------+--------------------+--------------------------------------+
| Thunderbolt      | Ethernet to WAN    | Thunderbolt-to-Ethernet adapter      |
+------------------+--------------------+--------------------------------------+
| USB 3.0          | USB backup device  | MyPassport 1 Tb external drive       |
+------------------+--------------------+--------------------------------------+
| USB 3.0          | USB Keyboard       |                                      |
+------------------+--------------------+--------------------------------------+ 
| USB 3.0          | USB Mouse          |                                      |
+------------------+--------------------+--------------------------------------+ 

AALtsys Technology servers which use the Zentyal operating system on Apple 
server hardware may be installed and managed "headless," meaning that the 
monitor, keyboard, and mouse are not required. If compatible console devices are
not available at a site, then a computer on the LAN can manage the server from 
the browser once the server is connected and powered up.

Manage the server from a LAN workstation as follows:

#. Connect the network as described above, then power up the server.
#. Restart a LAN computer, obtaining IP and DNS automatically through DHCP.
#. Launch either Chrome or Firefox browser. Internet Explorer will not work.
#. Enter address https://192.168.2.241 in the browser. Accept the server's 
   self-signed certificate.
#. Login to the server management program using the provided credentials.

-----------------------------

.. _upgradeserver:

#############################
Upgrading a Zentyal Server 
#############################

Configuration databases and file permissions on older versions of Zentyal may 
not be compatible with newer Zentyal releases. Upgrade older servers using the 
following instructions.

Copy shares from old server
=============================

At a workstation, use the command line to create directories for each server 
share, and then copy the shared files into the new local directories. Open the 
command line by clicking :guilabel:`Start` and entering :kbd:`cmd.exe` in the
the search window, then selecting :program:`cmd.exe` from the search results.

Copy files from share :file:`\\\\AAltsysserver\\shared`, mapped to drive 
:file:`S:`, by typing the commands::

   md \shared
   cd \shared
   xcopy S:\*.* . /s/e

Use the preceding commands as a template for copying other server shares to a 
workstation. For example, copy a user's server private home directory, mapped to 
drive :file:`H:`, by replacing :file:`shared` with :file:`home` and :file:`S:` 
with :file:`H:` in the preceding commands.

Swap to new server
=============================

Shutdown and disconnect the old server, then connect the new server using the 
diagram shown previously. Then power on the new server, and access its 
administration at https://192.168.2.241 from a workstation web browser.

Enter office configuration 
=============================

Use the instructions at :ref:`installoffice` to configure file sharing, 
printers, and users and groups.

Copy shares to new server
=============================

For each share directory saved on a workstation, first map the share to its 
corresponding drive letter. In Windows 7, shares are mapped to drives by opening 
:guilabel:`Computer`, pressing :kbd:`[F10]` to display the menu, and selecting 
:menuselection:`Tools --> Map Network Drive`. 

.. note::
   Download script :download:`NETSHARE.BAT <_downloads/netshare.bat>` to the 
   workstation desktop as an alternative to mapping drives. Then edit the batch
   script to reference the new server, and run the script to map drives. 

After mapping a share to a drive letter, open the command line, then use the 
following commands to copy the share files back to the server, remembering to 
replace :file:`S:` and :file:`shared` with the respective share drive letter and 
directory name for a share::

   cd \shared
   xcopy . S:\ /s/e

-----------------------------

.. _replaceserver:

#############################
Replacing a Current Server
#############################

Backup the Old Server
=============================

To backup the server configuration only, login to Zentyal, and from menu 
selection :menuselection:`CORE --> System --> Import/Export Configuration`, 
:guilabel:`Backup the Current State`. Then Select the new configuration file 
from the :guilabel:`Backups list`, and download it to a workstation for transfer 
to the replacement system. [#]_

Zentyal does not provide a program option or document a command for performing a 
demand backup. Backup all user data along with the server configuration at menu 
selection :menuselection:`CORE --> System --> Backup`, by setting a new time for 
a full backup to happen starting on the next hour.

Install the New Server
=============================

.. note::
   Preparing to restore data from a backup drive requires using a Command Line 
   Interface (CLI), which is achieved by one of the following:
   
   #. :program:`ssh`: From a workstation running either Linux or Apple OS-X, 
      open a command line and start a terminal session on the server with the 
      command::
       
         ssh admin1@192.168.2.241
   
   #. :program:`console`: Connect keyboard, mouse, and video monitor to the 
      server. Login on the console and open a terminal session there.

Use the :ref:`connectserver` documentation to connect and manage the new server.

Connect old backup drive
-----------------------------

If the new server uses a new backup drive, disconnect the new backup drive and 
connect the backup drive from the old server. Open a command line as described 
in the note above, then download shell script :program:`backupdrive.sh` and run 
the script with the commands::

   wget http://servers.aaltsys.info/resources/_downloads/backupdrive.sh -P ~/
   sudo ~/backupdrive.sh

Restore configuration, data
-----------------------------
   
In a web browser, login to Zentyal server management at https://192.168.2.241. 
Select :menuselection:`Core --> System --> Backup --> Services Restore` from the 
menu to restore the system configuration, then use 
:menuselection:`Restore Files` to restore backed up data.

Reconnect new backup drive
-----------------------------

If the new server has a new backup drive, wait a minute after activity finishes, 
then disconnect the old backup drive used for data transfer. Connect the new 
drive, and reconfigure it with the terminal command::

   sudo ~/backupdrive.sh

----------

.. rubric: Footnotes

.. [#] `Zentyal backup procedures documentation <http://doc.zentyal.org/en/backup.html>`_.

