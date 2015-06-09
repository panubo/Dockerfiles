## vsftpd docker image

This image attempts to get vsftpd running inside a docker image. There are a
few limitations but will work if your using host networking `--net host` or
have a direct/routed network between the docker container and the client.

## Virtual User

The ftp user has been set to uid 48 and gid 48

## Options

The following environment variables are accepted.

`FTP_USER=user` Sets the default ftp user

`FTP_PASSWORD=password` Sets the password for the user specified above. This
requires a hashed password such as the ones created with `mkpasswd -m sha-512`
which is in the "whois" debian package.

## SSL

SSL can be configured (non-ssl by default). Firstly the ssl certificate and key
need to be added to the image, either using volumes or baking it into an image.
Then specify the vsftpd_ssl.conf config file as the config vsftpd should use.

This example assumes the ssl cert and key are in the same file and are mounted
into the container read-only.

```
docker run --rm -it -e FTP_USER=panubo -e 'FTP_PASSWORD=$6$XWpu...DwK1' -v `pwd`/server.pem:/etc/ssl/certs/vsftpd.crt:ro -v `pwd`/server.pem:/etc/ssl/private/vsftpd.key:ro panubo/vsftpd vsftpd /etc/vsftpd_ssl.conf
```
