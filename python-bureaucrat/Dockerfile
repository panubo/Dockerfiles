# Panubo: Python 2.7, 3.2, 3.3 & 3.4 App w/ Bureaucrat init support
#
# Base: centos7
# Version: 1.3.0

FROM panubo/python
MAINTAINER Andrew Cutler <andrew@voltgrid.com>

# Need a consistent uid for underprivileged web user
RUN groupadd www --gid 48 && \
    useradd www --uid 48 --gid 48 -d /srv/www && mkdir /srv/log && \
    chown -R www:www /srv

# Git SSH Setup
RUN mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config && \
    mkdir /srv/git && \
    chown root:root /srv/git

USER www

# Create Virtualenv Python 2.7 - 3.4 w/ bureaucrat installed
ENV ENV_OPTS='--no-site-packages --distribute --no-wheel' BUREAUCRAT=git+https://github.com/adlibre/python-bureaucrat.git#egg=bureaucrat
RUN for PYTHON in 2.7 3.2 3.3 3.4; do cd /srv && export PYTHON_BINARY="/usr/local/bin/python${PYTHON}" && \
    curl --silent https://raw.githubusercontent.com/adlibre/python-bootstrap/master/bootstrap.sh | bash -s ve${PYTHON//./} $BUREAUCRAT && \
    echo 'OLDIFS=$IFS; IFS=$'"'\\n'"'; for l in $(cat /srv/env); do eval export echo '"'\${l}'"'; done; IFS=$OLDIFS' >> /srv/ve${PYTHON//./}/bin/activate; done

USER root

# Add Volt Grid .py / .conf
ADD voltgrid.conf /usr/local/etc/voltgrid.conf
ADD https://raw.githubusercontent.com/voltgrid/voltgrid-pie/master/voltgrid.py /usr/local/bin/voltgrid.py
RUN chmod 755 /usr/local/bin/voltgrid.py && chmod 644 /usr/local/etc/voltgrid.conf

WORKDIR /srv/git
VOLUME ["/srv/log"]
EXPOSE 8000
CMD ["/usr/local/bin/voltgrid.py", "/srv/ve27/bin/bureaucrat", "init", "--no-create-pid", "--venv", "/srv/ve27", "--envfile", "/srv/env", "--app", "/srv/git", "--logpath", "-"]
