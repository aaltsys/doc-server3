.. _netuse:

#############################
 DOS Programs and NET USE
#############################

DOS and some Windows applications rely on device mapping techniques to talk to 
network fileshares and other services. A mapping associates a Windows host and
device name with a local virtual hardware device specification using (I believe 
Novell's) :command:`NET USE` commands.

While the :command:`NET USE` command includes a method of remembering mappings, 
Windows has a corresponding habit of forgetting mappings at inopportune times. 
Consequently script files should be created to execute mappings from desktop 
icons.

The following instructions are written in to work for both Windows XP and 
Windows 7. Testing was performed on Professional editions only.

.. _downloads:

Download links
=============================

Batch programs mentioned in this article may be downloaded from the following 
links:

+ Download :download:`NETPRINT.BAT <_downloads/NETPRINT.BAT>`.
+ Download :download:`NETSHARE.BAT <_downloads/NETSHARE.BAT>`.
+ Download :download:`WARES.BAT <_downloads/WARES.BAT>`. 
+ Download :download:`WARES.pif <_downloads/WARES.pif>`.

Configure 32-bit Windows
=============================

.. note:: The configuration steps below will work for Windows XP and Windows 7 
   32-bit editions only. WARES cannot run natively on a 64-bit operating 
   system, and so the Windows virtual mode is required. In virtual mode, it is 
   not possible to call a desktop batch file with the ``%USERPROFILE%`` syntax 
   as described in the section on modifying `WARES.BAT for Windows 7`.

Setup a NETPRINT.BAT icon:
-----------------------------

#. Right-Click on the desktop, choose :menuselection:`New --> Text document`. 
#. Change the filename to `NETPRINT.BAT` and press :kbd:`<Enter>`.
#. Right-Click on `NETPRINT.BAT`, choose :menuselection:`Edit`.
#. Enter printer mapping commands, for example::

     NET USE LPT1 /DELETE
     NET USE LPT1 \\127.0.0.1\sharename
     IF %ERRORLEVEL% NEQ 0 PAUSE

#. Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and close.

Setup a NETSHARE.BAT icon:
-----------------------------

#. Right-Click on the desktop, choose :menuselection:`New --> Text document`.
#. Change the filename to :file:`NETSHARE.BAT` and press :kbd:`<Enter>`.
#. Right-Click on :file:`NETSHARE.BAT`, choose :menuselection:`Edit`.
#. Enter share mapping commands, for example::

     NET USE W: /DELETE
     NET USE S: /DELETE
     NET USE W: \\AAltSysServer\wares
     IF %ERRORLEVEL% NEQ 0 PAUSE
     NET USE S: \\AAltSysServer\shared
     IF %ERRORLEVEL% NEQ 0 PAUSE

#. Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and close.

WARES.BAT for Windows7:
-----------------------------

#. Display a command window on the local windows workstation.
#. Type :kbd:`EDIT W:\\WARES.BAT`, and press :kbd:`<Enter>`.
#. Press :kbd:`<Down>,<Enter>,<Up>` to insert a blank second line.
#. Type :command:`CALL "%USERPROFILE%\\DESKTOP\\NETPRINT.BAT"`.
#. Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and exit the editor.
#. Type :kbd:`EXIT` to close the command window.

.. note:: Fixing :file:`WARES.BAT` is a global change. Perform this step 
   exactly once, not once per workstation.

Copy WARES.pif to Desktop:
-----------------------------

#. Copy :file:`W:\WARES.pif` to the local desktop.
#. Right-click the icon, and choose :menuselection:`Properties`.
#. Click the :guilabel:`Program` tab.
#. At the :guilabel:`Cmd line:` prompt, specify a unique user identifier.
   (This entry should read, :command:`W:\WARES.BAT USERxx` where ``xx`` is 
   between 00 and 09.)
#. Click :button:`Apply` and :button:`OK`.

64-bit Windows Virtual Mode
=============================

Programs running in Windows Virtual Mode cannot access the local user's home 
folder through the ``%USERPROFILE%`` command syntax. Also, Windows has a nasty 
habit of refusing to execute batch commands which exist in the user's home 
folder when the active directory of the command is on another device. These 
issues can be addressed through the following two-part workarounds, which can 
be applied to all versions of Windows.

Copy Batch Programs to C:\\
-----------------------------

#. Open :menuselection:`Start --> (My) Computer` on the desktop. 
#. Click on :file:`Local Disk (C:\\)` to display the files and folders there.
#. Make sure the :guilabel:`Address` bar shows :file:`C:\\`.
#. Drag :file:`NETSHARE.BAT` and :file:`NETPRINT.BAT` from the desktop to 
   an empty area of drive :file:`C:\\`.
#. <Right-click> on :file:`NETSHARE.BAT`, choose :menuselection:`Create Shortcut` 
   from the menu.
#. <Right-click> on :file:`NETPRINT.BAT`, choose :menuselection:`Create Shortcut` 
   from the menu.
#. Drag the two new shortcut files from :file:`C:\\` back to the desktop.
#. Close the :guilabel:`Computer` window.
#. On the desktop, <Right-click> :file:`Shortcut to NETSHARE.BAT` and choose
   menu item :menuselection:`Rename`. Change the name to :file:`NETSHARE.BAT`. 
#. On the desktop, <Right-click> :file:`Shortcut to NETPRINT.BAT` and choose
   menu item :menuselection:`Rename`. Change the name to :file:`NETPRINT.BAT`. 

Call Batch Programs on C:\\
-----------------------------

Windows may refuse to execute :program:`%USERPROFILE%\\DESKTOP\\NETPRINT.BAT`, 
particularly if the program is called from Virtual Mode. In that case, relocate
the program to drive :file:`C:\\` as described previously. Then call it from 
there, as follows:

#. Display a command window on the local windows workstation.
#. Type :kbd:`EDIT W:\\WARES.BAT`, and press :kbd:`<Enter>`.
#. Press :kbd:`<Down>,<Enter>,<Up>` to insert a blank second line.
#. Type in the following series of commands::

     @ECHO OFF
     IF NOT EXIST "%USERPROFILE%\Desktop\NETPRINT.BAT" GOTO DRIVE_C
     CALL "%USERPROFILE%\Desktop\NETPRINT.BAT"
     GOTO ENDPRINT
     :DRIVE_C
     C:
     IF EXIST C:\NETPRINT.BAT CALL C:\NETPRINT.BAT
     :ENDPRINT
     W:

#. Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and exit the editor.
#. Type :kbd:`EXIT` to close the command window.
