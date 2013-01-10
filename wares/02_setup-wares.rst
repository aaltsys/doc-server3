#############################
 Move WARES to AAltSys Server
#############################

This basic guide describes moving **WARES** from a single user computer
or other shared drive onto an AAltSys Server. This guide is appropriate when 
the **WARES** copy is stored within an **ATLAS** folder. When finished, 
**WARES** will be accessed from a server share mounted as drive **W:\\** at 
each workstation.

.. note:: This guide assumes that WARES patches and support files have been 
   added to the **Shared** share or drive **S:\\**. Make sure these files are 
   present beforehand.

Prep WARES on the old server
=============================

.. warning:: **WARES** must be prepped on its original server if it is 
   currently using a proprietary network driver.

+ From a workstation, log into **WARES** using the supervisor level password.
+ Press :kbd:`F2` to see all menus, choose :menuselection:`STARTUP`.
+ Select :menuselection:`Application --> Open`, and enter the account 
  ``SYSPROG``, password ``_____________``.
+ In the :guilabel:`Commands` window, enter ``RUNMENU LANPACK``.
+ Choose :menuselection:`Lanpack --> Network Type` from the menu.
+ Press :kbd:`F2` for options, and switch to **Microsoft Lan Manager**.
+ Press :kbd:`F9` to save the setting,  (A message will display saying revboot 
  is rebuilt.)
+ Choose :menuselection:`Exit` to exit the application.

Then copy the entire ATLAS directory from the old server to a flash drive or to 
a workstation C:\\ drive. Call if you have questions about what to copy.

Install an AAltSys Server
=============================

Install the AAltSys Server using directions from http://servers.aaltsys.info. Add 
to those directions the following specific instructions.

Configure the AAltSys Server:
"""""""""""""""""""""""""""""

+ In :menuselection:`File Sharing`, define the **wares** share as a directory 
  **arev** under Zentyal.
+ Set "read/write" Access Control permissions on this share for group "Users"
  (or group "fsusers").
+ At a workstation, test to see that this share is visible.
+ Map this share to drive letter **W:**.
+ Define the **shared** share as a directory **public** under Zentyal.
+ Set "read/write" Access Control permissions on this share for group "Users"
  (or group "fsusers").
+ See that the share is visible, and map the share to drive letter **S:\\**.

Setup WARES on the Server
=============================

Copy WARES to the Server:
"""""""""""""""""""""""""""""

+ At a workstation, open the saved **ATLAS** folder. If there is an **AREV** 
  folder within **ATLAS**, open that folder.
+ Press :kbd:`<Ctrl-A> <Ctrl-C>` to select all files within the open folder.  
+ Open the drive **W:\\**, and click in the window.
+ Press :kbd:`Ctrl-V` to paste the contents of the folder into drive **W:\\**. 
+ Create folders **W:\\exchange** and **W:\\export**, if missing.
+ Copy the contents of **S:\\arev** to **W:\\** (usually folder **patches**). 
+ If **ATLAS** contained an **AREV** folder, copy any other folders in 
  **ATLAS** but not included in **AREV**, such as **CONNECT**, to **W:\\**.

Configure WARES on the Server:
""""""""""""""""""""""""""""""""""

+ Copy **W:\WARES.pif** to a workstation desktop.
+ Double-click the **WARES.pif** icon, and log into WARES at the supervisor 
  level.
+ Select :menuselection:`Tools/Utilities/Bundle` from the menu.
+ Press :kbd:`Shift-F1` to display the :guilabel:`SetVolume` window.
+ Enter volume name ``PATCHES``.
+ If the data location is ``..\PATCHES``, change it to ``.\PATCHES`` (that is, 
  remove one period).
+ Press :kbd:`F9` to save changes and :kbd:`Esc` to return to Bundle Records.
+ Press :kbd:`Enter` to accept the default volume name, ``PATCHES``.
+ At :guilabel:`Filename`, press :kbd:`F2` and select :guilabel:`OTHER`.
+ Press :kbd:`Alt-T` to move to :guilabel:`Actions`, press :kbd:`F2`, and 
  choose :guilabel:`RESTORE`.
+ Press :kbd:`F9` to restore the WARES update.

.. note:: Install additional PATCHES update bundles using the same procedure, 
   if desired.

Configure Workstations
=============================

.. note:: The configuration steps below will work for Windows XP and Windows 7 
   32-bit editions only. WARES cannot run natively on a 64-bit operating 
   system, and so the Windows virtual mode is required. In virtual mode, it is 
   not possible to call a desktop batch file with the ``%USERPROFILE%`` syntax 
   as described in the section on modifying `WARES.BAT for Windows 7`.

Setup a NETPRINT.BAT icon:
"""""""""""""""""""""""""""""

Here is a link to download :download:`NETPRINT.BAT <_downloads/NETPRINT.BAT>`.

+ Right-Click on the desktop, choose :menuselection:`New --> Text document`. 
+ Change the filename to `NETPRINT.BAT` and press :kbd:`<Enter>`.
+ Right-Click on `NETPRINT.BAT`, choose :menuselection:`Edit`.
+ Enter printer mapping commands, for example::

    NET USE LPT1 /DELETE
    NET USE LPT1 \\127.0.0.1\sharename
    IF ERRORLEVEL 1 PAUSE

+ Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and close.

Setup a NETSHARE.BAT icon:
"""""""""""""""""""""""""""""

Here is a link to download :download:`NETSHARE.BAT <_downloads/NETSHARE.BAT>`.

+ Right-Click on the desktop, choose :menuselection:`New --> Text document`.
+ Change the filename to `NETSHARE.BAT` and press :kbd:`<Enter>`.
+ Right-Click on `NETSHARE.BAT`, choose :menuselection:`Edit`.
+ Enter share mapping commands, for example::

    NET USE W: /DELETE
    NET USE S: /DELETE
    rem NET USE W: \\192.168.2.241\wares
    NET USE W: \\AAltSysServer\wares
    IF ERRORLEVEL 1 PAUSE
    rem NET USE S: \\192.168.2.241\shared
    NET USE S: \\AAltSysServer\shared
    IF ERRORLEVEL 1 PAUSE

+ Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and close.

WARES.BAT for Windows7:
"""""""""""""""""""""""""""""

Here is a link to download :download:`WARES.BAT <_downloads/WARES.BAT>`. 

+ Display a command window on the local windows workstation.
+ Type :kbd:`EDIT W:\WARES.BAT <Enter>`.
+ Press :kbd:`<Down>,<Enter>,<Up>` to insert a blank second line.
+ Type `CALL "%USERPROFILE%\DESKTOP\NETPRINT.BAT"`.
+ Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and exit the editor.
+ Type `EXIT` to close the command window.

.. note:: Fixing WARES.BAT is a global change. Perform this step exactly once, 
   not once per workstation.

Copy WARES.pif to Desktop:
"""""""""""""""""""""""""""""

Here is a link to download :download:`WARES.pif <_downloads/WARES.pif>`.

+ Copy ``W:\WARES.pif`` to the local desktop.
+ Right-click the icon, and choose :menuselection:`Properties`.
+ Click the :guilabel:`Program` tab.
+ At the :guilabel:`Cmd line:` prompt, specify a unique user identifier.
  (This entry should read, ``W:\WARES.BAT USERxx`` where ``xx`` is between 00 
  and 09.)
+ Click :guilabel:`Apply` and :guilabel:`OK`.
