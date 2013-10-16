#! /usr/bin/env bash

wget https://raw.github.com/aaltsys/registration/master/aaltsys-vpn -O /etc/init.d/aaltsys-vpn
update-rc.d -f aaltsys-vpn defaults 
