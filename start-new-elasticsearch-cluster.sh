## /bin/bash

clusterName=$1
PORT=$2

cp -r /etc/init.d/elasticsearch "/etc/init.d/elasticsearch_"$clusterName && \
cp -r /var/log/elasticsearch "/var/log/elasticsearch_"$clusterName && chown -R elasticsearch:elasticsearch "/var/log/elasticsearch_"$clusterName \
cp -r /var/lib/elasticsearch "/var/lib/elasticsearch_"$clusterName && chown -R elasticsearch:elasticsearch "/var/lib/elasticsearch_"$clusterName \
cp -r /etc/elasticsearch "/etc/elasticsearch_"$clusterName && chown -R elasticsearch:elasticsearch "/etc/elasticsearch_"$clusterName \
cp -r /var/run/elasticsearch "/var/run/elasticsearch_"$clusterName && chown -R elasticsearch:elasticsearch "/var/run/elasticsearch_"$clusterName

sed  -i "s|LOG_DIR=\"/var/log/elasticsearch\"|LOG_DIR=\"/var/log/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName && \
  sed  -i "s|DATA_DIR=\"/var/lib/elasticsearch\"|DATA_DIR=\"/var/lib/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName && \
  sed  -i "s|CONF_DIR=\"/etc/elasticsearch\"|CONF_DIR=\"/etc/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName && \
  sed  -i "s|PID_DIR=\"/var/run/elasticsearch\"|LOG_DIR=\"/var/run/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName

cd "/etc/elasticsearch_"$clusterName && \
  sed -i "s|^# cluster\.name\:.*|cluster\.name\: ${clusterName}|g" elasticsearch.yml && \
  sed -i "s|^# path\.data\:.*|path\.data\: \"/var/lib/elasticsearch_${clusterName}\"|g" elasticsearch.yml && \
  sed -i "s|^# path\.logs\:.*|path\.logs\: \"/var/log/elasticsearch_${clusterName}\"|g" elasticsearch.yml && \
  sed -i "s|^# network\.host\:.*|network\.host\: localhost|g" elasticsearch.yml $$ \
  sed -i "s|^# http\.port\:.*|http\.port\: ${PORT}|g" elasticsearch.yml && chown elasticsearch:elasticsearch elasticsearch.yml

"/etc/init.d/elasticsearch_"$clusterName start
