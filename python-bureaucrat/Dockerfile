# Volt Grid: Python 2.7, 3.2, 3.3 & 3.4 App w/ Bureaucrat init support
#
# Base: centos7
# Version: 1.2.0

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

# Compile & Install Python 2.7 - 3.4 from source
RUN for PYTHON in 2.7.10 3.2.6 3.3.6 3.4.3; do mkdir -p /dev/tmp && cd /dev/tmp && curl -O https://www.python.org/ftp/python/${PYTHON}/Python-${PYTHON}.tgz && tar -xzf Python-${PYTHON}.tgz && \
    cd /dev/tmp/Python-${PYTHON} && ./configure && make -j `nproc` && make install && rm -rf /dev/tmp/Python-${PYTHON}; done

USER www

# Create Virtualenv Python 2.7 - 3.4 w/ bureaucrat installed
ENV BUREAUCRAT git+https://github.com/adlibre/python-bureaucrat.git#egg=bureaucrat
RUN for PYTHON in 2.7 3.2 3.3 3.4; do cd /srv && export PYTHON_BINARY="/usr/local/bin/python${PYTHON}" && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve${PYTHON//./} $BUREAUCRAT; done

# Clean up
USER root
RUN rm -rf /tmp/* /dev/tmp/ /var/tmp/* && \
    # Remove links to indefinite Python versions (also prevents os Python from being overriden by accident)
    find /usr/local/bin/ -type l -exec rm {} \; && \
    rm -rf /var/cache/yum/*

# Add Volt Grid .py / .conf
ADD voltgrid.conf /usr/local/etc/voltgrid.conf
ADD https://raw.githubusercontent.com/voltgrid/voltgrid-pie/master/voltgrid.py /usr/local/bin/voltgrid.py
RUN chmod 755 /usr/local/bin/voltgrid.py && chmod 644 /usr/local/etc/voltgrid.conf

VOLUME ["/srv/ve27", "/srv/ve32", "/srv/ve33", "/srv/ve34", "/srv/log"]
EXPOSE 8000
CMD ["/usr/local/bin/voltgrid.py", "/srv/ve27/bin/bureaucrat", "init", "--no-create-pid", "--venv", "/srv/ve27", "--envfile", "/srv/env", "--app", "/srv/git", "--logpath", "-"]
