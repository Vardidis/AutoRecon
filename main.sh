#!/bin/bash
PORTS_PATH="ports.txt"
truncate -s 0 $PORTS_PATH
chmod o+rw $PORTS_PATH

S_PATH="services.txt"
truncate -s 0 $S_PATH
chmod o+rw $S_PATH

IP="jimgrill.gr"

echo "[+] Scanning $IP for open ports"

naabu_scan=$(sudo naabu --silent -host $IP)

declare -a open_ports

## Store all open ports
n=0
for element in $naabu_scan
do
    var=$(echo $element | awk -F':' '{print $2}')
    open_ports+=($var)
done

echo "[+] Naabu found ${#open_ports[@]} open ports"

## Store all open ports to `ports.txt`
for el in "${open_ports[@]}";
do    
    echo $el >> $PORTS_PATH
done

sudo nmap -oN temp.txt $IP

## Cut down nmap banners and additional verbosity to useful information
cat temp.txt | grep -E "[0-9]{1,5}/[a-zA-Z]" | while IFS= read -r line;
do
    echo $line >> $S_PATH
done