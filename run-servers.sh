#!/bin/bash

rm -rf /run/httpd/* /tmp/httpd* && \
  exec /usr/sbin/apachectl && \
  sudo su - postgres && \
  pg_ctl start -D /var/lib/pgsql/data/ && sleep 15 && sudo su
