docker_tag 	= panubo/python-bureaucrat

UNAME_S         := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    APP_HOST            := localhost
endif
ifeq ($(UNAME_S),Darwin)
    APP_HOST            := $(shell boot2docker ip)
endif

build:
	docker build -t $(docker_tag) .

bash:
	docker run --rm -it $(docker_tag) bash
