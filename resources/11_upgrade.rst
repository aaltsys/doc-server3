###############################
Upgrade Server to AAltSysServer
###############################

.. note:: This document applies to upgrading an older generation WARESserver to 
   a later AAltsysServer which uses the Zentyal operating system.


Typographical Conventions
=========================

Various type styles are used throughout this document to indicate  

+-----------------------------------------------+-------------------------------+
| Type Style                                    | Example of Style              |
+===============================================+===============================+
| Body text is in plain proportional type       | sample document text          | 
+-----------------------------------------------+-------------------------------+
| Titles or references are emphasized           | *this text is emphasized*     | 
+-----------------------------------------------+-------------------------------+
| Keywords or menu selections are bold          | **this is bold text**         | 
+-----------------------------------------------+-------------------------------+
| Commands and program listings are monospaced  | ``entries are monospaced``    | 
+-----------------------------------------------+-------------------------------+
| Hyperlinks are underlined                     | \(no example provided\)       | 
+-----------------------------------------------+-------------------------------+

.. warning::
   All Unix-like operating systems are inherently case-sensitive. Type commands
   in correct case exactly as shown. 

Change Network Driver in AREV
=============================

#. From a workstation, log into WARES using the supervisor level password.
#. Press :kbd:`F2` to see all menus, choose **STARTUP**.
#. Select :menuselection:`Application --> Open`, and enter the account ``SYSPROG``, password ____________.
#. In the Commands window, enter ``RUNMENU LANPACK``.
#. Choose **Network Type** from menu :menuselection:`Lanpack`.
#. Press :kbd:`F2` for options, and switch to **Microsoft Lan Manager**.
#. Press :kbd:`F9` to save the setting. (A message will display saying revboot is rebuilt.)
#. Choose **Exit** to exit the application.

Backup WARES and Fileshares
===========================

A backup copy of server data can be created either at the server, or at a workstation. 

From the Server:
----------------

.. warning::  
   This guide section makes the following assumptions about your WARESserver:
   
   * Your operating system is some flavor of Linux Fedora. 
   * A **wares** program folder is located at **/var/opt/arev**
   * A **public** file share folder is located at **/home/global**


#. Login as user **root**, password __________________
#. Insert a USB drive in a server port
#. Open a terminal command prompt from :menuselection:`system/(accessories)/terminal`
#. Enter the commands from the command column below:

+--------------------------------------------------------+--------------------------------------+
| Command                                                | Explanation                          |
+========================================================+======================================+
| ``ls /media/``                                         | Identify mount point of USB drive    |
+--------------------------------------------------------+--------------------------------------+
| ``mkdir /media/(usb_drive)/wares``                     | Create a **wares** directory on USB  |
+--------------------------------------------------------+--------------------------------------+
| ``mkdir /media/(usb_drive)/public``                    | Create a **public** directory on USB |
+--------------------------------------------------------+--------------------------------------+
| ``cp -r /var/opt/arev/. to /media/(usb_drive)/wares/`` | Copy **wares** data to USB           |
+--------------------------------------------------------+--------------------------------------+
| ``cp -r /home/global/. to /media/(usb_drive)/public/`` | Copy **public** data to USB          |
+--------------------------------------------------------+--------------------------------------+

From a Workstation:
-------------------

.. warning::	   
   This guide assumes the following:
   
   * The server share for the WARES program is mapped to drive letter **W:\\**.
   * The server share for public file folders is mapped to drive letter **S:\\**.


#. Insert a USB drive, and open it in a window on the desktop.
#. Create folders **wares** and **public** on the USB drive.
#. Open My Computer, and navigate to drive **W:\\**.
#. Press :kbd:`Ctrl-A Ctrl-C` to copy all contents of drive W:.
#. Click in the USB drive window, and double-click to open the **wares** folder. Press :kbd:`Ctrl-V` to paste.
#. Switch back to My Computer, and navigate to drive **S:\\**.
#. Press :kbd:`Ctrl-A Ctrl-C` to copy all contents of drive S:.
#. Click in the USB drive window, and double-click to open the **public** folder. Press :kbd:`Ctrl-V` to paste.
#. Once copying is finished, Right-click the USB drive icon and choose :menuselection:`Safely Remove`.

Install New OS on Old Hardware
==============================

#. Logout on the WARESserver console.
#. Select **Shutdown Server** to shutdown and turn power off.
#. Open the server case, make a record of drive connections for 

+-------------------------------------+-------------------------------------+
| **SATA 1** --> ____________________ | **SATA 2** --> ____________________ |
+-------------------------------------+-------------------------------------+
| **SATA 3** --> ____________________ | **SATA 4** --> ____________________ |
+-------------------------------------+-------------------------------------+

