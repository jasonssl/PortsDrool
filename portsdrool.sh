#!/bin/bash
#
# A simple bash script to list out all open ports in a single line
 
# Variables
target="$1"
 
ipStringInput() {
    echo "Scanning port for: $target"
    nmap -sS -T4 $target | grep "open" | cut -d" " -f1 | cut -d"/" -f1 > tmpport.txt
    echo -n -e "$target \t " > portlist_$target.txt
    for port in $(cat tmpport.txt);do
        echo -n "$port " >> portlist_$target.txt
    done
    echo " " >> portlist_$target.txt
    cat portlist_$target.txt
    rm tmpport.txt portlist_$target.txt
}
 
textFileInput() {
    for ip in $(cat $target);do
        nmap -sS -T4 $ip | grep "open" | cut -d" " -f1 | cut -d"/" -f1 > tmpport.txt
        echo -n -e "$ip \t " > portlist_$target.txt
        for port in $(cat tmpport.txt);do
            echo -n "$port " >> portlist_$target.txt
        done
        echo " " >> portlist_$target.txt
        cat portlist_$target.txt
        rm tmpport.txt portlist_$target.txt
    done
}
 
if [ -z "$1" ]; then
    echo "[*] Simple port scanning script"
    echo "[*] Usage: $0 <ip_address_text_file.txt> | <IP Address>"
    echo "[*] Example: $0 iplist.txt"
    echo "[*] Example: $0 192.168.1.1"
    exit 1
elif [ -e "$1" ]; then
    textFileInput
else
    ipStringInput
fi
