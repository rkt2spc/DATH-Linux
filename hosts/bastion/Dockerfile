FROM ubuntu:18.04

# Update dependencies
RUN apt-get update && apt-get install --yes \
  net-tools \
  supervisor \
  iputils-ping \
  traceroute \
  iptables \
  squid

#################################################################################
#                                   Squid                                       #
#################################################################################

# Copy Squid configuration
COPY ./etc/squid/squid.conf /etc/squid/squid.conf

#################################################################################
#                                Supervisor                                     #
#################################################################################

# Copy configurations
COPY ./etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Workdir
WORKDIR /workdir
COPY ./entrypoint.sh .

# Entrypoint
ENTRYPOINT ["/workdir/entrypoint.sh"]

# Command
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
