#!/bin/bash
# wg_firstclientconf.sh

# Generate a new pair of keys for the client an create the config-file for the first client

if ! [ -d /etc/wireguard/keys/peerkeys/ ]
then
	sudo mkdir /etc/wireguard/keys/peerkeys/
fi
if ! [ -d /etc/wireguard/clientconfs/ ]
then
	sudo mkdir /etc/wireguard/clientconfs/
fi


#Generating the keys in the current folder:
wg genkey | tee "$1"_private_key | wg pubkey > "$1"_public_key

# Create the next IP-Adress.
N=$(sudo head -n 2 /etc/wireguard/wg0.conf)
echo "$N" > tm
NO=$(sudo tail -n1 tm)
echo ${NO##*.} > tmp
NOO=$(cat tmp)
echo ${NOO%/*} > tmp1
echo $[1 + $(cat tmp1)] > tmp2
NOOO=$(cat tmp2)
IPADDR="10.10.10.${NOOO}/32"
echo "$IPADDR" > tmp3

PRIVKEY=$(cat "$1"_private_key)


echo "[Interface]
	PrivateKey = ${PRIVKEY}
	Address = $(cat tmp3)
	DNS = 192.168.178.27

      [Peer]
      PublicKey = $(cat /etc/wireguard/keys/serverkeys/server_public_key)
  	Endpoint = dominicb.ddns.net:51820
	AllowedIPs = 0.0.0.0/0, 192.168.178.0/24
	PersistentKeepalive = 25" > "$1".conf

# Create the QR-Code:
echo ""
echo ""
qrencode -t ansiutf8 < "$1".conf
sudo mv "$1".conf /etc/wireguard/clientconfs/
