# Pre-built OpenERP v7 Base Image on Ubuntu 14.04.2 LTS
Source code is hosted at [https://github.com/phuihock/dockerized-odoo](https://github.com/phuihock/dockerized-odoo).

## How to Use This Image
1. Configuration file can be changed by passing setting the directory containing openerp-server.conf as volume to the container. Example:

		-v `pwd`/conf:/opt/openerp/conf

1. Addons can be added passed as volume to /opt/openerp/extras. Example:

		-v `pwd`/extras:/opt/openerp/extras

1. PostgreSQL can be configured in 2 ways: as [Docker link](https://docs.docker.com/userguide/dockerlinks/) [1] or connect to host PostgreSQL instance [2]. Example:

	Option 1:

		--link postgres:postgres

	Option 2:

		--add-host postgres:172.17.42.1

## Complete Example

	$ docker run --rm -v `pwd`/conf:/opt/openerp/conf -v `pwd`/extras:/opt/openerp/extras --name openerp --add-host postgres:172.17.42.1 -p 8069:8069 phuihock/odoo:7.0

## How to Build This Image

	$ git clone https://github.com/phuihock/dockerized-odoo
	$ cd dockerized-odoo
	$ git submodule update --init
	$ docker build -t <name> .
