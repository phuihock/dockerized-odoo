FROM phuihock/ubuntu:14.04.2_u150724.232741
MAINTAINER Chang Phui-Hock <phuihock@codekaki.com>
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/openerp/env/bin:$PATH
EXPOSE 8069
VOLUME /opt/openerp/extras
VOLUME /opt/openerp/openerp-server.conf

WORKDIR /opt/openerp

RUN echo "UTC" > /etc/timezone && dpkg-reconfigure tzdata
RUN apt-get install -y\
 build-essential\
 libjpeg8\
 libjpeg8-dev\
 libldap2-dev\
 libsasl2-dev\
 libxslt1.1\
 libzmq3\
 libzmq3-dev\
 zlib1g\
 zlib1g-dev\
 python\
 python-imaging\
 python-lxml\
 python-openid\
 python-psycopg2\
 python-pychart\
 python-simplejson\
 python-virtualenv\
 python2.7-dev;\
 apt-get autoclean

COPY odoo .
RUN useradd -m -d /opt/openerp -s /bin/bash -G www-data codekaki
RUN chown -R codekaki:codekaki .
USER codekaki
RUN virtualenv --system-site-packages env && . env/bin/activate && pip install --allow-all-external --allow-unverified PIL .

ENTRYPOINT ["/opt/openerp/openerp-server"]
CMD ["-c", "openerp-server.conf"]
