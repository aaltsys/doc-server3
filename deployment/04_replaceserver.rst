.. _replaceserver:

#############################
Replacing a Current Server
#############################

Backup the Old Server
=============================

Zentyal does not provide a program option or document a command for performing a 
demand backup. Backup all user data along with the server configuration at menu 
selection :menuselection:`CORE --> System --> Backup`, by setting a new time for 
a full backup to happen starting on the next hour. [#]_

Install the New Server
=============================

.. note::
   Instructions require using a Command Line Interface (CLI), which is accessed 
   by one of the following:
   
   #. :program:`ssh`: From a workstation running either Linux or Apple OS-X, 
      open a command line and start a terminal session on the server with the 
      command::
       
         ssh admin1@192.168.2.241
   
   #. :program:`console`: Connect keyboard, mouse, and video monitor to the 
      server. Login on the console and open a terminal session there.

Use the :ref:`connectserver` documentation to connect and manage the new server.

Connect old backup drive
-----------------------------

If the new server uses a new backup drive, disconnect the new backup drive and 
connect the backup drive from the old server. Open a command line as described 
in the note above, then download shell script :program:`backupdrive.sh` and run 
the script with the commands::

   wget http://servers.aaltsys.info/resources/_downloads/backupdrive.sh -P ~/
   sudo ~/backupdrive.sh

Restore configuration, data
-----------------------------
   
In a web browser, login to Zentyal server management at https://192.168.2.241. 
Select :menuselection:`Core --> System --> Backup --> Services Restore` from the 
menu to restore the system configuration, then use 
:menuselection:`Restore Files` to restore backed up data.

Reconnect new backup drive
-----------------------------

To reconnect a new backup drive, wait a minute after activity finishes, then 
disconnect the old drive used for data transfer. Connect the new drive, and 
reconfigure it with the terminal command::

   sudo ~/backupdrive.sh

----------

.. rubric: Footnotes

.. [#] `Zentyal backup procedures documentation <http://doc.zentyal.org/en/backup.html>`_.

 
 
 
