# docker-elasticsearch-multiple-cluster

Run multiple elasticsearch clusters on a centos machine.


## Run an interactive container

```
docker run -it mingchen0919/elasticsearch-multi-clusters /bin/bash
```

## Start new elasticsearch clusters

```
/etc/init.d/elasticsearch_myCluster01 start
/etc/init.d/elasticsearch_myCluster02 start
/etc/init.d/elasticsearch_myCluster03 start
/etc/init.d/elasticsearch_myCluster04 start
/etc/init.d/elasticsearch_myCluster05 start
```

## Start the postgres server

```
sudo -u postgres start -D /var/lib/pgsql/data/
```
