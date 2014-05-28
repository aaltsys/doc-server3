###################################
 Network Options with SysRescue
###################################

.. note::
	This documentation is extracted from the System Rescue CD documentation found on line at http://www.sysresccd.org/Online-Manual-EN. Please refer to the original documentation there.

Automatic Network configuration
================================

If your system has supported hardware, ethernet or wifi network adapters should be automatically detected, and the driver loaded during boot. You will still need to assign an IP address and a default gateway.

+ **Network-Manager** provides a graphical interface to configure the network, which makes configuration easier especially for wireless networks. The Network-Manager is available as a small icon in the taskbar just next to the clock. Network-Manager is only available in the graphical environment.
+ **net-setup** utility, (e.g. :kbd:`net-setup eth0`) should be used on the command line.


Hand-configuring Networking
===================================

.. note::
	To use command line tools, first stop Network-Manager by running :kbd:`/etc/init.d/NetworkManager stop` in the shell or by booting SystemRescueCd with the *nonm* boot option. If you are booting SystemRescueCd from the network or if you are using boot options such as *ethx* or *dodhcp* the Network-Manager service will automatically be stopped.

+ **dhcpd**: To use dynamic configuration, type :kbd:`dhcpcd eth0`. Then use :kbd:`ifconfig -a` to display the IP address the DHCP server leased to the interface.
+ **ifconfig**: To assign a specific static IP address, enter :kbd:`ifconfig eth0 192.168.10.17` or similar, depending on the ethernet port and IP desired.
+ **route**: Next configure the default route. For example, to connect to a gateway at 192.168.10.2 enter: :kbd:`route add default gw 192.168.10.2`.

Setting up Networking at Boot
===================================

SystemRescueCd provides network boot options such as *ethx*, *dns*, *gateway*, *dodhcp* that allow you to automatically configure the network when SystemRescueCd starts. It is very useful if you want to boot SystemRescueCd from the network using PXE but it can be used in any case.

Running an SSH Server
==========================

**SSH** allows you to use a shell on another computer (as telnet does), and you can copy files (with *scp*). If you want to run an SSH server, first change the root password by typing :kbd:`passwd xxx`. You can also use the :kbd:`rootpass=xxx` boot option before SystemRescueCd starts to define the root password.

Although ssh server is automatically started, you can restart it with the command :kbd:`/etc/init.d/sshd restart`, and you can stop it with :kbd:`/etc/init.d/sshd stop`. You can also use SystemRescueCd as an SSH client to connect to an SSH server: just use :kbd:`ssh login@ssh.server.org` or :kbd:`scp source dest`. Both source and dest may be local or remote. Use :kbd:`login@ssh.server.org:/path/filename` for remote files.

Accessing a Windows Share
=============================

SystemRescueCd comes with the cifs client package that allows you to connect to a Windows machine having shared drives.

The **mount-cifs** package allows you to access a Windows computer on the network. For example, suppose a Windows box is on *192.168.10.3* and has a shared directory called *mydata* accessible by user *robert*::

	mkdir /mnt/windows
	mount -t cifs //192.168.10.3/mydata /mnt/windows -o username=robert,MyPaSsWoRd=root -o lfs
	cd /mnt/windows

Now you should be able to see files in */mnt/windows*. Don't forget to unmount the directory when you have finished what you are doing in the shared directory::

	umount /mnt/windows

It's important not to forget the option "lfs" (Large File Support), because it allows you to handle files that are larger than 2 GB. Big files are often used when making a backup or an image file.

Mount remote FTP/SSH shares
==============================

there is a powerful way to access files located on an FTP server as local file systems with the **Userland FileSystem**. You mount the share and work on the remote files just as you would work on any local files, then umount the share with the standard :kbd:`umount` command. Here is an example showing how to mount an FTP file system in */mnt/ftp* as anonymous (read only)::

	mkdir /mnt/ftp
	lufis fs=ftpfs,host=ftp.kernel.org /mnt/ftp -s 
	cd /mnt/ftp
	umount /mnt/ftp

Here is an example of how to mount an SSH file system in */mnt/ssh* as anonymous (read only)::

	mkdir /mnt/ssh
	passwd root
	sshfs login@ssh.server.org:/path/to/dir /mnt/ssh
	cd /mnt/ssh
	umount /mnt/ssh
