# one-time program to configure an external drive for backup operations

UUID=""
DEVICE=""
BLKID=""

LABEL=$1
if [[ $LABEL == "" ]] ; then
  LABEL="BACKUP"
fi

if [[ `id -u` -ne 0 ]] ; then
  echo "${HOME##*/}  -- Please run this command with sudo privileges"
  exit
fi

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

# do the work here
if [[ $UUID != "" ]] ; then
  service autofs stop
  mkdir -p /home/mnt/backup/source_config
  umount $DEVICE
  echo "/home/mnt  /etc/auto.home_mnt  --timeout=30 --ghost" > /etc/auto.master
  echo "backup  -fstype=auto,sync  :/dev/disk/by-uuid/$UUID" > /etc/auto.home_mnt
  service autofs start
fi

echo
echo "Test your backup device with command 'ls /home/mnt/backup'."
echo "You should see '@@EXTERNAL@@' in the directory listing."
