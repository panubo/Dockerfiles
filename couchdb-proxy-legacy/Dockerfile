FROM nginx:latest

ENV SKAWARE_VERSION 1.14.0
ENV S6_VERSION 2.2.0.0
ENV CONFD_VERSION 0.10.0

RUN mkdir -p /etc/confd/templates /etc/confd/conf.d && \
  apt-get -y update && \
  apt-get -y install curl tar && \
  curl -L https://github.com/just-containers/skaware/releases/download/v${SKAWARE_VERSION}/s6-${S6_VERSION}-linux-amd64-bin.tar.gz | tar -C / -zxf - && \
  curl -L https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd && \
  chmod +x /usr/local/bin/*

CMD ["/usr/bin/s6-svscan","/etc/s6"]

ENV COUCHDB_SERVICE couchdb

COPY s6 /etc/s6/
COPY nginx.toml /etc/confd/conf.d/nginx.toml
COPY nginx.conf.tmpl /etc/confd/templates/nginx.conf.tmpl
