#!/bin/bash

# one-time program to configure an external drive for backup operations

echo "Register external drive for backup operations"

if [[ $EUID -ne 0 ]] ; then echo -e "\e[1;31m try again using sudo \e[0m" ; exit 1 ; fi

UUID=""
DEVICE=""
BLKID=""

# use a default LABEL=BACKUP if none is stated
LABEL=$1
if [[ $LABEL=="" ]] ; then
   LABEL="BACKUP"
fi

# Using LABEL, find device and UUID, or else exit
BLKID=$( blkid | grep "$LABEL" )

if [ ${#BLKID} -lt ${#LABEL} ]; then
   echo
   echo "Device labeled $LABEL not found, exiting ..."
   exit
else
   DEVICE=$(echo $BLKID | awk -F':' '{print $1}')
   UUID=$(echo $BLKID | awk -F'UUID="' '{print $2}' | awk -F'"' '{print $1}')
   echo
   echo "Device labeled $LABEL found at $DEVICE with UUID $UUID"
   echo
fi

# Install autofs and ntfs support if missing
APT=0
PKGS="autofs ntfs-3g"
for i in $PKGS
do
   dpkg -s $i > null
   if [ $? -ne 0 ] ; then
      APT=1
      echo "$i is missing, it will be installed"
      apt-get -y install $i
   fi
done

if [ $APT -ne 0 ] ; then
   echo -e  "\e[1;31m Updating system packages, this may take a while \e[0m"
   apt-get -y update && apt-get -y upgrade
fi
  
# Add udev rule to prevent automounting of USB devices
bash < <(echo 'echo "SUBSYSTEM==\"usb\", ENV{UDISKS_AUTO}=\"0\"" >> /etc/udev/rules.d/85-no-automount.rules')
service udev restart

# do work here: create autofs configuration files for backup
if [ $UUID!="" ] ; then
   service autofs stop
   mkdir -p /home/mnt/backup/source_config
   umount $DEVICE
   echo "/-  /etc/auto.backup  --timeout=30 --ghost" > /etc/auto.master
   echo "/home/mnt/backup  -fstype=auto,sync  :/dev/disk/by-uuid/$UUID" > /etc/auto.backup
   service autofs start
   wait 10s
fi
 
# exit messages to demonstrate success
echo -e "\e[1;35mCommand "ls -al /home/mnt/backup/@@*" should show '@@EXTERNAL@@':"
ls -al /home/mnt/backup/@@*
echo -e "\e[0m"

