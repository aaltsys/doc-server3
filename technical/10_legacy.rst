#############################
Earlier Server Versions
#############################

AAltSys Server 10.07
=============================

This server series requires the following commands, usually from an ssh console 
session, to upgrade the server.

SSH Console Commands
-----------------------------

Add AAltSys and zentyal ppa::

   sudo add-apt-repository ppa:aaltsys/10.07
   sudo add-apt-repository ppa:zentyal/2.0

Fix admin1 group membership::

   usermod -G __USERS__ admin1

Update server packages::

   byobu
   sudo aptitude update
   sudo aptitude safe-upgrade
   ^D

Install packages::

   sudo aptitude install lftp mc
