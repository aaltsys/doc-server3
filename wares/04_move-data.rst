.. _move-data:

#############################
Moving WARES Data
#############################

A feature of WARES is the ability to maintain separate datasets in attachable 
volumes. When WARES is used on stand-alone systems in separate buildings, each 
building will have its own dataset (or maybe, multiple sets). 

The difficulty with having multiple WARES installations is a lack of central 
control for management and for billing. The problem of decentralized software 
is addressed by installing WARES on a central server and using remote access to 
distribute the software to individual offices, as is described in article 
:ref:`aad-server`. This article addresses the remaining problem of 
consolidating multiple WARES program datasets on one central server.

Special considerations
=============================

When each WARES database at stand-alone WARES copies has a unique identifier 
for its dataset, the separate datasets can be copied directly to separate 
directories on the central WARES server. However, WARES will not work with 
separate volumes which all use volume name :file:`WARES.DATA`, and which contain 
identical underlying file names. 

Therefore moving WARES data from separate systems to a consolidated server 
always requires copying whole directories of data files, and may require 
creating new data directories (volumes) and moving individual account data into 
the new volumes.

Prepare WARES volumes
=============================

#. Start the WARES program from a workstation attached to the server, and login 
   using the supervisor access password.
#. At :menuselection:`Tools --> General --> Volume Create`, create a new volume 
   for each data set which will be moved to the server. The following table 
   shows example selections for creating these volumes:
  
   +------------------------+----------------+------------------+--------------+
   | Source Volume          | System Path    | Volume to create | Discard/Keep |
   +========================+================+==================+==============+
   | .\\UPDATE\\WARES\\DEMO | WARES\\BLDG_1  | WARES.BLDG_1     | Discard      |
   +------------------------+----------------+------------------+--------------+
   | .\\UPDATE\\WARES\\DEMO | WARES\\BLDG_2  | WARES.BLDG_2     | Discard      |
   +------------------------+----------------+------------------+--------------+
   | .\\UPDATE\\WARES\\DEMO | WARES\\BLDG_11 | WARES.BLDG_11    | Discard      |
   +------------------------+----------------+------------------+--------------+
   | .\\UPDATE\\WARES\\DEMO | WARES\\DEAD_1  | WARES.DEAD_1     | Discard      |
   +------------------------+----------------+------------------+--------------+
   | .\\UPDATE\\WARES\\DEMO | WARES\\DEAD_2  | WARES.DEAD_2     | Discard      |
   +------------------------+----------------+------------------+--------------+

.. note:: The :guilabel:`Source Volume` default value should start with just one 
   period. If it starts with two, then fix the default as follows:
   
   + Go to :menuselection:`Tools --> Define --> Controls`.
   + Press :kbd:`[F10], F, N` and choose to open file :file:`APP_CONTROLS`.
   + Press :kbd:`[Shift-F10]`, then select :file:`CREATE*DEFAULT`.
   + Edit the :guilabel:`Source Volume` and other entries as required.

.. note:: If desired, the DISPLAY list of WARES volumes may be edited at 
   :menuselection:`Tools --> Define --> Popups`. Enter :guilabel:`Filename` 
   :file:`APP_POPUPS` and :guilabel:`Popup Name` :file:`ACCESS`.

.. _copy-data:

Copy data onto server
=============================

Where multiple data sets will be combined on one system, initially copy data to 
**SHARED** drive :file:`S:` as described following.

#. At a stand-alone WARES station, copy the ATLAS directory to a USB drive.
#. Insert the USB drive into a workstation attached to the server.
#. Open the USB drive in a file Explorer window.
#. Locate the :file:`WARES` folder within the ATLAS (or ATLAS/AREV) directory.
#. Click the :file:`WARES` folder, and press :kbd:`<Ctrl-C>` to copy.
#. At :menuselection:`Start --> Computer --> Network Drives`, Double-Click the 
   :file:`S:` drive to open it.
#. Click in the blank area of the :file:`S:` window, and press :kbd:`<Ctrl-V>` 
   to paste.
#. Click on the pasted :file:`WARES` folder, and press :kbd:`F2` to rename it to 
   reflect its source. That is, rename :file:`WARES` to :file:`BLDG_2` if it 
   represents Building 2, and so forth.
  
.. note:: A note on names: Volume names may be longer, but the WARES program 
   requires that filesystem directory or folder names representing volumes be 
   no more than 8 characters and include only letters, digits, and underscore or 
   hyphen characters. This is why the instructions show name :kbd:`BLDG_2` 
   instead of the (invalid) directory name :kbd:`Building 2`.
  
Repeat these steps for each data volume to be added to the server.

Move data by volume
=============================

