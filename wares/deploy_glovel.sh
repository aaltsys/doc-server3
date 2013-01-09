#!/bin/bash
# program to deploy .rst text file to user directory: public_html (Linux Zentyal) Sites (Apple Server)

PUBLIC_DIR=/mnt/officeserver/glovel/Sites/
DEST_DIR=wares-server

# rm -rf "$PUBLIC_DIR""$DEST_DIR"
# cp -rf ./_build/html/* "$PUBLIC_DIR""$DEST_DIR"
rsync -aHAXE --delete ./_build/html/* "$PUBLIC_DIR""$DEST_DIR"
