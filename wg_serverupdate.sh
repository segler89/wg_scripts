#!/bin/bash
# wg_serverupdate.sh

# Update the server.conf (normally wg0.conf) with the new client infos

sudo mv /etc/wireguard/wg0.conf .

PUBKEY=$(cat "$1"_public_key)

echo "
# ${1}
[Peer]
PublicKey = ${PUBKEY}
AllowedIPs = $(cat tmp3)" >> wg0.conf

sudo chmod 644 wg0.conf
sudo mv wg0.conf /etc/wireguard/
./clearfolder.sh $1
