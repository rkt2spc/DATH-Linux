FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  net-tools \
  dnsutils \
  bind9 \
  bind9utils \
  bind9-doc

# Copy DNS bind config
COPY ./etc/bind/named.conf.options /etc/bind/named.conf.options
COPY ./etc/bind/named.conf.local /etc/bind/named.conf.local
COPY ./etc/bind/zones /etc/bind/zones

# Workdir
WORKDIR /workdir
COPY ./entrypoint.sh .

# Entrypoint
ENTRYPOINT ["/workdir/entrypoint.sh"]

# Command
CMD ["/usr/sbin/named", "-g"]
