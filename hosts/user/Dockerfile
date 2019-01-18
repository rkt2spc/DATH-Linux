FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  net-tools \
  dnsutils \
  openssh-client \
  sshpass \
  iputils-ping \
  traceroute \
  iptables \
  nmap \
  curl

# Workdir
WORKDIR /workdir
COPY ./entrypoint.sh .

# Entrypoint
ENTRYPOINT ["/workdir/entrypoint.sh"]

# Command
CMD ["tail", "-f", "/var/log/dpkg.log"]
