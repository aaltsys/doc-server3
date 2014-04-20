.. _aadserver:

#############################
AAD Server Terminal Services
#############################

Multiuser Terminal Services is a Windows feature which allows remote 
workstations access to programs on a central computer system. Terminal Services 
is necessary when centralized computer programs which run in a desktop 
environment and which access local databases must be used at remote locations. 

Frequently, the reason for remote TS capability is to share a DOS or 32-bit 
Windows program such as WARES. Microsoft offers multiuser Terminal Services in 
their 64-bit Advanced Server Operating Systems. DOS and 32-bit Windows programs 
are incompatible with 64-bit Windows, so a different solution is required.

TS Host Machine
=============================

An add-on program, `AADServer <http://www.aads-worldwide.hk/index.html>`_, is 
available for Windows XP or Windows 7, in both 32-bit and 64-bit versions, and 
can be used in small offices or enterprise domain environments. This program 
has many features which make it an excellent remote access software solution.

On the hardware side, an adjunct server machine is required in an office to 
host terminal sessions on the AADServer. We suggest using an Atom-powered 
netbook with 2 Gb RAM for this purpose. The Atom processor requires a 32-bit 
operating system, and a battery backup for power is built into the computer. 

Most netbooks ship with Windows Home Starter Edition as an operating system. 
Microsoft supplies RDP server functionality only in Professional and Ultimate 
editions. Upgrade the netbook operating system to Windows 7 Professional.

.. warning:: 
   After registering Windows and upgrading, remove any bloatware 
   which includes nag screens such as "update your virus software now." If 
   nag screens open for a remote user with program execution restrictions,
   the remote session may hang.

Install VPN
=============================

Secure access across the Internet requires a Virtual Private Network service, 
or VPN. `Logmein/Hamachi VPN <https://secure.logmein.com/products/hamachi/>`_ 
provides free hosting services with very little client configuration. 
Install Hamachi on the terminal services computer and setup a new Hamachi 
network hosted on this TS machine.

.. note:: 
   `Remobo <http://www.remobo.com/howto>`_ may be an alternative to Hamachi VPN.

Setup Users
=============================

<Right-Click> on :menuselection:`Start --> Computer`, choose 
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
when the computer boots. Set user **STARTUP** to login at boot as follows:

#. From the start menu, run :program:`NETPLWIZ` administration utility 
   (Windows 7) or :program:`control userpasswords2` (Windows XP).
#. Uncheck the box for :guilabel:`Users must enter a username and password to 
   use this computer`, and then click button :guilabel:`Apply`.
#. In the resulting :guilabel:`Automatically log on` dialog, Enter user name 
   :kbd:`STARTUP`, the user's password, confirm the password, and then click 
   :guilabel:`OK`. Click :guilabel:`OK` again to close the main control panel.
#. Login as user **STARTUP**. Copy the Hamachi start file into the user's start 
   menu folder, :menuselection:`Start --> All Programs --> Startup`.
#. Reboot the computer to verify that user **STARTUP** logs in automatically and 
   that the Hamachi VPN is started.

.. note:: 
   The **STARTUP** login deducts one user from the available user count 
   of :program:`AADServer`.

Add Program Fles
=============================

Add folder :file:`WARES` inside :file:`C:\\Users\\Public`. In the 
:file:`WARES` folder, add the following files, downloadable from links at 
`DOS WARES Resources <http://doswares.aaltsys.info/resources/>`_:

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

.. warning:: 
   When changing versions of AADServer, always choose to perform an 
   upgrade rather than removing and installing the software. Otherwise, any 
   existing configuration information will be lost.
   
.. warning:: 
   If a computer belongs to a windows domain, installing AADServer 
   small system version will remove the domain registration. Install only the
   Enterprise edition of AADServer on domain member machines.

Setup Applications
=============================

.. note:: 
   The AADServer is administered from a separate application which is 
   added to the Windows control panel and the Start menu. The site administrator 
   should make this application always accessible from the start menu:
   <Right-click> on :guilabel:`Maintenance AADServer`, and choose 
   :menuselection:`Pin to start menu`.

+  Using :menuselection:`Start --> Maintenance AADServer`, display tab 
   :guilabel:`Application`. 
+  In section :guilabel:`Application control mode`, tab :guilabel:`Mode`, choose 
   :guilabel:`Default a user sees a complete desktop`. 
+  In section :guilabel:`Application`, tab 
   :guilabel:`Users, Groups, and Applications`, 
   enter the following programs and assign them to group **WARES**:
  
   +-----------+----------------------------------------+---------+-----------------+
   | Display   | Program name                           | Startup | Command         | 
   +===========+========================================+=========+=================+
   | WARES     | C:\\Users\\Public\\WARES\\WARES.pif    |         |                 |
   +-----------+----------------------------------------+---------+-----------------+
   | RDPPRINT  | C:\\Users\\Public\\WARES\\RDPPRINT.BAT |         |                 |
   +-----------+----------------------------------------+---------+-----------------+
   | NETSHARE  | C:\\Users\\Public\\WARES\\NETSHARE.BAT |         |                 |
   +-----------+----------------------------------------+---------+-----------------+
   | LOGOUT    |                                        |         | shutdown /l /f  | 
   +-----------+----------------------------------------+---------+-----------------+

.. note:: 
   The path :file:`C:\\Users\\Public` on Windows 7 replaced the folder 
   :file:`C:\\Documents and Settings\\All Users\\Desktop` used by Windows XP.
   
.. note:: 
   Application windows on remote machines may not be sized to display 
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
  
A sample batch file :download:`RDPPRINT.BAT <_downloads/rdpprint.bat>` is 
provided; download it to :file:`C:\\Users\\Public\\WARES\\RDPPRINT.BAT` on the 
TS machine. Then edit the file as described above.

.. rubric:: References

+  http://www.techrepublic.com/blog/window-on-windows/how-do-i-copy-shortcuts-to-the-all-users-folders-in-vista-or-windows-7/1857

----

Authentication entries
=============================

Keep a record of this information in a safe place.

Windows registration:
-----------------------------

::

   Installation License number: ______________________________
   Professional Upgrade number: ______________________________

Windows station information:
-----------------------------

::

   Workstation name: ______________________________
          Workgroup: ______________________________
     Windows domain: ______________________________

TS usernames and passwords
-----------------------------

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

AAD Server license
-----------------------------

::

   Registration username: ______________________________
          License number: ______________________________

Hamachi VPN
-----------------------------

::

    Hamachi IP: ______________________________
   Networkname: ______________________________
      Password: ______________________________

RDPPRINT.BAT information
-----------------------------

   +-----------+------------------+-------------------+---------------+--------+
   | login ID  | Workstation name | Hamachi VPN IP    | Printer share | Device |
   +===========+==================+===================+===============+========+
   | USER00    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER01    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER02    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER03    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER04    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER05    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER06    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER07    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER08    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | USER09    |                  |                   |               | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+
   | EXAMPLE   | DEVELOPER        | 25.50.50.50       | Laserjet      | LPT1   |
   +-----------+------------------+-------------------+---------------+--------+ 

.. note:: 
   It would be a good idea to ghost a drive image from this installation 
   once complete, so that recovery from an OS failure would be possible.