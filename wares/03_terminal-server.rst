.. _xpunlimited:

#############################
AAD Server Terminal Services
#############################

When remote workstations require access to a program, Terminal Services may be 
necessary. This is a decent solution for programs which are designed to run in 
a desktop environment, which access local databases, and which have limited 
graphical activity. While Windows Server products include terminal services 
functionality, there is an easier way to provide TS capability: 
`AADServer <http://www.aads-worldwide.hk/index.html>`_.

TS Host Machine
=============================

Windows Terminal Services is only available as a 64-bit Operating System 
feature. Frequently, the reason for remote TS capability is to share a DOS or 
32-bit Windows program such as WARES. Therefore a separate network station 
running Windows 7 32-bit is required for TS. We recommend Atom-powered netbook 
or notebook with 2 Gb RAM for this use, since this guarantees the operating 
system is 32-bit, and a battery backup for power is built into the computer. 

Upgrade the operating system to Windows 7 Professional, as this is required for 
serving RDP sessions.

.. warning:: After registering Windows and upgrading, remove any bloatware 
   which includes nag screens such as "update your virus software now." If 
   nag screens open for a remote user with program execution restrictions,
   the remote session may hang.

Install VPN
=============================

We recommend using the 
`Logmein/Hamachi VPN <https://secure.logmein.com/products/hamachi/>`_. 
Install Hamachi on the terminal services computer and setup a new Hamachi 
network hosted on this TS machine.

.. note:: Try `remobo <http://www.remobo.com/howto>`_ as an alternative to 
   the Hamachi VPN.

Setup Users
=============================

:kbd:`<Right-Click>` on :menuselection:`Start --> Computer`, choose 
:menuselection:`Manage`. 

Under :guilabel:`Local Users and Groups`, open :guilabel:`Groups`. Add a group 
**WARES**.

Add users as shown in the following table, and set non-expiring passwords. 
Users in group WARES should be fungible, or interchangeable. Use the same 
password for all such users.

+-----------+--------------------+------------------------------------+
| Username  | Full name          | Member of                          |
+===========+====================+====================================+
| {install} | System Installer   | Administrators, Users, RD Users    |
+-----------+--------------------+------------------------------------+
| {siteadm} | Site Administrator | Administrators, Users, RD Users    |
+-----------+--------------------+------------------------------------+
| STARTUP   | VPN Startup        | Guests                             |
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

Unless the VPN is run as a service, a user must login and launch the VPN 
when the computer boots. Set user **STARTUP** to login at boot using the 
:program:`NETPLWIZ` Windows administration utility. When logged in as user 
**STARTUP**, copy the Hamachi start file into the user's start menu folder 
:menuselection:`Start --> All Programs --> Startup`.

.. note:: The **STARTUP** login deducts one user from the available user count 
   of :program:`AADServer`.

Add Program Fles
=============================

Add folder :file:`WARES` inside :file:`C:\\Users\\Public`. In the 
:file:`WARES` folder, add the following files, downloadable from links on 
:ref:`this page <workstation:downloads>`:

| :file:`NETPRINT.BAT`
| :file:`NETSHARE.BAT`
| :file:`WARES.BAT`
| :file:`WARES.pif`

Install AADS Server
=============================

From the `AADS site <http://www.aads-worldwide.hk/index.html>`_, purchase and 
download an appropriate copy of the server software. For WARES remote access, 
we recommend the 10 user small system package unless all remote workstations 
are capable of Windows domain authentication.

.. warning:: When changing versions of AADServer, always choose to perform an 
   upgrade rather than removing and installing the software. Otherwise, any 
   existing configuration information will be lost.
   
.. warning:: When AADServer small system version is installed on a computer 
   which belongs to a windows domain, domain registration will be eliminated. 
   Install AADServer Enterprise only on domain machines.

Setup Applications
=============================

.. note:: The AADServer is administered from a separate application which is 
   added to the Windows control panel and the Start menu. The site administrator 
   should make this application always accessible form the start menu:
   <Right-click> on :guilabel:`Maintenance AADServer`, and choose 
   :menuselection:`Pin to start menu`.

+ Using :menuselection:`Start --> Maintenance AADServer`, display tab 
  :guilabel:`Application`. 
+ In section :guilabel:`Application control mode`, tab :guilabel:`Mode`, choose 
  :guilabel:`Default a user sees a complete desktop`. 
