FROM debian

RUN apt-get update \
    && apt-get install -y --no-install-recommends vsftpd db5.3-util \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty /etc/vsftpd/user_conf /var/ftp /srv && \
    cp /etc/vsftpd.conf /etc/vsftpd.orig && \
    groupadd -g 48 magic && \
    useradd --no-create-home --home-dir /srv -s /bin/false --uid 48 magic --gid 48 -c 'FTP Mapping User' && \
    touch /var/log/vsftpd.log && rmdir /srv/ftp

COPY vsftpd.conf /etc/
COPY vsftpd_virtual /etc/pam.d/
COPY *.sh /

VOLUME ["/etc/vsftpd", "/srv"]

EXPOSE 20 21
EXPOSE 4559 4560 4561 4562 4563 4564

ENTRYPOINT ["/entry.sh"]
CMD ["vsftpd"]
