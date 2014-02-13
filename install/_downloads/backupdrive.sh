# one-time program to configure an external drive for backup operations

# run this program with root privileges
echo "This script requires superuser privileges to run."
echo "Enter your password when prompted by sudo."

# clear any previous sudo permission
sudo -k

# run inside sudo
sudo sh <<SCRIPT

   UUID=""
   DEVICE=""
   BLKID=""

   if [[ `id -u` -ne 0 ]] ; then
     echo "${HOME##*/}  -- Please run this command with sudo privileges"
     exit
   fi

   # use a default LABEL if none is stated
   LABEL=$1
   if [[ $LABEL == "" ]] ; then
     LABEL="BACKUP"
   fi

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
     echo "/home/mnt  /etc/auto.home_mnt  --timeout=30 --ghost" > /etc/auto.master
     echo "backup  -fstype=auto,sync  :/dev/disk/by-uuid/$UUID" > /etc/auto.home_mnt
     service autofs start
   fi

SCRIPT

# successful exit messages
echo
echo "Test your backup device with command 'ls /home/mnt/backup'."
echo "You should see '@@EXTERNAL@@' in the directory listing."

