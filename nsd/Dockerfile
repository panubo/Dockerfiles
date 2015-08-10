FROM debian:jessie

RUN groupadd -g 108 nsd && \
  apt-get update && \
  apt-get -y install vim nsd openssl && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /run/nsd /var/lib/nsd/zones && \
  chown nsd:nsd /run/nsd /var/lib/nsd/zones

COPY nsd.conf /etc/nsd/nsd.conf
COPY entry.sh /

VOLUME ["/etc/nsd","/var/lib/nsd"]

ENTRYPOINT ["/entry.sh"]
CMD ["/usr/sbin/nsd","-d"]
