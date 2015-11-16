FROM ubuntu:14.04
MAINTAINER Chang Phui-Hock <phuihock@codekaki.com>
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/odoo/env/bin:$PATH
RUN groupadd -r codekaki && useradd -r -g codekaki -m -d /opt/odoo codekaki

RUN echo "Asia/Kuala_Lumpur" > /etc/timezone && dpkg-reconfigure tzdata
RUN apt-get update && apt-get install -y --no-install-recommends \
 build-essential\
 git\
 ca-certificates\
 libjpeg8-dev\
 libjpeg8\
 libldap2-dev\
 libsasl2-dev\
 libxslt1.1\
 python-imaging\
 python-lxml\
 python-openid\
 python-psycopg2\
 python-pychart\
 python-simplejson\
 python-virtualenv\
 python2.7-dev\
 python\
 wget\
 zlib1g-dev\
 zlib1g\
 && apt-get clean\
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/odoo
USER codekaki

ENV CID=2326bb7
RUN mkdir 7.0 &&\
 wget http://172.17.0.1:8000/odoo/$CID.tar.gz &&\
 wget -P conf http://172.17.0.1:8000/conf/openerp-server.conf &&\
 tar xzf $CID.tar.gz -C 7.0 &&\
 rm $CID.tar.gz

RUN virtualenv --system-site-packages env &&\
 . env/bin/activate &&\
 pip install --allow-all-external --allow-unverified PIL 7.0/

VOLUME ["/opt/odoo/extras", "/opt/odoo/conf"]

EXPOSE 8069 8071
ENTRYPOINT ["/opt/odoo/7.0/openerp-server"]
CMD ["-c", "conf/openerp-server.conf"]
