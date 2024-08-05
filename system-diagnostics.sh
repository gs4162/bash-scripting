#!/bin/bash

echo "Diagnostics started for: $(hostname)" 
echo "-----"
echo "System Uptime:"
uptime | awk '{sub(/,$/,"",$4 ) ; print $3 , $4 }'
echo "Ethernet IP address:"
ip addr | awk '/^[0-9]+: en/ {getline; getline; if ($1 == "inet") print $2}'
echo "Wireless IP address:"
ip addr | awk '/^[0-9]+: wl/ {getline; getline; if ($1 == "inet") print $2}'
echo "Root disk usage remaining:"
df -h | awk '$NF == "/" {print $5}' #looking for the mounted on / 
