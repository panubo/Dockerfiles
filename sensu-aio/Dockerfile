FROM centos:centos7
MAINTAINER Tim Robinson <tim@voltgrid.com>

RUN cp -a /usr/share/zoneinfo/UTC /etc/localtime; \
  echo -e "ZONE=\"UTC\"\nUTC=True" > /etc/sysconfig/clock

ADD sensu.repo /etc/yum.repos.d/sensu.repo
RUN \
  yum -q -y install epel-release; \
  yum -q -y install erlang redis sensu supervisor uchiwa; \
  yum -q -y clean all

RUN rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc; \
  rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.1/rabbitmq-server-3.2.1-1.noarch.rpm

RUN ln -s /opt/sensu/embedded/bin/ruby /usr/bin/ruby

RUN \
  /opt/sensu/embedded/bin/gem install redphone --no-rdoc --no-ri; \
  /opt/sensu/embedded/bin/gem install mail --no-rdoc --no-ri; \
  /opt/sensu/embedded/bin/gem install pony --no-rdoc --no-ri

RUN \
  mkdir -p /etc/sensu/plugins/processes; \
  curl -L -s -o /etc/sensu/plugins/processes/check-procs.rb https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/processes/check-procs.rb; \
  chmod +x /etc/sensu/plugins/processes/check-procs.rb

RUN \
  mkdir -p /etc/sensu/handlers/notification; \
  curl -L -s -o /etc/sensu/handlers/notification/mailer.rb https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer.rb; \
  curl -L -s -o /etc/sensu/handlers/notification/ponymailer.rb https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/ponymailer.rb; \
  sed -i '/:arguments/d' /etc/sensu/handlers/notification/ponymailer.rb; \
  chmod +x /etc/sensu/handlers/notification/*

ADD supervisord.ini /etc/supervisord.d/supervisord.ini
ADD config.json /etc/sensu/config.json
ADD client.json /etc/sensu/conf.d/client.json
ADD checks.json /etc/sensu/conf.d/checks.json

# Rabbitmq
EXPOSE 5672
# Redis
#EXPOSE 6379
# Sensu API
EXPOSE 4567
# Uchiwa
EXPOSE 3000

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
