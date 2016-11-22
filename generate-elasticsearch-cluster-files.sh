## /bin/bash

clusterName=$1

sudo cp -r /etc/init.d/elasticsearch "/etc/init.d/elasticsearch_"$clusterName
sed  "s|LOG_DIR=\"/var/log/elasticsearch\"|LOG_DIR=\"/var/log/elasticsearch_${clusterName}\"|g" "/etc/init.d/elasticsearch_"$clusterName && \\
sed  "s|LOG_DIR=\"/var/lib/elasticsearch\"|LOG_DIR=\"/var/lib/elasticsearch_${clusterName}\"|g" "/var/lib/elasticsearch_"$clusterName && \\
sed  "s|LOG_DIR=\"/etc/elasticsearch\"|LOG_DIR=\"/etc/elasticsearch_${clusterName}\"|g" "/etc/elasticsearch_"$clusterName && \\
sed  "s|LOG_DIR=\"/var/log/elasticsearch\"|LOG_DIR=\"/var/log/elasticsearch_${clusterName}\"|g" "var/log/elasticsearch_"$clusterName && \\
sed "s|/var/run/elasticsearch|/var/run/elasticsearch|g"



sudo cp -r /var/lib/elasticsearch "/var/lib/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/lib/elasticsearch_"$clusterName
sudo cp -r /etc/elasticsearch "/etc/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/etc/elasticsearch_"$clustername
sudo cp -r /var/log/elasticsearch "/var/log/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/log/elasticsearch_"$clustername
sudo cp -r /var/run/elasticsearch "/var/run/elasticsearch_"$clusterName && sudo chown -R elasticsearch:elasticsearch "/var/run/elasticsearch_"$clustername
