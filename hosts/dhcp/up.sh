#/bin/sh

# Replace docker default gateway so traffic will be routed to the bastion firewall
route del default
route add default gw 192.168.163.254 eth0 # Address of bastion host in intranet

# Enviroment variables
CONF=${CONF:-/etc/dhcp/dhcpd.conf}
INTERFACES=${INTERFACES:-eth0}

# Make sure leases file exists
touch /var/lib/dhcp/dhcpd.leases

# Check configuration
if ! /usr/sbin/dhcpd -t $VERSION -q -cf "$CONF" > /dev/null 2>&1; then
  echo "dhcpd self-test failed. Please fix $CONF."
  echo "The error was: "
  /usr/sbin/dhcpd -t -4 -cf "$CONF"
  exit 1
fi

# Start dhcpd in foreground mode
dhcpd -4 -d -f -cf "$CONF" "$INTERFACES"
