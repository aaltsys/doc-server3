.. _xpunlimited:

#############################
AADS Server Terminal Services
#############################

Terminal services are required to run programs which are designed to run 
in a desktop environment, which access local databases, and which have limited 
graphical activity. While Windows Server products include terminal services  functionality, there is an easier way to provide this capability: 
<AADS Server http://www.aads-worldwide.hk/index.html>_.

Install VPN
=============================

We recommend using the Logmein/Hamachi VPN. Install Hamachi on the terminal 
services computer and setup a new network, providing the following entries::

  Networkname: ______________________________
     Password: ______________________________

Setup Users
=============================

:kbd:`<Right-Click>` on :menuselection:`Start --> Computer -->`, choose 
:menuselection:`Manage`. 

Under :guilabel:`Local Users and Groups`, open :guilabel:`Groups`. Add a group 
**WARES**.

Add users and set non-expiring passwords. Users in group WARES should be 
fungible, or interchangeable. Use one password for all such users.

+-----------+--------------------+------------------------------------+
| Username  | Full name          | Member of                          |
+===========+====================+====================================+
| {install} | System Installer   | Administrators, Users, RD Users    |
+-----------+--------------------+------------------------------------+
| {siteadm} | Site Administrator | Administrators, Users, RD Users    |
+-----------+--------------------+------------------------------------+
| STARTUP   | Startup VPN        | Guests                             |
+-----------+--------------------+------------------------------------+
| USER00    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER01    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER02    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER03    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER04    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER05    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER06    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER07    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER08    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+
| USER09    |                    | Users, Remote Desktop Users, WARES |
+-----------+--------------------+------------------------------------+

Keep a record of the user passwords, or use effective hints::

   Site Administrator: ______________________________
          Startup VPN: ______________________________
  WARES USER00 ... 09: ______________________________

Add Program Fles
=============================

Add folder :file:`WARES` inside :file:`C:\Users\Public`. In the 
:file:`WARES` folder, add the following files (downloadable from links on 
the previous page):

| WARES.pif
| NETPRINT.BAT
| NETSHARE.BAT
| WARES.BAT
| PATCHES (folder)

Install AADS Server
=============================


Setup Applications
=============================

.. note:: The AADServer is administered from a separate application which is 
   added to the Windows control panel and the Start menu. The administrator can 
   make this application always accessible as follows: :kbd:`<Right-click>` 
   :guilabel:`Maintenance AADServer` on the Start menu, and choose 
   :menuselection:`Pin to start menu`.

Using :menuselection:`Start --> Maintenance AADServer`, display tab 
:guilabel:`Application`. In section :guilabel:`Application control mode`, tab
:guilabel:`Mode`, choose the option ``Default a user sees a complete desktop``. 
In section :guilabel:`Application`, tab 
:guilabel:`Users, Groups, and Applications`, enter the following applications:

+-----------+------------------------------------+---------------------------+
| Display   | Program name                       | Startup | Command         | 
+===========+====================================+=========+=================+
| WARES     | C:\Users\Public\WARES\WARES.pif    |         |                 |
+-----------+------------------------------------+---------------------------+
| RDPPRINT  | C:\Users\Public\WARES\RDPPRINT.BAT |         |                 |
+-----------+------------------------------------+---------------------------+
| NETSHARE  | C:\Users\Public\WARES\NETSHARE.BAT |         |                 |
+-----------+------------------------------------+---------------------------+
| LOGOUT    |                                    |         | shutdown /l /f  | 
+-----------+------------------------------------+---------------------------+

Customize Batch Programs
=============================

NETSHARE.BAT
-----------------------------

Edit the :file:`NETSHARE.BAT` program to use either the correct IP address 
of the server or the server NETBIOS name, such as ``AAltsysServer``.

RDPPRINT.BAT
-----------------------------

The default :file:`NETPRINT.BAT` is intended to work for local printers, 
and it will not work for remote users. Instead, the remote users must share 
their printers and a table of users and shares is required:

+------------------+-----------------------+-------------------+--------+
| WARES login name | Workstation IP on VPN | Printer sharename | Device |
+==================+=======================+===================+========+
| USER00           |                       |                   | LPT1   |
+------------------+-----------------------+-------------------+--------+
| USER01           |                       |                   | LPT1   |
+------------------+-----------------------+-------------------+--------+
|   ...            |                       |   ...             |        |
+------------------+-----------------------+-------------------+--------+
| USER09           |                       |                   | LPT1   |
+------------------+-----------------------+-------------------+--------+

Substituting for {workstationIP} and {sharename} in the following script,
Create a new :file:`RDPPRINT.BAT` program as follows::

  @ECHO OFF
  NET USE LPT1 /DELETE
  rem NET USE LPT2 /DELETE
  :USER00
  IF NOT $%USERNAME%$ == $USER00$ GOTO USER01
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% 1 PAUSE
  GOTO EXIT
  :USER01
  IF NOT $%USERNAME%$ == $USER01$ GOTO USER02
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% 1 PAUSE
  GOTO EXIT
  :USER02
  IF NOT $%USERNAME%$ == $USER02$ GOTO USER03
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% 1 PAUSE
  GOTO EXIT
  :USER03
  ...
  :USER09
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% 1 PAUSE
  :EXIT
  
Download the :download:`RDPPRINT.BAT <_downloads/RDPPRINT.BAT>` batch file, 
saving it in folder :file:`C:\Users\Public`. Then edit the file as 
described above.
