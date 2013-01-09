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
