# one-time program to configure an external drive for backup operations
# Clear and reestablish sudo privileges to run this program as root
sudo -k
echo -e "\e[5;35m Authentication required \e[0m"
sudo sh <<SCRIPT

   UUID=""
   DEVICE=""
   BLKID=""
   
   # use a default LABEL=BACKUP if none is stated
   LABEL=$1
   if [[ $LABEL == "" ]] ; then
     LABEL="BACKUP"
   fi
   
   # Install autofs if missing
   apt-get -y install autofs
   
   # Using LABEL, find device and UUID, or else exit
   BLKID=$( blkid | grep "$LABEL" )
   if [[ $BLKID != "" ]] ; then
     DEVICE=$(echo $BLKID | awk -F':' '{print $1}')
     UUID=$(echo $BLKID | awk -F'UUID="' '{print $2}' | awk -F'"' '{print $1}')
     echo
     echo "Device labeled $LABEL found at $DEVICE with UUID $UUID"
     echo
   else
     echo
     echo "Device labeled $LABEL not found, exiting ..."
     exit
   fi

   # do work here: create autofs configuration files for backup
   if [[ $UUID != "" ]] ; then
     service autofs stop
     mkdir -p /home/mnt/backup/source_config
     umount $DEVICE
     echo "/-  /etc/auto.backup  --timeout=30 --ghost" > /etc/auto.master
     echo "/home/mnt/backup  -fstype=auto,sync  :/dev/disk/by-uuid/$UUID" > /etc/auto.backup
     service autofs start
   fi

SCRIPT

# exit messages to demonstrate success
echo -e "\e[1;35mThe following directory listing should show '@@EXTERNAL@@':"
ls -al /home/mnt/backup/@@*
echo -e "\e[0m"

