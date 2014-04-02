#############################
 Remote Secure Shell Sessions
#############################

.. Warning::
   This article includes proprietary information about AAltSys logins. Please 
   generalize this material before release::
   
      Identify username _____________________________________,
      registration __________________________________________,
      LTSP server IP ________________________________________.

Command line usage
=============================

Basic::

   ssh -l [username] [registration].servers.aaltsys.net

NX Port forwarding of LTSP server::

   ssh -L8889:ltspserver:8888 -l [username] [registration].servers.aaltsys.net

Gnome terminal
=============================

X-11 Forwarding with gnome-terminal (default IP for ltspserver is 10.4.0.2)::

   gnome-terminal -x ssh -L8889:ltspserver:8888 -l [username] [registration].servers.aaltsys.net

Redirecting SSH to PuTTY
=============================

PuTTY is an open-source cross-platform client for secure connections with 
remote hosts. It is available on Windows, Linux, and Mac, and it is the 
preferred client on Windows. PuTTY adds power to interactive sessions. For 
example, a user can add a port forwarding rule within a running terminal 
session.

.. note::
   Install and configure PuTTY on a Debian KDE system using instructions from
   http://servers.aaltsys.info/resources/06_ssh_samba.html#redirecting-ssh-to-putty.
 
Fixing Changed SSH Keys
=============================

When using :command:`ssh` from a terminal icon or weblink, the session may 
abort when starting. The most likely cause for this is a change to the ssh 
key. To address the problem for a terminal icon, open a terminal shell prompt:: 

   ssh [registration].servers.aaltsys.net

Address this problem for a weblink::

   ssh://[registration].servers.aaltsys.net/

The line number in your :file:`~/.ssh/known_hosts` file which is wrong will be 
displayed. Delete this line with the command::

   sudo sed -i c\[linenumber] ~/.ssh/known_hosts

Fixing X11 Forwarding Zentyal
=============================

Zentyal may disable X11 forwarding, which prevents :command:`dosemu` sessions 
from working, among other things. 

Missing :program:`xauth`
-----------------------------

On Zentyal 2.0 and below, the :program:`xauth` is missing. Install it with::

   sudo apt-get install xauth

ssh uses IPV4 and not IPV6
-----------------------------

On Zentyal 3.0+, Localhost may have an IPV6 address configured, preventing X11 
forwarding by localhost over IPV4. The following commands (on the remote server, 
of course) prevent :program:`ssh` from attempting IPV6::

   sudo sed -ie "/\/usr\/sbin\/sshd -D/c\exec \/usr\/sbin\/sshd -D -4" /etc/init/ssh.conf
   sudo service ssh reload

If :file:`/etc/hosts` configures ``localhost`` under ``ip6``, then the following 
command might fix this configuration::

   sudo sed -ie "/localhost ip6/c\::1\tip6-localhost\tip6-loopback" /etc/hosts

Check to see that the ``127.0.0.1`` line includes ``localhost`` afterwards.

X11 Forwarding turned off
-----------------------------

File :file:`/etc/ssh/sshd_config` should have 3 option lines for X11 Forwarding 
as follows::

   X11Forwarding yes
   X11DisplayOffset 10
   X11UseLocalhost yes
   
Correct any problems here by editing the configuration files and then reloading 
sshd::

   sudo nano /etc/ssh/sshd_config
   sudo service ssh reload

Accessing Servers over SSH
=============================

In this example, an administrator wishes to connect to a remote Windows session 
running as a virtual machine on a Linux server. The Linux server is accessed at 
the domain name ``https://remoteserver.support.aaltsys.com``. Both the Windows 
session and the Linux server authenticate ``username`` and ``password`` for 
logins.

First display a terminal window on the local machine, then ssh to the remote 
server::

   xdg-open ssh://username@remoteserver.support.aaltsys.com

Now explore the remote environment to identify Windows RDP servers. Recommended 
commands are::

   smbclient -L NETBIOSNAME
   smbtree

These commands identify the virtualized windows session as ``XPUNLIMITED``. Now 
find the IP for this machine using either of the commands::

   net lookup XPUNLIMITED
   nmblookup XPUNLIMITED

Suppose the remote Windows terminal server **XPUNLIMITED** uses IP 
**192.168.2.243** in its local network. Display the PuTTY menu with 
:kbd:`<Ctrl-RightClick>`, and choose :menuselection:`Change Settings...`.
Then select Category: :menuselection:`Connection > SSH > Tunnels` and enter::

   Source port -- 3389
   Destination -- 192.168.2.243:3389
   Click -- Add
   Click -- Apply

Finally, open the KRDC Remote Desktop client on the KDE Desktop, and connect 
to: :guilabel:`rdp` :kbd:``localhost``. A remote Windows RDP session will 
display as if it were local, being redirected to you over SSH.
