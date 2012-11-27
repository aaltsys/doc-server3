#####################################
 KDE Desktop Management
#####################################

Understanding SSH keys
=====================================

private key ~/.ssh/id_rsa
public key  ~/.ssh/id_rsa.pub
known hosts ~/.ssh/known_hosts

In /etc/ssh/ssh_config, comment out the line ``HashKnownHosts yes`` with the 
following command:

|	sudo sed "s/    HashKnown/#   HashKnown/" /etc/ssh/ssh_config

Replace ssh with PuTTY as default ssh:// handler with the command:

|	sudo bash < <(wget https://raw.github.com/gist/1030236/putty-kde.sh -O-)

Avoiding VIM
=====================================

Change default editor in KDE with the command:

|	sudo update-alternatives --config editor

Change default editor when opening files in Dolphin:

|	Right-click on file, choose *Properties*
|	Click on the wrench to the right of *file type*
|	Click on your preferred editor in the *Application Preference Order* list
|	Click *Move Up* to move your preference up the list
|	Click *Apply*, then close the properties window.

Turn on Apple Keyboard function keys
=====================================

|	# display current keyboard state (1=off, 2=on)
|	cat /sys/module/hid_apple/parameters/fnmode 
|	# set keyboard state to 2 (on)
|	echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
|	# make the configuration change permanent
|	sudo touch /etc/sysfs.conf
|	sudo bash < <(echo 'echo "module/hid_apple/parameters/fnmode = 2" >> /etc/sysfs.conf')

References:

`AppleKeyboard <https://help.ubuntu.com/community/AppleKeyboard>`_