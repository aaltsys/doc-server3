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
  :kbd:`SYSPROG`, password :kbd:`_____________`.
+ In the :guilabel:`Commands` window, enter :command:`RUNMENU LANPACK`.
+ Choose :menuselection:`Lanpack --> Network Type` from the menu.
+ Press :kbd:`F2` for options, and switch to :guilabel:`Microsoft Lan Manager`.
+ Press :kbd:`F9` to save the setting,  (A message will display saying revboot 
  is rebuilt.)
+ Choose :menuselection:`Exit` to exit the application.

Then copy the entire ATLAS directory from the old server to a flash drive or to 
a workstation C:\\ drive. Call if you have questions about what to copy.

Install an AAltSys Server
=============================

Install the AAltSys Server using directions from :ref:`<install:index>. Add 
to those directions the following specific instructions.

Configure the AAltSys Server
-----------------------------

+ In :menuselection:`File Sharing`, define the **wares** share as a directory 
  **arev** under Zentyal.
+ Set "read/write" Access Control permissions on this share for group "Users"
  (or group "fsusers").
+ At a workstation, test to see that this share is visible.
+ Map this share to drive letter :file:`W:`.
+ Define the **shared** share as a directory **public** under Zentyal.
+ Set "read/write" Access Control permissions on this share for group "fsusers"
  (or group "Users").
+ See that the share is visible, and map the share to drive letter :file:`S:\\`.

Setup WARES on the Server
=============================

Copy WARES to the Server
-----------------------------

+ At a workstation, open the saved :file:`ATLAS` folder. If there is an 
  :file:`AREV` folder within :file:`ATLAS`, open that folder.
+ Press :kbd:`<Ctrl-A> <Ctrl-C>` to select all files within the open folder.  
+ Open the drive :file:`W:\\`, and click in the window.
+ Press :kbd:`Ctrl-V` to paste the contents of the folder into drive 
  :file:`W:\\`. 
+ Create folders :file:`W:\\exchange` and :file:`W:\\export`, if missing.
+ Copy the contents of :file:`S:\\arev` to :file:`W\\` (usually folder 
  :file:`patches`). 
+ If :file:`ATLAS` contained an :file:`AREV` folder, copy any other folders in 
  :file:`ATLAS` but not included in :file:`AREV`, such as :file:`CONNECT`, to 
  :file:`W:\\`.

Configure WARES on the Server
-----------------------------

+ Copy :file:`W:\WARES.pif` to a workstation desktop.
+ Double-click the :file:`WARES.pif` icon, and log into WARES at the supervisor 
  level.
+ Select :menuselection:`Tools --> Utilities --> Bundle` from the menu.
+ Press :kbd:`Shift-F1` to display the :guilabel:`SetVolume` window.
+ Enter volume name :file:`PATCHES`.
+ If the data location is :file:`..\PATCHES`, change it to :file:`.\PATCHES` 
  (that is, remove one period).
+ Press :kbd:`F9` to save changes and :kbd:`Esc` to return to Bundle Records.
+ Press :kbd:`Enter` to accept the default volume name, :file:`PATCHES`.
+ At :guilabel:`Filename`, press :kbd:`F2` and select :guilabel:`OTHER`.
+ Press :kbd:`Alt-T` to move to :guilabel:`Actions`, press :kbd:`F2`, and 
  choose :guilabel:`RESTORE`.
+ Press :kbd:`F9` to restore the WARES update.

.. note:: Install additional PATCHES update bundles using the same procedure, 
   if desired.

Configure Workstations
=============================

Prepare each workstation to run WARES using the directions in the 
:ref:`Workstation manual section <workstation:index>`. Batch program files may 
be added to workstation desktops to map printers and network drives, as 
explained in article :ref:`<workstation:netuse>`.