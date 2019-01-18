FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  net-tools \
  isc-dhcp-server

# Update configurations
COPY ./etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

# Setup startup script
WORKDIR /workdir
COPY ./entrypoint.sh .

# Command
CMD ["/bin/sh", "entrypoint.sh"]
