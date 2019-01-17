FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  isc-dhcp-server

# Update configurations
COPY ./etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

# Setup startup script
WORKDIR /workdir
COPY up.sh .

# Command
CMD ["/bin/sh", "up.sh"]
