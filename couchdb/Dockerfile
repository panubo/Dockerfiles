# Panubo CouchDB

FROM centos:centos7
MAINTAINER Andrew Cutler <andrew@panubo.com>

# 1. Update & Install

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y install epel-release && \
    yum -q -y update && \
    yum -y install couchdb && \
    yum clean all && rm -rf /var/cache/yum/*

# Configure CouchDB
RUN sed -e 's/^;bind_address = .*$/bind_address = 0.0.0.0/' -i /etc/couchdb/local.ini

ADD run.sh /run.sh
ADD initialise_couch.sh /initialise_couch.sh
RUN chmod 755 /run.sh /initialise_couch.sh

# Add Volt Grid .py / .conf
ADD voltgrid.conf /usr/local/etc/voltgrid.conf
ADD https://raw.githubusercontent.com/voltgrid/voltgrid-pie/master/voltgrid.py /usr/local/bin/voltgrid.py
RUN chmod 755 /usr/local/bin/voltgrid.py && chmod 644 /usr/local/etc/voltgrid.conf

VOLUME  ["/etc/couchdb", "/var/lib/couchdb", "/var/log/couchdb"]
EXPOSE 5984
CMD ["/usr/local/bin/voltgrid.py", "/run.sh"]
