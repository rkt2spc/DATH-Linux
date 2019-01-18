#!/bin/sh

# Replace docker default gateway so traffic will be routed to the bastion firewall
route del default
route add default gw 192.168.163.254 eth0 # Address of bastion host in intranet

# Execute
exec "$@"
