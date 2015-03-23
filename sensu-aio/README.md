## Sensu All in One

This image contains
* Sensu Server
* Sensu API
* Sensu Client (Monitors the other services in this image)
* Uchiwa
* Redis
* RabbitMQ

Everything nessesary to get started with Sensu on a CentOS7 base image.

## Example Usage

```
docker run -d --name sensu -p 5672:5672 -p 4567:4567 -p 3000:3000 voltgrid/sensu-aio
```

Then open uchiwa at http://127.0.0.1:3000/

Sensu has its config in /etc/sensu/conf.d
