#!/bin/bash

## start postgresql
rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ > /dev/null 2>&1
echo
echo "Starting database..."
sleep 20


# enable tripal galaxy
drush en -y tripal_galaxy

## start a cluster with two nodes
#/etc/init.d/elasticsearch_node-01 start && sleep 3 # port=9201
#/etc/init.d/elasticsearch_node-02 start && sleep 3 # port=9202

##
# sh -c "$@"
## start apache
rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/httpd -DFOREGROUND