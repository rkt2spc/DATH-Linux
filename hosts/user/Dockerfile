FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes \
  dnsutils \
  net-tools \
  openssh-client \
  iputils-ping \
  traceroute \
  iptables \
  nmap \
  curl

WORKDIR /workdir
COPY ./up.sh .

CMD ["tail", "-f", "/var/log/dpkg.log"]
