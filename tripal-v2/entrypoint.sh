#!/bin/bash

## start apache
rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/httpd && sleep 5

## start postgresql
rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/
echo "starting database ..."
sleep 60

## start the default elasticsearch cluster
#/etc/init.d/elasticsearch start && sleep 3

## start a cluster with two nodes
/etc/init.d/elasticsearch_cluster-01-node-01 start && sleep 3 # port=9201 
/etc/init.d/elasticsearch_cluster-01-node-02 start && sleep 3 # port=9202 
##/etc/init.d/elasticsearch_cluster-02-node-01 start && sleep 3 # port=9203
##/etc/init.d/elasticsearch_cluster-02-node-02 start && sleep 3 # port=9204

## 
sh -c "$@"
