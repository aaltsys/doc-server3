#############################
 Command Utilities
#############################

Windows command utilities are run from the Start menu **Run ..** or 
**Search ..** dialogs. These utilities may require administrative privileges, 
that is, right-click and select "run as ..." to execute.


MSCONFIG.EXE
=============================

Possibly the tools tab in this utility is useful.

TASKMGR.EXE
=============================

Has a **shutdown** tab which permits remote users to control machines no 
matter what. 

CMD.EXE and COMMAND.EXE
=============================

Display the command line window by selecting :menuselection:`Start --> Run...` 
from the menu, then typing :command:`CMD <Enter>`. Following are selected 
commands which may be helpful in reviewing settings and diagnosing installation 
problems.

Networking
-----------------------------

 **ipconfig** reports or changes IP settings for a workstation:

 | ``ipconfig /all`` -- *report the current IP configuration*
 | ``ipconfig /release`` -- *clear the current IP configuration*
 | ``ipconfig /renew`` -- *obtain new IP settings through DHCP*
 | ``ipconfig /flushdns`` -- *clear cached dns entries*

 **ping** queries an IP address or DNS name and reports the result: 

 | ``ping 127.0.0.1`` -- *queries the network interface in the workstation itself* 
 | ``ping 192.168.2.241`` -- *queries the LAN interface eth1 in the AAltSys server*
 | ``ping 192.168.1.1 or ping 192.168.1.254`` -- *queries probable addresses 
   for the WAN gateway*
 | ``ping google.com`` -- *performs a DNS lookup on and queries a remote IP*
  
 **nslookup** queries a DNS name and returns its corresponding IP address:

 | ``nslookup google.com`` -- *queries DNS services, not actual IP addresses*

 **netsh** queries and diagnoses networking issues on a workstation:

 | ``netsh diag gui`` -- *displays networking diagnostics in a gui window*

 .. note:: Microsoft Professionals use additional networking diagnostic tools 
    which are not included with the OS. Search for download **dcdiag** or 
    **dnslint**. (Microsoft's attitude about diagnostics is encapsulated in 
    this quote: "DNSLint is a Microsoft Windows utility that helps you to 
    diagnose common DNS name resolution issues.")

File system management
-----------------------------

 | ``sfc /scannow`` -- *scan and repair protected system files*

 .. warning:: For experts only -- These utilities change ACLs for file and 
    folder ownership.

 | ``cacls *.* /E /R (username):F`` -- *adds full permissions to files*
 | ``cacls *.* /T /E /P (username):F`` -- *adds full permissions to all files 
   and special files*
 | ``cacls __filename__ /G (username):F`` -- grants full rights to file*
 | ``takeown /f __filename__`` -- change ownership (Unix chown)
 | ``takeown /f __directory__ /r`` -- change ownership of directory tree

System controls
-----------------------------

 | ``mmc`` -- *an alternative way to open system control panels*

Mac OS X Console Commands
===============================

The Mac OS-X command line window is displayed by opening 
:menuselection:`Applications --> Utilities --> Terminal.app`.
The following commands are helpful in reviewing settings and diagnosing 
installation problems.

.. Tip:: Mac OS-X commands work on Linux and Unix systems as well. 

ifconfig
-----------------------------

 This command reports or changes the IP settings for a Mac OS X workstation:

 | ``ifconfig`` -- *report the current IP configuration*
 | ``ifconfig en0`` -- *report the current IP configuration for the ethernet 
   adapter*
 | ``ifconfig en1`` -- *report the current IP configuration for the airport 
   adaptor in some models*

ping
-----------------------------

 This command executes a network query to an IP address and reports the result:

 | ``ping 127.0.0.1`` -- *queries the workstation network interface itself* 
 | ``ping 192.168.2.241`` -- *queries LAN interface eth1 in the AAltSys server* 
 | ``ping 192.168.1.1 or ping 192.168.1.254`` -- *queries likely WAN gateways*
 | ``ping google.com`` -- *performs a DNS lookup on the Internet and queries a 
   remote server*

chown / chmod
-----------------------------

 .. warning:: For experts only -- These utilities change file and folder 
    ownership and permissions.

 | ``chown -R (username) *`` -- *makes (username) the owner of all files, 
   folders, subdirectories, and sub files*
 | ``chmod -R 777 ./*`` -- *makes all files have read, write, and execute 
   permissions set for all users*