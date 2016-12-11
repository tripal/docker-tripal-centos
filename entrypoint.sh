#!/bin/bash

## start apache
rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/httpd && sleep 5

## start postgresql
rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 30

## start the default elasticsearch cluster
/etc/init.d/elasticsearch start && sleep 3

## start a cluster with three nodes
/etc/init.d/elasticsearch_${NODE_NAME_01} start && sleep 3 # port=9201 
/etc/init.d/elasticsearch_${NODE_NAME_02} start && sleep 3 # port=9202
/etc/init.d/elasticsearch_${NODE_NAME_03} start && sleep 3 # port=9203
/etc/init.d/elasticsearch_${NODE_NAME_04} start && sleep 3 # port=9204
/etc/init.d/elasticsearch_${NODE_NAME_05} start && sleep 3 # port=9205

## 
sh -c "$@"
