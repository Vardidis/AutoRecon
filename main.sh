#!/bin/bash

scan=$(sudo naabu -o file.txt -host "135.181.204.105")

declare -a open_ports

for element in $scan
do
    open_ports+=$(echo $element | awk -F':' '{print $2}')
done
echo ${open_ports[0]}