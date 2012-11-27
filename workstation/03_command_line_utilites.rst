#######################
 Command Line Utilities
#######################

Windows Command Line Utilities
==============================

The Windows command line window is displayed by selecting
:menuselection:`Start --> Run...` from the menu, then typing *CMD* **<Enter>**.
The following commands are helpful in reviewing settings and diagnosing
installation problems.

IPCONFIG
"""""""""

This command reports or changes the IP settings for a Windows workstation:

 | ``ipconfig /all`` -- *report the current IP configuration*
 | ``ipconfig /release`` -- *clear the current IP configuration*
 | ``ipconfig /renew`` -- *obtain new IP settings through DHCP*
  
PING
""""""""""

This command executes a network query to an IP address and reports the result:

 | ``ping 127.0.0.1`` -- *queries the network interface in the workstation itself* 
 | ``ping 192.168.2.241`` -- *queries the LAN interface eth1 in the AAltSys server*
 | ``ping 192.168.1.1 or ping 192.168.1.254`` -- *queries probable addresses for the WAN gateway*
 | ``ping google.com`` -- *performs a DNS lookup on the Internet and queries a remote server*
  
CACLS
""""""""""

 | ``cacls *.* /E /R (username):F`` -- *adds full permissions to files*
 | ``cacls *.* /T /E /P (username):F`` -- *adds full permissions to all files and special files*

 .. warning::
 	 For experts only -- This utility changes ACLs for file and folder ownership.

Mac OS X Command Line Utilities
===============================

The Mac OS-X command line window is displayed by opening :menuselection:`Applications --> Utilities --> Terminal.app`
The following commands are helpful in reviewing settings and diagnosing installation problems.

.. Tip::
	Mac OS-X commands will work on Linux and Unix as well. 

ifconfig
""""""""""

This command reports or changes the IP settings for a Mac OS X workstation:

 | ``ifconfig`` -- *report the current IP configuration*
 | ``ifconfig en0`` -- *report the current IP configuration for the ethernet adapter*
 | ``ifconfig en1`` -- *report the current IP configuration for the airport adaptor in some models*

ping
""""""""""

This command executes a network query to an IP address and reports the result:

 | ``ping 127.0.0.1`` -- *queries the network interface in the workstation itself* 
 | ``ping 192.168.2.241`` -- *queries the LAN interface eth1 in the AAltSys server*
 | ``ping 192.168.1.1 or ping 192.168.1.254`` -- *queries probable addresses for the WAN gateway*
 | ``ping google.com`` -- *performs a DNS lookup on the Internet and queries a remote server*

chown / chmod
""""""""""""""

 | ``chown -R (username) *`` -- *makes (username) the owner of all files, folders, subdirectories, and sub files.*
 | ``chmod -R 777 *`` -- *makes all files have read, write, and execute permissions set for all users*

 .. warning::
 	 For experts only -- These utilities change file and folder ownership and permissions.
