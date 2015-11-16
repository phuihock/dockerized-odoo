# Pre-built OpenERP v7 Base Image on Ubuntu 14.04.2 LTS
Source code is hosted at [https://github.com/phuihock/dockerized-odoo](https://github.com/phuihock/dockerized-odoo).

## How to Use This Image
1. Configuration file can be changed by passing setting the directory containing openerp-server.conf as volume to the container. Example:

		-v `pwd`/conf:/opt/odoo/conf

1. Addons can be added passed as volume to /opt/odoo/extras. Example:

		-v `pwd`/extras:/opt/odoo/extras

1. PostgreSQL can be configured in 2 ways: as [Docker link](https://docs.docker.com/userguide/dockerlinks/) [1] or connect to host PostgreSQL instance [2]. Example:

	Option 1:

		--link postgres:postgres

	Option 2:

		--add-host postgres:172.17.0.1

## Complete Example

	$ docker run --rm -v `pwd`/conf:/opt/odoo/conf -v `pwd`/extras:/opt/odoo/extras --name odoo --add-host postgres:172.17.42.1 -p 8069:8069 phuihock/odoo:7.0-$CID

## How to Build This Image

	$ git clone https://github.com/phuihock/dockerized-odoo
	$ cd dockerized-odoo
	$ git submodule update --init
    $ export CID=<commit ID>
    $ cd odoo
    $ git archive -o $CID.tar.gz $CID
    $ cd ..
    $ python -m SimpleHTTPServer 8000
	$ docker build -t <name> .
