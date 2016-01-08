# Python 2.7, 3.2, 3.3 & 3.4 App w/ Bureaucrat init support

This container uses panubo/python which has the latest [Python](http://python.org) versions from source. An empty [virtualenv](https://github.com/pypa/virtualenv) is provided for each Python version.

This container is used to support runtime Python app deployment with the use of [voltgrid.py](https://github.com/voltgrid/voltgrid-pie) or build time deployment using build steps contained in your own Dockerfile.

## Example Projects

See [Voltgrid Django Example](https://github.com/voltgrid/voltgrid-django-example).

## Build

    docker build -t panuno/python-bureaucrat .
