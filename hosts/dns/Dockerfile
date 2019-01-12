FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  dnsutils \
  bind9 \
  bind9utils \
  bind9-doc

COPY conf/bind/named.conf.options /etc/bind/named.conf.options
COPY conf/bind/named.conf.local /etc/bind/named.conf.local
COPY conf/bind/zones /etc/bind/zones

# Command
CMD ["/usr/sbin/named", "-g"]
