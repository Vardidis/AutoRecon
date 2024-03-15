#!/bin/bash

scan=$(sudo naabu -o file.txt -host "135.181.204.105")

declare -a open_ports


## Store all open ports
n=0
for element in $scan
do
    var=$(echo $element | awk -F':' '{print $2}')
    open_ports+=($var)
done

## Read each value of open_ports<arr>
for el in "${open_ports[@]}"; do
    echo $el
done