Fixing locales:
-----------------------------

An incident where a server had incorrect locale information was encountered.
Symptom: console character set was ISO... terminal, and could not be reset to 
UTF-8. This was fixed as follows:

The locales information was updated with the following console commands::
	
	# edit and fix the list of locales, replacing the en_US line
	sudo sed -i s/"en_US ISO-8859-1"/"en_US.UTF-8 UTF-8"/ /var/lib/locales/supported.d/local
	# regenerate the locales (equivalent to command 'locales-gen')
	sudo dpkg-reconfigure locales
	# update the locale settings for LANG and MESSAGES
	sudo update-locale LANG=en_US.UTF-8 LC_MESSAGES=en_US.UTF-8
	# make the new language setting available in the current login session
	export LANG="en_US.UTF-8" 

This procedure was developed from the following support document:
https://help.ubuntu.com/community/Locale/#Changing_settings_permanently

Removing Old Kernels
-----------------------------

Use ssh to access a server, and check the disk allocation::

   dh -a

If the primary boot disk is full, or nearly so, then there may be too many Linux 
kernel images stored on it. Clear old images with the command::

   dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

Changing Password Expiry
-----------------------------

Zentyal 3.x: In a console session on the host server, use the following 
:command:`samba-tool` command to view the password expiry::

   root@zentyal3:~# samba-tool domain passwordsettings show

which shows::

   Password informations for domain 'DC=zentyal-domain,DC=lan'

   Password complexity: off
   Store plaintext passwords: off
   Password history length: 24
   Minimum password length: 0
   Minimum password age (days): 0
   Maximum password age (days): 365
   
To change the password expiry so that passwords do not expire, use the command::

   sudo samba-tool domain passwordsettings set –max-pwd-age=0

.. note::
   The :command:`--max-pwd-age` parameter must be preceded by **two** hyphens.

After changing settings, show the settings again to demonstrate that the 
*Maximum password age* has been changed.
