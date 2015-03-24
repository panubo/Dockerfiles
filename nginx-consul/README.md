## Volt Grid Nginx and Consul-template

This image run an Nginx server and consul-template to configure it.

Place you consul-template config files into /consul-template/config/ and templates into /consul-template/templates/

A config file should look like

```
template {
  source = "/consul-template/templates/test.tmpl"
  destination = "/consul-template/output/test.conf"
  command = "nginx-reload"
}
```

nginx-reload.sh saftly reloads nginx so that bad config files do not bring down the server.

If your completly overwriting the /consul-template/templates directory you should include the following config file.

```
# file: /consul-template/config/00-consul.conf
consul = "consul.service.consul:8500"
retry = "10s"
max_stale = "10m"
```

This image used s6 process supervisor. Check out http://blog.tutum.co/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/ and http://skarnet.org/software/s6/ for info.
