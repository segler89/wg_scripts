#!/bin/bash

sudo mv "$1"_private_key "$1"_public_key /etc/wireguard/keys/peerkeys/
sudo mv "$1".conf /etc/wireguard/clientconfs/
rm tmp tmp1 tmp2 tmp3
[ -e tm ] && rm tm
[ -e tmp4 ] && rm tmp4
