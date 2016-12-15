#!/bin/bash

## start apache
rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/httpd && sleep 5

## start postgresql
rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 30

## start the default elasticsearch cluster
#/etc/init.d/elasticsearch start && sleep 3

## start a cluster with three nodes
/etc/init.d/elasticsearch_cluster-01-node-1 start && sleep 3 # port=9201 
/etc/init.d/elasticsearch_cluster-01-node-2 start && sleep 3 # port=9202 
/etc/init.d/elasticsearch_cluster-01-node-3 start && sleep 3 # port=9203 
/etc/init.d/elasticsearch_cluster-02-node-4 start && sleep 3 # port=9204 
/etc/init.d/elasticsearch_cluster-02-node-5 start && sleep 3 # port=9205 
/etc/init.d/elasticsearch_cluster-02-node-6 start && sleep 3 # port=9206 

## 
sh -c "$@"
