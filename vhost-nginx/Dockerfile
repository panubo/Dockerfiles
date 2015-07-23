FROM nginx:latest

RUN mkdir -p /etc/confd/templates /etc/confd/conf.d && \
  apt-get -y update && \
  apt-get -y install curl tar && \
  curl -L https://github.com/just-containers/skaware/releases/download/v1.10.0/s6-2.1.3.0-linux-amd64-bin.tar.gz | tar -C / -zxf - && \
  curl -L https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 -o /usr/local/bin/confd && \
  chmod +x /usr/local/bin/*

CMD ["/usr/bin/s6-svscan","/etc/s6"]

COPY s6 /etc/s6/
COPY vhosts.toml /etc/confd/conf.d/vhosts.toml
COPY vhosts.conf.tmpl /etc/confd/templates/vhosts.conf.tmpl
