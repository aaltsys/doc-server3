.. _printing:

#############################
Printing With Zentyal
#############################

HPLIP
=============================

Your printer may require an updated version of HPLIP. to check the installed 
version, use the console command::

   dpkg -l hplip

Updating the Printer List
-----------------------------
   
Your list of printers in may be out of date, and so current models may not 
appear. Possibly HPLIP may not be installed on the system. In any case, HPLIP 
is available from a Launchpad repository, and it can be installed or updated 
for your operating system version with the commands::

   sudo apt-add-repository ppa:hplip-isv/ppa
   sudo apt-get update
   sudo apt-get install hplip

Latest HPLIP Version
-----------------------------

If the repository version of HPLIP does not support your printer, then you 
can install the absolute latest version of HPLIP as a download from::

   http://hplipopensource.com/hplip-web/install/install/index.html

+  On this webpage, right-click the :guilabel:`download >` button, and choose
   :menuselection:`Copy link address`. 
+  Open a command prompt, and type :kbd:`wget -O hplip.run <space><ctrl-v>` 
   Your resulting command, except for version, should look like the following:: 

      wget -O hplip.run http://prdownloads.sourceforge.net/hplip/hplip-3.13.2.run

+  Press :kbd:`<Enter>` to execute the download. 
+  Compile and make this version of hplip with the command::

      sh hplip.run

+  Enter your password when asked, and answer other prompts as appropriate.
+  Press :kbd:`q` to quit when you see the section titled::

      RESTART OR RE-PLUG IS REQUIRED
      ------------------------------
   
   Then logout, and login to the server again.   
+  Now the :command:`hp-makeuri` command might return your printer URI string.

.. note:: After a manual install, the command :command:`dpkg -l hplip` may not 
   report the actual installed version of HPLIP.

HP Printer Commands
=============================

HPLIP includes toolkit commands for managing HP printers on Unix systems. 
Run these commands from the command prompt of the server, either at the 
console, or over :command:`ssh`.

To look for usb printers or network printers in the local network zone:: 

   hp-probe

To upgrade the HPLIP software::

   hp-upgrade
   
To setup a printer from the command line (not using CUPS, unfortunately)::

   hp-setup -i
   
To find a setup string URI to use in CUPS::
   
   hp-makeuri {printer_IP_address}

For a list of HP commands, type :command:`hp-` at the command prompt, then 
press :kbd:`<tab><tab>`.
   
CUPS
=============================

We recommend using network-connected printers, and setting up the printers 
with print queues in the server. Server print queues are managed with CUPS.

Access CUPS (Common Unix Printing System) from one of the following URLs:

+--------------------------------------+-------------------------------------+
| at the server console:               | ``https://localhost:631``           |
+--------------------------------------+-------------------------------------+
| from an attached workstation:        | ``https://192.168.2.241:631``       |
+--------------------------------------+-------------------------------------+
| if you know your server's hostname:  | ``https://{serverhostname}:631``    |
+--------------------------------------+-------------------------------------+

In Cups, add a printer from the :menuselection:`Administration --> Add Printer` 
menu and button selections. For network printer queues, generate the URI of the 
printer using the :command:`hp-makeuri {printer_IP_address}` command.
