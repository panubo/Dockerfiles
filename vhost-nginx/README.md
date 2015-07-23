## Vhost Nginx

### Available options

/web/~vhost~/server_name (mandatory)

/web/~vhost~/upstream - Templates use ~vhost~ as upstream unless set

/web/~vhost~/client_max_body_size

/web/~vhost~/ssl_certificate - expects a pem certificate include the private key

/web/~vhost~/ssl_only - Adds a redirect to upgrade connections to ssl

/web/~vhost~/ssl_protocols - Overwrites default ssl protocols list "TLSv1 TLSv1.1 TLSv1.2"

/web/~vhost~/ssl_ciphers - Overwrites default ssl ciphers list "EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH:EDH+aRSA:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS:!RC4"

### Developing and testing the template

Easiest way to test is to run etcd in the same container. The following mounts
the vhosts.conf.tmpl into the container and installs etcd.

```
docker run --rm -it -v `pwd`/vhosts.conf.tmpl:/etc/confd/templates/vhosts.conf.tmpl trnubo/vhost-nginx bash

apt-get -y update && \
  apt-get -y install curl wget vim && \
  curl -L  https://github.com/coreos/etcd/releases/download/v2.0.11/etcd-v2.0.11-linux-amd64.tar.gz -o etcd-v2.0.11-linux-amd64.tar.gz && \
  tar xzvf etcd-v2.0.11-linux-amd64.tar.gz && \
  cp -a etcd-v2.0.11-linux-amd64/etcd etcd-v2.0.11-linux-amd64/etcdctl /usr/local/bin

etcd &

etcdctl set /services/web/app1/q1w2e3:web:8000 10.10.10.10:8000
etcdctl set /web/app1/server_name app1.example.com

sed -i '/_cmd/d' /etc/confd/conf.d/vhosts.toml

# Runs confd once and prints the result if successful
confd -onetime && cat /etc/nginx/conf.d/vhosts.conf; nginx -t
```