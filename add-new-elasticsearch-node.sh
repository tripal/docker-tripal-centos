#!/bin/bash

NODE_NAME=$1
PORT=$2

## make a copy of init script of elasticsearch
cp -r /etc/init.d/elasticsearch "/etc/init.d/elasticsearch_${NODE_NAME}"
## make a copy of log directory
cp -r /var/log/elasticsearch "/var/log/elasticsearch_${NODE_NAME}" && chown -R elasticsearch:elasticsearch "/var/log/elasticsearch_${NODE_NAME}" 
## make a copy of data path
cp -r /var/lib/elasticsearch "/var/lib/elasticsearch_${NODE_NAME}" && chown -R elasticsearch:elasticsearch "/var/lib/elasticsearch_${NODE_NAME}"
## make a copy of configure file directory
cp -r /etc/elasticsearch "/etc/elasticsearch_${NODE_NAME}" && chown -R elasticsearch:elasticsearch "/etc/elasticsearch_${NODE_NAME}"
## make a copy of elasticsearch.pid file directory
cp -r /var/run/elasticsearch "/var/run/elasticsearch_${NODE_NAME}" && chown -R elasticsearch:elasticsearch "/var/run/elasticsearch_${NODE_NAME}"

## associate the copy of init script of elasticsearch with the new log, data, configure and pid path
sed  -i "s|LOG_DIR=\"/var/log/elasticsearch\"|LOG_DIR=\"/var/log/elasticsearch_${NODE_NAME}\"|g" "/etc/init.d/elasticsearch_${NODE_NAME}" 
sed  -i "s|DATA_DIR=\"/var/lib/elasticsearch\"|DATA_DIR=\"/var/lib/elasticsearch_${NODE_NAME}\"|g" "/etc/init.d/elasticsearch_${NODE_NAME}"
sed  -i "s|CONF_DIR=\"/etc/elasticsearch\"|CONF_DIR=\"/etc/elasticsearch_${NODE_NAME}\"|g" "/etc/init.d/elasticsearch_${NODE_NAME}"
sed  -i "s|PID_DIR=\"/var/run/elasticsearch\"|PID_DIR=\"/var/run/elasticsearch_${NODE_NAME}\"|g" "/etc/init.d/elasticsearch_${NODE_NAME}"


cd /etc/elasticsearch_"${NODE_NAME}"
echo "cluster.name : ${CLUSTER_NAME}" > elasticsearch.yml
echo "node.name : ${NODE_NAME}" >> elasticsearch.yml
echo "path.data : /var/lib/elasticsearch_${NODE_NAME}" >> elasticsearch.yml
echo "path.logs : /var/log/elasticsearch_${NODE_NAME}" >> elasticsearch.yml
echo "network.host : 0.0.0.0" >> elasticsearch.yml
echo "http.port : ${PORT}" >> elasticsearch.yml
echo "bootstrap.memory_lock : true" >> elasticsearch.yml
echo "discovery.zen.ping.unicast.hosts: ['0.0.0.0:9201', '0.0.0.0:${PORT}']" >> elasticsearch.yml
echo "discovery.zen.minimum_master_nodes: ${MINIMUM_MASTER_NODES}" >> elasticsearch.yml

chown elasticsearch:elasticsearch elasticsearch.yml

