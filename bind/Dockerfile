FROM debian:latest
MAINTAINER Andrew Cutler <andrew@panubo.com>

EXPOSE 53/udp
EXPOSE 53/tcp

VOLUME ["/data"]

RUN apt-get update && \
    apt-get install -y bind9 dnsutils vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD entry.sh /
RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]
CMD ["/usr/sbin/named", "-c", "/data/etc/named.conf", "-u", "bind", "-g"]
