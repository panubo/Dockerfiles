# Volt Grid: Python 2.7, 3.2, 3.3 & 3.4 App w/ Bureaucrat init support
#
# Base: centos7
# Version: 1.1.2

FROM centos:centos7
MAINTAINER Andrew Cutler <andrew@voltgrid.com>

# 1. Update & Install
# 2. Required for virtualenv bootstrap / install / voltgrid.py
# 3. Base packages required for compiling popular Python packages
# 4. Base packages for compiling Python

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -q -y update && \
    yum -q -y install curl mercurial git tar bzip2 python-jinja2 && \
    yum -q -y install gcc freetype ghostscript freetype-devel libpng libjpeg-turbo libpng-devel libjpeg-turbo-devel python-devel libxml2-devel libxslt-devel mariadb-devel && \
    yum -q -y install make openssl-devel sqlite-devel libffi-devel bzip2-devel && \
    yum -q clean all

# Need a consistent uid for web user
RUN groupadd www --gid 48 && \
    useradd www --uid 48 --gid 48 -d /srv/www && mkdir /srv/log && \
    chown -R www:www /srv

# Git SSH Setup
RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config && \
    mkdir /srv/git && \
    chown root:root /srv/git

# Compile & Install Python 2.7
RUN export PYTHON27=2.7.8; mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON27}/Python-${PYTHON27}.tgz && tar -xzf Python-${PYTHON27}.tgz && \
    cd /dev/tmp/Python-${PYTHON27} && ./configure && make -j `nproc` && make install && rm -rf /dev/tmp/Python-2.7.8

# Compile & Install Python 3.2
RUN export PYTHON32=3.2.5; mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON32}/Python-${PYTHON32}.tgz && tar -xzf Python-${PYTHON32}.tgz && \
    cd /dev/tmp/Python-${PYTHON32} && ./configure && make -j `nproc` && make install && rm -rf /dev/tmp/Python-${PYTHON32}

# Compile & Install Python 3.3
RUN export PYTHON33=3.3.5; mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON33}/Python-${PYTHON33}.tgz && tar -xzf Python-${PYTHON33}.tgz && \
    cd /dev/tmp/Python-${PYTHON33} && ./configure && make -j `nproc` && make install && rm -rf /dev/tmp/Python-${PYTHON33}

# Compile & Install Python 3.4
RUN export PYTHON34=3.4.1; mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON34}/Python-${PYTHON34}.tgz && tar -xzf Python-${PYTHON34}.tgz && \
    cd /dev/tmp/Python-${PYTHON34} && ./configure && make -j `nproc`  && make install && rm -rf /dev/tmp/Python-${PYTHON34}

USER www

# Create Virtualenv Python 2.7
RUN cd /srv && export PYTHON_BINARY='/usr/local/bin/python2.7' && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve27 bureaucrat MySQL-python && \
    echo 'OLDIFS=$IFS; IFS=$'"'\\n'"'; for l in $(cat /srv/env); do eval export echo $l; done; IFS=$OLDIFS' >> /srv/ve27/bin/activate

# Create Virtualenv Python 3.2
RUN cd /srv && export PYTHON_BINARY='/usr/local/bin/python3.2' && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve32 bureaucrat mysqlclient && \
    echo 'OLDIFS=$IFS; IFS=$'"'\\n'"'; for l in $(cat /srv/env); do eval export echo $l; done; IFS=$OLDIFS' >> /srv/ve32/bin/activate

# Create Virtualenv Python 3.3
RUN cd /srv && export PYTHON_BINARY='/usr/local/bin/python3.3' && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve33 bureaucrat mysqlclient && \
    echo 'OLDIFS=$IFS; IFS=$'"'\\n'"'; for l in $(cat /srv/env); do eval export echo $l; done; IFS=$OLDIFS' >> /srv/ve33/bin/activate

# Create Virtualenv Python 3.4
RUN cd /srv && export PYTHON_BINARY='/usr/local/bin/python3.4' && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve34 bureaucrat mysqlclient && \
    echo 'OLDIFS=$IFS; IFS=$'"'\\n'"'; for l in $(cat /srv/env); do eval export echo $l; done; IFS=$OLDIFS' >> /srv/ve34/bin/activate

# Clean up
USER root
RUN rm -rf /tmp/* /dev/tmp/ /var/tmp/*

# Add Volt Grid .py / .conf
ADD voltgrid.conf /usr/local/etc/voltgrid.conf
COPY https://raw.githubusercontent.com/voltgrid/voltgrid-pie/master/voltgrid.py /usr/local/bin/voltgrid.py
RUN chmod 755 /usr/local/bin/voltgrid.py && chmod 644 /usr/local/etc/voltgrid.conf

VOLUME ["/srv/ve27", "/srv/ve32", "/srv/ve33", "/srv/ve34", "/srv/log"]
EXPOSE 8000
CMD ["/usr/local/bin/voltgrid.py", "/srv/ve27/bin/bureaucrat", "init", "--no-create-pid", "--venv", "/srv/ve27", "--envfile", "/srv/env", "--app", "/srv/git", "--logpath", "/srv/log"]