#. Disconnect old hard drives, add new drive controller and new drives.
#. Connect new drives to the new soft-hardware RAID card.
#. Use the <AAltSys> DVD to install the new OS per the *Quick Install Guide*.

Configure New Server OS
=======================

.. note:: Server configuration is performed through web applications which may be accessed from a workstation web browser or directly at the server console. For the purpose of this guide, instructions are given for a server console. (AAltSys prefers administration from workstations, as this avoids having physical access to a server with monitor, keyboard, and mouse.)

Register the Server
-------------------

#. Choose :menuselection:`Debian --> Registration` on the task bar to display the Registration window.
#. Enter the site email address, registration number, and activation code.

.. note:: Registrations must be purchased in advance at AAltSys.com before registering a server. 

Open Zentyal Administration
---------------------------

#. Select :menuselection:`Debian-->Zentyal Administration` from the task bar.
#. Login to Zentyal with an administrator _____________ password _______________.
#. --> Select all options from the left menu <--

Setup Shared Folders
^^^^^^^^^^^^^^^^^^^^

   #. Select :menuselection:`Office --> File Sharing --> General Tab`.
   #. If server is in a Windows domain environment, uncheck :guilabel:`Enable PDC`.
   #. Set the workgroup or domain for the server (defaults to ``AALTSYS``).
   #. Set the server description string (defaults to ``AAltSys Server``).
   #. Click :guilabel:`Change` to save settings.
   #. Select :menuselection:`Office --> File Sharing --> Shares Tab`.
   #. Click :guilabel:`add new` to define a share.
   #. Enter share name ``arev``, select :guilabel:`Directory under Zentyal`, name ``arev``
   #. You may add a comment, ``WARES data``. Do not check :guilabel:`Guest access`.
   #. Click **Add** to add the share directory.
   #. Click **add new** to define a share.
   #. Enter share name ``public``, select **Directory under Zentyal**, name ``public``
   #. You may add a comment, ``Shared files``. Do not check **Guest access**.
   #. Click **Add** to add the share directory.

Setup Users and Groups
^^^^^^^^^^^^^^^^^^^^^^

   #. Select :menuselection:`Office --> Users and Groups --> Users`.
   #. Enter a Username, First name, Last name, and Password (twice).
   #. Specify group **Users**.
   #. Click :guilabel:`Add` to add the user.
   #. Repeat the preceding steps for every network user.

.. note:: Username and Password entries on workstations must match the Usernames and Passwords entered here. See the *Workstation Setup* section in this guide for more information.

Setup Shared Print Queues
^^^^^^^^^^^^^^^^^^^^^^^^^

   #. Select :menuselection:`Office --> Printer Sharing`.
   #. Click on the :guilabel:`CUPS Web Interface` link (in the bar below Printer Sharing).
   #. Define each shared or network printer in CUPS. Refer to on-line documentation.


Close Zentyal Management
------------------------

.. warning:: Save all your settings when the server configuration is complete!

#. Click :guilabel:`Save changes` at the top-right of the Zentyal window.
#. Click the :guilabel:`Save` button in the Saving Configuration confirmation page. 
#. Click the link to :guilabel:`return to the Dashboard`.
#. Click :guilabel:`Logout` At the top right of the Zentyal window.
#. Click :guilabel:`Exit` on the Logout confirmation page to end your session.
#. Click the :guilabel:`close` button in the title bar to close the Zentyal window.


Restore WARES and Public Data
-----------------------------

#. Select :menuselection:`Debian --> Advanced --> Terminal` from the task bar menu.
#. Login with an administrator _____________ password _______________.
#. Insert the USB drive used for backup in a server port.
#. Copy files to the server, and set user permissions, with the following commands:

   |
   | ``mkdir -p /mnt/usb``
   | ``mount /dev/sdc1 /mnt/usb``
   | ``cd /home/samba/shares``
   | ``cp -r /mnt/usb/wares/. ./arev/``
   | ``cp -r /mnt/usb/public/. ./public/``
   | ``chmod -R 777 ./arev``
   | ``chmod -R 777 ./public``
   | ``rm -f /etc/udev/rules.d/70*``
   | ``shutdown -h now``

Shutdown Server and Upgrade Hardware
====================================

(Refer to the *Installation Manual* chapter on *Reference Hardware*.)

.. warning::  Make sure you connect the network correctly at this time. With the **ASUS P5BV-C** motherboard, when the computer is viewed from the rear, the ethernet ports are: eth1 (LAN) on the left, eth0 (WAN) on the right.


Restart Server and Workstations
===============================

(Refer to the *Workstation Administration* manual.) 
