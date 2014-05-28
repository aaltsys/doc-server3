.. _bios-x9scm-o:

#############################
SuperMicro MBD-X9SCM-O BIOS
#############################

First BIOS Boot
=============================

#. Boot the system, pressing :kbd:`<Del>` multiple times to enter the BIOS 
   setup. 
#. At :menuselection:`Exit --> Restore Defaults --> Load Optomized Defaults` 
   on the menu, press :kbd:`<Enter>` for :guilabel:`Yes`.
#. At :menuselection:`Advanced --> Boot Feature --> Power Button Function` 
   on the menu, press :kbd:`<Space>` to select :guilabel:`4 Seconds Override`. 
#. At :menuselection:`Advanced --> IDE/SATA Configuration`,

   #. At :menuselection:`SATA Mode`, press :kbd:`<Space>` to select 
      :guilabel:`RAID Mode`.
   #. At :menuselection: `PCH RAID Codebase`, press :kbd:`<Space>` to select 
      :guilabel:`Intel`.
   #. At :menuselection:`Serial ATA Port 0 --> Hot Plug`, press :kbd:`<Space>` 
      to select :guilabel:`Disabled` (should show first RAID drive).
   #. At :menuselection:`Serial ATA Port 0 --> Hot Plug`, press :kbd:`<Space>` 
      to select :guilabel:`Disabled` (should show second RAID drive).
   #. At :menuselection:`Serial ATA Port 0 --> Hot Plug`, press :kbd:`<Space>` 
      to select :guilabel:`Disabled` (should show DVD-RW drive).

#. At :menuselection:`Exit --> Save Changes and Reset`, press :kbd:`<Enter>`
   to save changes, and answer the question 
   :guilabel:`Save configuration and reset?` with :kbd:`Yes`.

Second BIOS Boot
=============================

#. Press :kbd:`<Ctrl-I>` multiple times to enter the :guilabel:`Intel RAID` 
   utility.
#. Press :kbd:`3` for :guilabel:`Reset Disks to non-RAID`. Press :kbd:`<Space>` 
   to select disks, then press :kbd:`<Enter>` to finish the operation.
#. Press :kbd:`1` for :guilabel:`Create RAID volume`.

   #. At :guilabel:`Name:`, enter :kbd:`aaltsys <Enter>`.
   #. At :guilabel:`RAID Level:`, press :kbd:`<Down>` to display 
      :guilabel:`RAID1(Mirror)`.
   #. At :guilabel:`Capacity`, press :kbd:`<Enter>` to select the entire drive. 
   #. Respond to the :guilabel:`Create Volume` prompt with :kbd:`<Enter>`, and 
      confirm the :guilabel:`Are you sure ...?` question with :kbd:`Y`.

#. Press :kbd:`6` to :guilabel:`Exit` the RAID utility, and confirm the 
   :guilabel:`Are you sure ...?` question with :kbd:`Y`.

Third BIOS Boot
=============================

#. Boot the system, pressing :kbd:`<Del>` multiple times to enter the BIOS 
   setup. 
#. At :menuselection:`Advanced --> IDE/SATA Configuration --> SATA Mode`, press 
   :kbd:`<Space>` to select :guilabel:`AHCI Mode`.
#. At :menuselection:`Exit --> Save Changes and Reset`, press :kbd:`<Enter>`
   to save changes, and answer the question 
   :guilabel:`Save configuration and reset?` with :kbd:`Yes`.

Fourth BIOS Boot
=============================

#. Boot the system, pressing :kbd:`<Del>` multiple times to enter the BIOS 
   setup. 
#. At :menuselection:`Boot --> Boot Option Priorities --> Boot Option #1`, 
   press :kbd:`<Enter>` and then select :guilabel:`P2: HL-DT-ST DVDRAM ...`. 
#. At :menuselection:`Boot Option #2`, select :guilabel:`P0: WDC WD5000 ...`.
#. At :menuselection:`Exit --> Save Changes and Reset`, press :kbd:`<Enter>`
   to save changes, and answer the question 
   :guilabel:`Save configuration and reset?` with :kbd:`Yes`. 

The system will now boot from the DVD drive, and install an OS on the RAID 
drive set. 

----------

`RAID installation documentation <http://www.supermicro.com/manuals/other/HostRAID_ICH7R_ICH9R_ICH10R.pdf>`_