#!/bin/sh

# Replace docker default gateway so traffic will be routed to the bastion firewall
route del default
route add default gw 192.168.163.254 eth0

# Test DHCP
echo "\n\n=== Test DHCP ==="
set -x
nmap --script broadcast-dhcp-discover
set +x

# Test DNS
echo "\n\n=== Test DNS ==="
set -x
dig +short ns.tuan.com NS
dig +short mail.tuan.com MX
dig +short tuan.com A
dig +short www.tuan.com A
dig +short ftp.tuan.com A
dig +short mail.tuan.com A
dig +short proxy.tuan.com A
dig +short google.com A
set +x

# Test Web
echo "\n\n=== Test Web ==="
set -x
curl -I -X GET http://www.tuan.com
curl -k -I -X GET https://www.tuan.com
curl -I -X GET http://tuan.com
curl -k -I -X GET https://tuan.com
curl -I -X GET https://google.com
set +x
