#!/bin/bash

ip_address=$1
# Split the IP address into its four octets

octet1=$(echo $ip_address | cut -d "." -f 1)
octet2=$(echo $ip_address | cut -d "." -f 2)
octet3=$(echo $ip_address | cut -d "." -f 3)
octet4=$(echo $ip_address | cut -d "." -f 4)

# Convert each octet to hex format and concatenate them
hex_ip=$(printf "%02X" $octet1)
hex_ip=$hex_ip$(printf "%02X" $octet2)
hex_ip=$hex_ip$(printf "%02X" $octet3)
hex_ip=$hex_ip$(printf "%02X" $octet4)
echo $hex_ip
