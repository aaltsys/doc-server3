.. _netuse:

#############################
 DOS Applications and NET USE
#############################

DOS and some Windows applications rely on device mapping techniques to talk to 
network fileshares and other services. A mapping associates a Windows host and
device name with a local virtual hardware device specification using (I believe 
Novell's) ``NET USE`` commands.

While the ``NET USE`` command includes a method of remembering mappings, 
Windows has a corresponding habit of forgetting mappings at the most 
inopportune times. Consequently we recommend creating script files for the 
mappings which can be executed from desktop icons.

The following instructions are written in to work for both Windows XP and 
Windows 7. Testing was performed on Professional editions only.

Configure Workstations
=============================

.. note:: The configuration steps below will work for Windows XP and Windows 7 
   32-bit editions only. WARES cannot run natively on a 64-bit operating 
   system, and so the Windows virtual mode is required. In virtual mode, it is 
   not possible to call a desktop batch file with the ``%USERPROFILE%`` syntax 
   as described in the section on modifying `WARES.BAT for Windows 7`.

Setup a NETPRINT.BAT icon:
"""""""""""""""""""""""""""""

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

+ Right-Click on the desktop, choose :menuselection:`New --> Text document`.
+ Change the filename to `NETSHARE.BAT` and press :kbd:`<Enter>`.
+ Right-Click on `NETSHARE.BAT`, choose :menuselection:`Edit`.
+ Enter share mapping commands, for example::

    NET USE W: /DELETE
    NET USE S: /DELETE
    NET USE W: \\AAltSysServer\wares
    IF ERRORLEVEL 1 PAUSE
    NET USE S: \\AAltSysServer\shared
    IF ERRORLEVEL 1 PAUSE

+ Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and close.

WARES.BAT for Windows7:
"""""""""""""""""""""""""""""

+ Display a command window on the local windows workstation.
+ Type :kbd:`EDIT W:\WARES.BAT <Enter>`.
+ Press :kbd:`<Down>,<Enter>,<Up>` to insert a blank second line.
+ Type `CALL "%USERPROFILE%\DESKTOP\NETPRINT.BAT"`.
+ Press :kbd:`<Alt-F>,<S>,<Alt-F>,<X>` to save and exit the editor.
+ Type `EXIT` to close the command window.

..note::
  Fixing WARES.BAT is a global change. Perform this step exactly once, not once per workstation.

Copy WARES.pif to Desktop:
"""""""""""""""""""""""""""""

+ Copy ``W:\WARES.pif`` to the local desktop.
+ Right-click the icon, and choose :menuselection:`Properties`.
+ Click the :guilabel:`Program` tab.
+ At the :guilabel:`Cmd line:` prompt, specify a unique user identifier.
  (This entry should read, ``W:\WARES.BAT USERxx`` where ``xx`` is between 00 
  and 09.)
+ Click :guilabel:`Apply` and :guilabel:`OK`.
