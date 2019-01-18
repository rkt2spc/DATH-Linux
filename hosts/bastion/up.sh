#!/bin/sh

# Environments & Constants
EXTRANET="10.10.0.0/16"
DMZ="172.16.163.0/24"
INTRANET="192.168.163.0/24"

INTERNET_GATEWAY="10.10.163.1"
INTERNET_GATEWAY_INTERFACE=$(route -n | grep '10.10.0.0' | grep '255.255.0.0' | awk '{print $8}')

set -x

# Replace docker default gateway
route del default
route add default gw $INTERNET_GATEWAY $INTERNET_GATEWAY_INTERFACE

# Enable IP forwarding for routing
sysctl -w net.ipv4.ip_forward=1 > /dev/null 2>&1

##############################################################
# FILTER TABLE
##############################################################

# Set default policies to forbid all traffic
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP

# Allow SSH from the intranet to anywhere
iptables -t filter -A FORWARD -s $INTRANET -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -t filter -A FORWARD -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow HTTP/HTTPS from anywhere to the dmz (where the web server is hosted)
iptables -t filter -A FORWARD -d $DMZ -p tcp --dport 80 -j ACCEPT
iptables -t filter -A FORWARD -d $DMZ -p tcp --dport 443 -j ACCEPT
iptables -t filter -A FORWARD -s $DMZ -p tcp --sport 80 -j ACCEPT
iptables -t filter -A FORWARD -s $DMZ -p tcp --sport 443 -j ACCEPT

# Allow HTTP/HTTPS from to the internet
iptables -t filter -A FORWARD -o $INTERNET_GATEWAY_INTERFACE -p tcp --dport 80 -j ACCEPT
iptables -t filter -A FORWARD -o $INTERNET_GATEWAY_INTERFACE -p tcp --dport 443 -j ACCEPT
iptables -t filter -A FORWARD -i $INTERNET_GATEWAY_INTERFACE -p tcp --sport 80 -j ACCEPT
iptables -t filter -A FORWARD -i $INTERNET_GATEWAY_INTERFACE -p tcp --sport 443 -j ACCEPT

# Allow DNS
iptables -t filter -A FORWARD -p tcp --dport 53 -j ACCEPT
iptables -t filter -A FORWARD -p udp --dport 53 -j ACCEPT

# DHCP shouldn't be allowed to pass through the firewall
# because the DHCP server sit in the same subnet as user machines
# thus connecting directly to each other

##############################################################
# NAT TABLE
##############################################################

# Masquerade packet address to translate IP in/out of the intranet
iptables -t nat -A POSTROUTING -d $INTRANET -j MASQUERADE

# Masquerade packet address to translate IP in/out of the DMZ
iptables -t nat -A POSTROUTING -d $DMZ -j MASQUERADE

# Masquerade packet address to translate IP from/to the internet
iptables -t nat -A POSTROUTING -o $INTERNET_GATEWAY_INTERFACE -j MASQUERADE

set +x
