################################
 Mounting Network File Systems
################################

Using sshfs File Shares in Linux
================================

.. Note::
	This guide describes connecting to either local or remote server file systems from Linux or Unix desktops. The specific commands in this guide are given for Ubuntu; syntax will differ with other systems.

Part 1: Configure File Systems
""""""""""""""""""""""""""""""""

This section must be performed once on each local desktop to prepare the system to connect. First configure the desktop to use remote filesystems by installing packages and loading the kernel module **fuse**. (The fuse file system is not included in default system configurations.) For Debian/Ubuntu users, use your preferred editor to create a script file on the Desktop as follows (cut and paste the text)::

	#!/usr/bin/env bash
	apt-get --no-upgrade install sshfs fuse-utils autofs
	modprobe --first-time fuse
	if [ $? -eq 0 ]
	then echo "fuse" >> /etc/modules
	fi

Save the bash script on the Desktop as **fuse.sh**. Open a terminal session on 
the desktop, set the permissions for the file to executable, and execute the script::

	chmod +x fuse.sh
	sudo ./fuse.sh

Part 2. Setup Server Access
""""""""""""""""""""""""""""""""

This section is performed once for each remote server, to add information about 
the server to the local desktop. Instructions are provided using Domain Names. 
IP addresses would also work, but then the shares would not be accessible both 
locally and remotely. When DNS is properly configured, access works whether the 
connection is local, bridged, VPN, or public.

.. Note::
	 Throughout these instructions, replace **HOSTSERVER**, **DOMAIN**, and 
	 **TLD** with the name of the server to be accessed, the domain for the 
	 server, and the top-level domain (.com, .net, etc.). For example, 
	 **HOSTSERVER.DOMAIN.TLD** might be replaced with *officeserver.aaltsys.com* 
	 for the office server at AAltSys.

.. sidebar:: /etc/auto.master

	Each entry in **auto.master** defines a file access point which
	binds to a remote server. For example, file requests to
	**/mnt/HOSTSERVER** will automount **HOSTSERVER** shares. 
	Shares will be unmounted if idle for over 30 seconds.
	
	**/etc/auto.HOSTSERVER**
	
	A list of share mappings is required for each remote server.
	Here **HOSTSERVER** has two shares, **PUBLIC** and *****. Entries
	start with a name (e.g., ``public``), followed by configuration
	parameters: ``-fstype=fuse,rw,...``,
	and user ssh credentials: ``IdentityFile=$HOME/.ssh/id_rsa``.
	Last is the URI for accessing the share:
	``:sshfs\#$USER@HOSTSERVER.DOMAIN.TLD\:/.../public``.	

Assign a mount point (a file directory pointer) for the remote server to use::

	sudo mkdir /mnt/HOSTSERVER/

The master configuration file, **auto.master**, provides **autofs** with mount 
names and server configurations for shares. At the terminal, type the command::

	sudoedit /etc/auto.master

and add the following line of text, replacing HOSTSERVER with the server name::

/mnt/HOSTSERVER /etc/auto.HOSTSERVER --timeout=30,--ghost

Now create and edit the server configuration file, **auto.HOSTSERVER**, to 
provide server-specific information::

	sudoedit /etc/auto.HOSTSERVER

and enter and save the share configuration information, such as::

	public -fstype=fuse,rw,nodev,nonempty,noatime,max_read=65536,allow_other,compression=yes,uid=$UID,gid=$GID,StrictHostKeyChecking=no,IdentityFile=$HOME/.ssh/id_rsa,umask=0007 :sshfs\#$USER@HOSTSERVER.DOMAIN.TLD\:/home/samba/shares/public/
	* -fstype=fuse,rw,allow_other,nodev,nonempty,noatime,max_read=65536,compression=yes,uid=$UID,gid=$GID,StrictHostKeyChecking=no,IdentityFile=$HOME/.ssh/id_rsa,umask=0077 :sshfs\#$USER@HOSTSERVER.DOMAIN.TLD\:/home/&

Restart the autofs module to load the changed configuration::

	sudo /etc/init.d/autofs restart
	sudo ssh HOSTSERVER.DOMAIN.TLD

When prompted for the root password of the remote host, press :kbd:`<Ctrl-C>` 
to exit the command.

Part 3. Provide your ssh key
""""""""""""""""""""""""""""""""

This section must be performed for each local user who will access the remote 
server. Type the following commands to (1) create an ssh private key provided 
one does not exist, and (2) copy a user public key to the remote server for 
authentication::

	if [ ! -f "$HOME/.ssh/id_rsa" ]; then ssh-keygen; fi
	ssh-copy-id `id -un`@HOSTSERVER.DOMAIN.TLD

Now verify that the remote folders will mount::

	ls -al /mnt/HOSTSERVER
	ls /mnt/HOSTSERVER/`id -un`

Bookmark folders in /mnt/HOSTSERVER in the file manager for easy access.

When this does not work
""""""""""""""""""""""""""""""""

If the public folder or user home folder will not mount, try the following::

	ssh `id -un`@HOSTSERVER.DOMAIN.TLD
	chmod og-w ~
	chmod og-w ~/.ssh
	chmod 600 ~/.ssh/authorized_keys

Mounting File Shares in Windows
================================

.. Note::
	 Local file sharing to Windows desktops is handled through Microsoft CIFS 
	 services, also known as SAMBA in the Linux community. Due to inherent 
	 security limitations, SAMBA shares should not be accessed remotely. The 
	 secure shell service (ssh) which provides local and remote access with 
	 Linux is not supported by Windows. Remote file sharing for Windows desktops 
	 generally requires using a VPN instead.

Server SSHFS Configuration
================================

Install authentication and sharing modules on the server as follows::

	sudo aptitude install openssh-server libpam-modules

The default server umask=0022 will shade permissions for files and folders 
created on the server. Private home folders with umask=0077 will work just 
fine, but public folders needing umask=0007 will result in incorrect 
permissions which block write access. To prevent this problem::

	sudoedit /etc/pam.d/sshd

Now add the following three lines::

  # Default umask mask for SSH/SFTP sessions
  # Shell sessions: Override with /etc/profile or ~/.bashrc or ~/.profile 
  session optional        pam_umask.so umask=0000

As noted above, actual ssh shell logins on the server will get the default 
umask=022 on new files and directories. The following command will change this 
for all shell logins::

	sudo sed -i s/umask 022/umask 0007/ /etc/profile

A logged in user could change just their own default umask with the command::

	sudo sed -i s/#umask\ 022/umask\ 0007/ ~/.profile

References:

`How to mount SFTP accesses. <http://wiki.lapipaplena.org/index.php/How_to_mount_SFTP_accesses>`_