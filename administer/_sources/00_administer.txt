##############################
AAltSys Server Administration
##############################

The AAltSys Server is designed to be administered from a web browser. Separate
management programs are installed covering differing aspects of Linux server 
operation. In addition, direct control of the server at the command line is 
performed with ssh. Server management programs are accessed from the web browser 
at any workstation on the local network, using the local management URLs listed 
below. For registered servers, remote administrative workstations can address 
servers on the management VPN using the remote domain names shown.

+---------+---------------------------------------------+----------------------------------------+
| Program | Local management URL                        | Remote VPN management URL              |
+=========+=============================================+========================================+
| VMware  |https://AAltSysServer.local.aaltsys.net:8333 |(registration).servers.aaltsys.net:8333 |
+---------+---------------------------------------------+----------------------------------------+
| Convert |http://AAltSysServer.local.aaltsys.net:8081  |(registration).servers.aaltsys.net:8081 |
+---------+---------------------------------------------+----------------------------------------+
| Zimbra  |https://AAltSysServer.local.aaltsys.net:7071 |(registration).servers.aaltsys.net:7071 |
+---------+---------------------------------------------+----------------------------------------+
| eBox    |https://AAltSysServer.local.aaltsys.net:447  |(registration).servers.aaltsys.net:447  |
+---------+---------------------------------------------+----------------------------------------+
| Zentyal |https://AAltSysServer.local.aaltsys.net      |(registration).servers.aaltsys.net:443  |
+---------+---------------------------------------------+----------------------------------------+
| Webmin  |https://AAltSysServer.local.aaltsys.net:10000|(registration).servers.aaltsys.net:10000|
+---------+---------------------------------------------+----------------------------------------+
| ssh     |ssh://AAltSysServer.local.aaltsys.net        |ssh://(registration).servers.aaltsys.net|
+---------+---------------------------------------------+----------------------------------------+

Command Line Access
====================

Network access to command line functions is provided using secure shell (ssh).
The behavior of ssh from a browser or command line depends on features of the
desktop operating system. Provided the desktop can use ssh, any of the 
following Linux commands might provide CLI access to an AAltSys Server::

   ssh -l (administrator) 192.168.2.241
   ssh -l (administrator) aaltsysserver
   ssh -l (administrator) (registration).servers.aaltsys.net
   gnome-terminal -x ssh -l (administrator) (registration).servers.aaltsys.net

Restarting Zentyal
""""""""""""""""""""""""

Due to the chicken-or-egg nature of the task, Zentyal does not include a 
facility for restarting or reloading server management through the management 
interface. Instead, this procedure can be performed from a command line login. 
Either use the server console terminal window, or at a workstation, open a 
server ssh session with the terminal command::

   >$ ssh -l (administrator) aaltsysserver

Run the following command line statements::

   >$ sudo su -
   >$ byobu
   >$ stop ebox
   >$ start ebox
   >$ exit
   >$ exit
   >$ exit

Zentyal Server Management
==========================

The principal functions of a network file server are easily administered using
Zentyal. These functions are divided into the following areas:

+  Infrastructure services such as DNS, NTP, and DHCP;
+  Network services including firewall, gateway, and Quality of Service;
+  Threat management through proxy, VPN, Intrusion detection, and mail filtering;
+  Office functions: file and printer sharing, user directory and authentication;
+  Optional groupware and collaboration software such as email and calendars;
+  Maintenance operations like monitoring, backup, and support.

Convert Virtualization
=======================

The AAltSys Server offers KVM virtualization, and the Convert web management 
console provides a graphical interface for this feature. Through virtualization, 
a single powerful server platform can behave as if it were multiple hardware 
machines and operating systems. Some capabilities of virtual machines include:

+  Serving multiuser Linux remote desktop sessions
+  Providing local bootable terminal desktop sessions
+  Adding shared applications running in another OS such as Windows 7
+  Adding specialized services such as MS SQLServer
+  Running a web server host

Virtualization is important because it allows a server installed today to run 
new features and operating systems developed in the future, without having to 
repurchase server or network technology to do it. It is like getting (virtually) 
a new car whenever you want, without losing the depreciation cost of your used 
vehicle.

Webmin Advanced Administration
===============================

Webmin is an advanced administration package which can simplify remote server
management for the Linux expert. Webin services are not described further in 
this guide, since if you are an expert, you probably know how to use Webmin 
already, and if you are not an expert, you should not be using Webmin. 

Using Webmin with Zentyal
""""""""""""""""""""""""""

Using Webmin is tricky in combination with Zentyal. Webmin directly modifies the
standard Linux configuration files in :file:`/etc`, while Zentyal makes 
configuration changes by overwriting these files with its own private copy of 
configuration data. In general, these two approaches to server administration 
are incompatible and attempts to combine them will likely result in server 
failure.

.. Warning::
   Zentyal will override Webmin if the two programs are used to administer the 
   same service. Do not use Webmin on any service which is under Zentyal control 
   without first disabling that aspect of Zentyal. (Do not use Webmin at all if 
   you are not adept at Linux administration.)
