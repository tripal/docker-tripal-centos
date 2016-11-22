## /bin/bash

clusterName=$1
PORT=$2

sudo cp -r /etc/init.d/elasticsearch "/etc/init.d/elasticsearch_"$clusterName
sed  -i "s|LOG_DIR=\"/var/log/elasticsearch\"|LOG_DIR=\"/var/log/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName && \\
  sed  -i "s|DATA_DIR=\"/var/lib/elasticsearch\"|DATA_DIR=\"/var/lib/elasticsearch_${clusterName}\"|g" "/var/lib/elasticsearch_"$clusterName && \\
  sed  -i "s|CONFIG_DIR=\"/etc/elasticsearch\"|CONFIG_DIR=\"/etc/elasticsearch_${clusterName}\"|g" "/etc/elasticsearch_"$clusterName && \\
  sed  -i "s|PID_DIR=\"/var/run/elasticsearch\"|LOG_DIR=\"/var/run/elasticsearch_${clusterName}\"|g" "var/run/elasticsearch_"$clusterName

sudo cp -r /var/lib/elasticsearch "/var/lib/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/lib/elasticsearch_"$clusterName
sudo cp -r /etc/elasticsearch "/etc/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/etc/elasticsearch_"$clustername
cd "/etc/elasticsearch_"$clustername && \\
  sed "s|^# cluster\.name\:.*|cluster\.name\: ${clusterName}|g" elasticsearch.yml && \\
  sed "s|^# path\.data\:.*|path\.data\: \"/var/lib/elasticsearch_${clusterName}\"|g" elasticsearch.yml && \\
  sed "s|^# path\.logs\:.*|path\.logs\: \"/var/log/elasticsearch_${clusterName}\"|g" elasticsearch.yml && \\
  sed "s|^# network\.host\:.*|network\.host\: localhost|g" elasticsearch.yml $$ \\
  sed "s|^# http\.port\:.*|http\.port\: ${PORT}|g" elasticsearch.yml && chown elasticsearch:elasticsearch elasticsearch.yml
sudo cp -r /var/log/elasticsearch "/var/log/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/log/elasticsearch_"$clustername
sudo cp -r /var/run/elasticsearch "/var/run/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/run/elasticsearch_"$clustername


"/etc/init.d/elasticsearch_"$clusterName start
