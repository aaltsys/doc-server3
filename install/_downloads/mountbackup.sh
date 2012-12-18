#! /usr/bin/bash
# Unmount automounted USB-connected BACKUP drives for autofs to remount

# look for drive mounted from USB:
MPOINT=$( echo $( mount | grep '\/media\/' ) )
if [[ "$MPOINT" == '' ]] ; then
  # echo 'nothing mounted on /media'
  exit
else
  echo "$MPOINT"
fi

# device should be /dev/sdc1
DEVICE=$( echo "$MPOINT" | awk -F' ' '{print $1}' )
# label should be BACKUP
LABEL=$( echo "$MPOINT" | awk -F'/media/' '{print $2}' | awk -F' ' '{print $1}' )
echo "device $DEVICE has label $LABEL"

# if label -eq BACKUP then unmount, and restart autofs
if [[ $LABEL -eq 'BACKUP' ]] ; then
  umount $DEVICE
  service autofs restart
  sleep 1s
  echo $( ls /home/mnt/backup/@@* )
fi
