#!/bin/bash

## start apache
/usr/sbin/httpd && sleep 5

## start postgresql
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 15

## start the default elasticsearch cluster
/etc/init.d/elasticsearch start && sleep 3

## start three of the five custom elasticsearch cluster
/etc/init.d/elasticsearch_myCluster01 start && sleep 3 # port=9201 
/etc/init.d/elasticsearch_myCluster02 start && sleep 3 # port=9202
/etc/init.d/elasticsearch_myCluster03 start && sleep 3 # port=9203

## 
sh -c "$@"
