# Python 2.7, 3.2, 3.3 & 3.4
#
# Base: centos7

FROM centos:centos7
MAINTAINER Andrew Cutler <andrew@voltgrid.com>

# 1. Update & Install
# 2. Required for virtualenv bootstrap / install
# 3. Base packages required for compiling popular Python packages
# 4. Base packages for compiling Python

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -q -y update && \
    yum -q -y install curl mercurial git tar bzip2 python-jinja2 && \
    yum -q -y install gcc freetype ghostscript freetype-devel libpng libjpeg-turbo libpng-devel libjpeg-turbo-devel python-devel libxml2-devel libxslt-devel mariadb-devel && \
    yum -q -y install make openssl-devel sqlite-devel libffi-devel bzip2-devel && \
    yum -q clean all

# Compile & Install Python 2.7 - 3.4 from source
RUN for PYTHON in 2.7.10 3.2.6 3.3.6 3.4.3; do mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON}/Python-${PYTHON}.tgz && tar -xzf Python-${PYTHON}.tgz && \
    cd /dev/tmp/Python-${PYTHON} && ./configure && make -j `nproc` && make install && rm -rf /dev/tmp/Python-${PYTHON}; done

# Clean up
RUN rm -rf /tmp/* /dev/tmp/ /var/tmp/* && \
    # Remove links to indefinite Python versions (also prevents os Python from being overriden by accident)
    find /usr/local/bin/ -type l -exec rm {} \; && \
    rm -rf /var/cache/yum/*