+ In section :guilabel:`Application`, tab :guilabel:`Users, Groups, and Applications`, 
  enter the following programs and assign them to group **WARES**.:
  
  +-----------+------------------------------------+---------+-----------------+
  | Display   | Program name                       | Startup | Command         | 
  +===========+====================================+=========+=================+
  | WARES     | C:\Users\Public\WARES\WARES.pif    |         |                 |
  +-----------+------------------------------------+---------+-----------------+
  | RDPPRINT  | C:\Users\Public\WARES\RDPPRINT.BAT |         |                 |
  +-----------+------------------------------------+---------+-----------------+
  | NETSHARE  | C:\Users\Public\WARES\NETSHARE.BAT |         |                 |
  +-----------+------------------------------------+---------+-----------------+
  | LOGOUT    |                                    |         | shutdown /l /f  | 
  +-----------+------------------------------------+---------+-----------------+

.. note:: Application windows on remote machines may not be sized to display 
   correctly. We suggest logging into the application for each user, and sizing 
   the application window before accessing the TS user from remote. DOS program 
   windows are resized by clicking the menu icon on the top left of the title 
   bar. Then on the :guilabel:`Font` tab, choose a character set and size, such 
   as **Lucida Console 20**.
  
Customize Batch Programs
=============================

NETSHARE.BAT
-----------------------------

Edit the :file:`NETSHARE.BAT` program to use either the correct IP address 
or NETBIOS name of the server, such as :kbd:`192.168.2.241` or 
:kbd:`AAltsysServer`. 

RDPPRINT.BAT
-----------------------------

The default :file:`NETPRINT.BAT` is intended to work for local printers, 
and it will not work for remote users. Instead, the remote users must share 
their printers. Before printing can work, a table of remote workstation names, 
VPN addresses, TS users and printer sharenames is required. A sample table for 
this information is provided in the authentication section following.

Substituting for {workstationIP} and {sharename} in the following script,
Create a new :file:`RDPPRINT.BAT` program as follows::

  @ECHO OFF
  NET USE LPT1 /DELETE
  rem NET USE LPT2 /DELETE
  :USER00
  IF NOT $%USERNAME%$ == $USER00$ GOTO USER01
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% NEQ 0 PAUSE
  GOTO EXIT
  :USER01
  IF NOT $%USERNAME%$ == $USER01$ GOTO USER02
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% NEQ 0 PAUSE
  GOTO EXIT
  :USER02
  ...
  :USER09
  @ECHO ON
  NET USE LPT1 \\{workstationIP}\{sharename} /PERSISTENT:YES
  IF %ERRORLEVEL% NEQ 0 PAUSE
  :EXIT
  
A sample batch file :download:`RDPPRINT.BAT <_downloads/RDPPRINT.BAT>` is 
provided; download it to :file:`C:\\Users\\Public\\WARES\\RDPPRINT.BAT` on the 
TS machine. Then edit the file as described above.

Authentication entries
=============================

Keep a record of this information in a safe place.

Windows Registration:
-----------------------------

::

  Registration number: ______________________________

Hamachi VPN
-----------------------------

::

  Networkname: ______________________________
     Password: ______________________________

AADServer License
-----------------------------

::

  Registration username: ______________________________
         License number: ______________________________

     
TS usernames and passwords
-----------------------------

::

  +----------------------+--------------------+-------------------+
  | Function             | Username           | Password          |
  +======================+====================+===================+
  | System Installer     | (this information is never published)  |                   
  +----------------------+--------------------+-------------------+
  | Site Administrator   |                    |                   |
  +----------------------+--------------------+-------------------+
  | Hamachi VPN Startup  |                    |                   |
  +----------------------+--------------------+-------------------+
  | WARES User           | USER00 ... USER09  |                   |
  +----------------------+--------------------+-------------------+

``RDPPRINT.BAT`` information
-----------------------------

::

  +-------------+-------------------+-------------------+---------------+--------+
  | WARES login | Workstation name  | Hamachi VPN IP    | Printer share | Device |
  +=============+===================+===================+===============+========+
  | USER00      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER01      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER02      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER03      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER04      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER05      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER06      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER07      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER08      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | USER09      |                   |                   |               | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+
  | EXAMPLE     | DEVELOPER         | 25.50.50.50       | Laserjet      | LPT1   |
  +-------------+-------------------+-------------------+---------------+--------+

.. note:: It would be a good idea to ghost a drive image from this installation 
   once complete, so that recovery from an OS failure would be possible.