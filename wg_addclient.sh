#!/bin/bash
# wg_addclient.sh

# This script read the name of the new client an will generate a new pair of keys for this name. If there is already an existing key file nothing will happen. The /etc/wg0.conf will extended by the newly registered client. This script will only works if there already exists at least one client in the wg0.conf

# Scripts included:
# wg_clientconf.sh 
# wg_serverupdate.sh

# Autor: segler89: neuemail+wgscript@mailbox.org

echo "Enter the clients name: "
read CNAME

echo "Create client keys..."
sleep 3s
echo "Build client config file..."
sleep 3s

# Creating the client keys and conf
./wg_clientconf.sh $CNAME

# Updating the wg0.conf
./wg_serverupdate.sh $CNAME
echo "Everthing is OK. Have fun with wireguard."

exit 0