.. warning:: Do not use these instructions unless the source filenames to be 
   copied into a volume are distinct from names in all other wares volumes. 
   Generally this would be true either zero or one times per system.
  
#. At a workstation attached to the server, open a file Explorer widow.
#. Open drive :file:`W:`, then open the :file:`WARES` folder on drive 
   :file:`W:`.
#. Locate the data folder to be replaced, right-click the data folder, and 
   choose :menuselection:`Rename`.
#. Change the folder name to indicate that the folder should be deleted later 
   (much later).
#. Open drive :file:`S:`, then open the source folder on drive :file:`S:`.
#. Locate the data folder to be copied, right-click the folder, and choose
   :menuselection:`Rename`.
#. Rename the folder to match the old folder name from drive :file:`W:`.
#. Right-click the folder and choose copy.
#. Again, open drive :file:`W:`, then open the :file:`WARES` folder on drive 
   :file:`W:`.
#. Click in a blank space within drive :file:`W:`, and press :kbd:`<Ctrl-V>` to 
   paste the folder from drive :file:`S:`.
#. Close the file Explorer windows, and start WARES.
#. Inside WARES, press :kbd:`[F5]` to display a command window. Type commands 
   :command:`REBUILD.IMAGE ALL` and then :command:`OFF`. Then restart WARES.

Move data by account
=============================  

.. Note:: Before using this procedure, copy one or more data sets onto drive 
   :file:`S:` as :ref:`described previously <copy-data>`.
   
.. sidebar:: Adding a volume to the ACCESS popup.

   .. image:: _images/transfer1.png

There are two parts to moving data between volumes by account. In this first
section, a temporary volume on drive :file:`S:` is set as the source of the 
transfer.

#. Open WARES at the supervisor level on a workstation attached to the server.
#. Go to :menuselection:`Tools --> Define --> Popups`. Enter 
   :guilabel:`Filename` :file:`APP_POPUPS` and :guilabel:`Popup Name` 
   :file:`ACCESS`.
#. Add :guilabel:`Code` :kbd:`WARES.TRANSFER` and :guilabel:`Description`
   :kbd:`Drive S: data` at the bottom of the WARES data volumes list, then press
   :kbd:`<F9>` to save the change.
#. Go to :menuselection:`Tools --> Utilities --> Bundle`.
#. Press :kbd:`<Shift-F1>` to display the :guilabel:`SetVolume` window.
#. Enter :guilabel:`Volume Name` :kbd:`WARES.TRANSFER`. 
#. At :guilabel:`Data Type`, Press :kbd:`<F2>` and select 
   :guilabel:`Advanced Revelation (Linear Hash)`. 
#. Enter a :guilabel:`Data Location` path, comprised of drive, source directory,
   and data folder in the form :kbd:`S:\\{source}\\{folder}`. See illustration 
   below. 
#. Press :kbd:`<F9>` to save. 

   .. image:: _images/setvolume1.png
   
Once a source data volume has been named, the Move Data utility will transfer 
accounts between volumes.

#. Go to :menuselection:`Tools --> General --> Move data`, and enter :kbd:`Y` 
   to start the process.
#. At :guilabel:`Table Name`, press :kbd:`<F2>` and choose :kbd:`ACCOUNTS`.
#. Under :guilabel:`From: Source`, press :kbd:`<F2>` at :guilabel:`Volume` and
   select :kbd:`WARES.TRANSFER`, as setup in the first part of this section.
#. Press :kbd:`<F2>` at :guilabel:`Identifier` to select an account to move.
#. Under :guilabel:`To: Destination`, press :kbd:`<F2>` at :guilabel:`Volume`
   and select the destination data volume.
#. At :guilabel:`Identifier`, press :kbd:`<Enter>` to use the old identifer, or 
   enter a new account code.
#. Press :kbd:`<F9>` to start the data transfer. Expect an account transfer to 
   take at least several minutes.

Repeat the set of steps immediately above for each account to be transferred. If
accounts are being transferred from multiple databases, repeat the entirety of
this section for each database.

Once all accounts are transferred from all databases, the WARES.TRANSFER volume 
should be deleted from the WARES volume list.

#. Go to :menuselection:`Tools --> Define --> Popups`. 
   Enter :guilabel:`Filename` :file:`APP_POPUPS` and :guilabel:`Popup Name` 
   :file:`ACCESS`. 
#. Press the :kbd:`<Down-cursor>` to go to the :guilabel:`Code` entry line
   :kbd:`WARES.TRANSFER`.
#. Press :kbd:`<Ctrl-D>` to delete the line, and then :kbd:`<F9>` to save the
   ACCESS popup record.