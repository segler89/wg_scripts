#!/bin/bash

file="/tmp/digIP.txt"
digIP=$(dig +short dominicb.ddns.net)

if [ -e "$file" ]
then
        echo "file exists"
        fileTXT=$(cat "$file")

        if [ "$digIP" != "$fileTXT" ]
        then
                echo "IP has changed, restart wg0"
                wg-quick down wg0
                wg-quick up wg0
                echo "$digIP" > "$file"
        else
                echo "Everything is OK, nothing to do"
        fi
else
        echo "$digIP" > "$file"
fi
