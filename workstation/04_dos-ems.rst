.. _dosems:

#############################
DOS Programs and EMS
#############################

Some DOS programs, including WARES, use an EMS (Expanded Memory System) driver 
to access paged memory. Generally, EMS works on most computers until something 
disables it. This article is all about these somethings.

.. note:: The WARES for DOS program has a built-in test for working EMS. Menu 
   selection :menuselection:`Access --> Tourguide` will display either a list 
   of tours or a message to reconfigure CONFIG.SYS. Reconfiguration does not 
   work in Windows XP, but the test for EMS functioning is reliable. Otherwise, 
   Microsoft's OS does not in any way indicate when EMS is disabled.

Operating System EMS Problems
=============================

Problems in the Windows operating system or associated software cause most EMS 
issues. This section itemizes the common causes of these problems.

KB2724197 and EMS
-----------------------------

Microsoft security patch KB2724197 for Windows XP from 10/9/2012 is intended to 
prevent improper memory assignment in programs run by an authenticated local 
user (meaning you, of course). Generally this patch should be removed using the 
following directions:

#. From the :guilabel:`Start` menu, <right-click> :guilabel:`My Computer` and 
   choose :menuselection:`Properties`.
#. In the :guilabel:`System Properties` window, display tab 
   :guilabel:`Automatic Updates`.
#. Change settings from :guilabel:`Automatic` to 
   :guilabel:`Download Updates for me ... `, then click buttons :guilabel:`Apply` 
   and :guilabel:`OK`.
   
   .. Note:: Computers which are on an Active Directory domain cannot change 
      this setting. If the :guilabel:`Automatic` selection is grayed out, 
      contact your network administrator for assistance with this procedure.
      
#. From the :guilabel:`Start` menu, open :guilabel:`Control Panel`, then open
   :guilabel:`Add or Remove Programs`. 
#. Click the :guilabel:`Show Updates` checkbox and wait for the list to update.
#. Scroll to the bottom of the list, maybe just above `Windows XP Service Pack 3`.
#. Click on item :guilabel:`Security Update KB2724197` from 10/10/12, which 
   will expand the entry.
#. In the detailed display, click the :guilabel:`Remove` button, then click
   :guilabel:`Next` to perform the remove operation.
#. When the selection is removed, click :guilabel:`Finish` to complete and 
   restart Windows.

DOS programs such as WARES will work correctly when this security update is 
removed, but new Windows security updates will not be installed. Follow this 
next set of directions to re-enable automatic updates: 

#. Open menu selection :menuselection:`Start --> Microsoft Update` or 
   :menuselection:`Start --> Windows Update`. 
#. Click the :guilabel:`Custom` button.
#. On the list of :guilabel:`High Priority Updates`, find 
   :guilabel:`Security Update for Windows XP (KB2724197)`.
#. Uncheck the checkbox next to :guilabel:`KB2724197`.
#. Click the :guilabel:`plus` sign to expand the item display, and check the box 
   :guilabel:`Don't show this update again`.
#. Click :menuselection:`Install Updates` on the left menu to install other 
   updates, But choose to :guilabel:`Restart Later`.
#. Close :guilabel:`Microsoft Update`.
#. From the :guilabel:`Start` menu, <right-click> :guilabel:`My Computer` and 
   choose :menuselection:`Properties`.
#. In the :guilabel:`System Properties` window, display tab 
   :guilabel:`Automatic Updates`.
#. Change settings from :guilabel:`Download Updates for me ...` to 
   :guilabel:`Automatic`, then click buttons :guilabel:`Apply`, and :guilabel:`OK`.
#. If other updates were installed, restart Windows.

Using .lnk instead of .pif
-----------------------------

By default, Windows does not load EMS drivers in DOS sessions. Instead, DOS 
programs must be started from a :file:`.pif` file for EMS to be enabled. 
Sometimes this start file gets lost, or is replaced with a link or batch file. 
Windows XP supports using :file:`.pif` files, but it lacks a way to create 
these files to start with. 

Download `this WARES.pif file <_downloads/WARES.pif>` and modify it as required 
if your :file:`.pif` is missing. 

But how do you know if you are missing your :file:`.pif`? Good question, since 
Windows never shows the :file:`.pif` file extension. <Right-click> your start 
file and choose :guilabel:`Properties`. If the Properties window has eight 
folder tabs, and one of them is :guilabel:`Memory`, then you have a 
:file:`.pif` file.

EMS turned off in .pif
-----------------------------

<Right-click> your :file:`.pif` start file, choose :guilabel:`Properties`, and  
display the :guilabel:`Memory` tab. If the :guilabel:`Expanded (EMS) Memory` 
total is set to :option:`None`, change it to :option:`Auto`.

EMS blocked by virus scan
-----------------------------

Some virus scanning programs (Norton? McAfee?) may have settings which prevent 
the EMS driver from loading. I cannot offer any advice about this issue.

Windows Vista
-----------------------------

Microsoft removed support for EMS in Vista, but Windows 7 added EMS support 
back. If you are using Vista, get a better operating system, or else use 
:program:`EMS Magic`, described below.

Hardware Drivers and EMS
=============================

For new computers which cannot access EMS, the problem may be in hardware 
settings which can be changed in BIOS. 

BIOS, or firmware code, initializes the computer hardware before the operating 
system loads. BIOS hardware drivers are mapped into a reserved area of computer 
memory, called upper memory, between 640k and 1.0 MB. Microsoft's EMS driver 
requires a 64K page frame inside this same memory range. Where EMS is disabled 
due to hardware problems, sometimes system components can be disabled or 
replaced, freeing upper memory for EMS.

BIOS Settings
-----------------------------

BIOS settings to enable optional hardware component support should be disabled.
Some of these items might be:

* Legacy USB support
* Boot from Network
* Video BIOS Driver

Systemboard circuitry
-----------------------------

Some system board components may be disabled in the BIOS and replaced with 
add-in component boards. Possible targets for this approach are:

* Disable on-board network port (NIC), add in a network card or USB port
* Disable on-board video, add in a video card

.. _ems-magic:

Replacing Microsoft's EMS
=============================

Microsoft's implementation of EMS in Windows uses the Upper Memory area. For 
computers which are incompatible with this, an EMS replacement which uses 
main memory is available from `EMS Magic <http://www.emsmagic.com/>`_.
EMS Magic claims to work on Vista, and also to work on computers which have
the notorious KB2724197 patch applied. Therefore this program `may` enable EMS 
for DOS programs when nothing else works.

Other References
=============================

EMS is a notorious category of Microsoft issues. 
`This web page <http://www.columbia.edu/~em36/wpdos/emsxp.html>`_ supporting 
WordPerfect for DOS illustrates another response to the issues discussed above. 
