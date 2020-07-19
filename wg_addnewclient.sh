#!/bin/bash
# wg_addnewclient.sh

# Be carefull! This script will create a new wg0.conf file. Therefor a possibly existing file is backed up under: wg0.conf.bc 
# This script will only works if there is no client in the wg0.conf

# Scripts included: 
# wg_serverconf.sh
# wg_firstclientconf.sh
# wg_serverupdate.sh

# Autor: segler89: neuemail+wgscript@mailbox.org

# Test if there is a wg0.conf an if, there will be made a backup
[ /etc/wireguard/wg0.conf ] && sudo mv /etc/wireguard/wg0.conf /etc/wireguard/wg0.conf.bc

# Creating the wg0.conf file
./wg_serverconf.sh

echo "Enter the clients name: "
read CNAME
echo "Create client keys..."
sleep 3s
echo "Build client config file..."
sleep 3s

# Creating the client keys and conf
./wg_firstclientconf.sh $CNAME

# Updating the wg0.conf
./wg_serverupdate.sh $CNAME
echo "Everthing is OK. Have fun with wireguard."

exit 0
