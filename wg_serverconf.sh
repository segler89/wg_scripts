#!/bin/bash
# wg_serverconf.sh

# Create the server.conf (normally wg0.conf) with a new pair of keys, generated here. Move The servers priv key to /etc/wireguard/keys/serverkeys and the new wg0.conf to /etc/wireguard/

if ! [ -d /etc/wireguard/keys/serverkeys/ ]
then
	sudo mkdir -p /etc/wireguard/keys/serverkeys/
fi

# Creating a new pair of server-keys:

wg genkey | tee server_private_key | wg pubkey > server_public_key

PRIVKEY=$(cat server_private_key)

# Generating the wg0.conf:
echo "[Interface]
Address = 10.10.10.1/24
ListenPort = 51820
PrivateKey = ${PRIVKEY}
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE" > wg0.conf

# Setting permissions only for root and moves wg0 and priv key:
sudo chmod 600 server_private_key
sudo chmod 600 server_public_key
sudo chmod 644 wg0.conf

sudo mv wg0.conf /etc/wireguard/
sudo mv server_public_key /etc/wireguard/keys/serverkeys/
sudo mv server_private_key /etc/wireguard/keys/serverkeys/
