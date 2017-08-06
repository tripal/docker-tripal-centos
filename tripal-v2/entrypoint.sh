#!/bin/bash

## start apache
rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/httpd && sleep 5
echo
echo "starting httpd ..."
echo

## start postgresql
rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/
echo
echo "starting database ..."
echo
sleep 60


## start a cluster with two nodes
/etc/init.d/elasticsearch_node-01 start && sleep 3 # port=9201
/etc/init.d/elasticsearch_node-02 start && sleep 3 # port=9202

## 
sh -c "$@"
