#!/bin/bash

TARGET_PATH="targets"
chmod o+rw $TARGET_PATH

PORTS_PATH="ports.txt"
S_PATH="services.txt"

ips=($@)

for target in ${ips[*]};
do
    BASE_PATH="$TARGET_PATH/$target"
    mkdir -p $BASE_PATH
    chmod o+rw $BASE_PATH

    echo "[+] Scanning $target for open ports"

    naabu_scan=$(sudo naabu --silent -host $target)

    declare -a open_ports

    ## Store all open ports
    for element in $naabu_scan
    do
        var=$(echo $element | awk -F':' '{print $2}')
        open_ports+=($var)
    done

    echo "[+] Naabu found ${#open_ports[@]} open ports"

    ## Store all open ports to `ports.txt`
    for el in "${open_ports[@]}";
    do    
        echo $el >> "$BASE_PATH/$PORTS_PATH"
    done

    sudo nmap -oN temp.txt $target

    ## Cut down nmap banners and additional verbosity to useful information
    cat temp.txt | grep -E "[0-9]{1,5}/[a-zA-Z]" | while IFS= read -r line;
    do
        echo $line >> "$BASE_PATH/$S_PATH"
    done
done