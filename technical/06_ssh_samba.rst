#####################################
 Using SSH, PuTTY, and Samba Services 
#####################################

Accessing Servers over SSH
=====================================

Redirecting SSH to PuTTY
"""""""""""""""""""""""""""""""""""""

PuTTY is an open-source cross-platform client for secure connections with remote hosts. 
It is available on Windows, Linux, and Mac, and it is the preferred client on Windows.
PuTTY adds power to interactive sessions. For example, a user can add a port forwarding 
rule within a running terminal session.

For a KDE desktop system derived from Debian, the following command will redirect SSH at the terminal to PuTTY
(courtesy of VonGrippen, AKA Michael Cochran)::
 
	sudo bash < <(wget https://raw.github.com/gist/1030236/putty-kde.sh -O-)

This program works magic which is best explained through an example, as follows.

Example PuTTY Session:
"""""""""""""""""""""""""""""""""""""

In this example, an administrator wishes to connect to a remote Windows session running as a 
virtual machine on a Linux server. The Linux server is accessed at the domain name 
``https://remoteserver.support.aaltsys.com``. Both the Windows session and the Linux server 
authenticate ``username`` and ``password`` for logins.

First display a terminal window on the local machine, then ssh to the remote server::

	xdg-open ssh://username@remoteserver.support.aaltsys.com

Now explore the remote environment to identify Windows RDP servers. Recommended commands are::

	smbclient -L NETBIOSNAME
	smbtree

These commands identify the virtualized windows session as ``XPUNLIMITED``. Now find the IP for
this machine using either of the commands::

	net lookup XPUNLIMITED
	nmblookup XPUNLIMITED

The remote Windows terminal server **XPUNLIMITED** uses IP **192.168.2.243** in its local network.
Display the PuTTY menu with <Ctrl-RightClick>, and choose :menuselection:`Change Settings...`.
Then select Category: :menuselection:`Connection > SSH > Tunnels` and enter::

	Source port -- 3389
	Destination -- 192.168.2.243:3389
	Click -- Add
	Click -- Apply

Finally, open the KRDC Remote Desktop client on the KDE Desktop, and connect to: :guilabel:`rdp` :kbd:``localhost``.
A remote Windows RDP session will display as if it were local, being redirected to you over SSH.
