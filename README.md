# docker-elasticsearch-multiple-cluster

Run multiple elasticsearch clusters on a centos machine.


## Run an interactive container

```
docker run -it mingchen0919/docker-elasticsearch-multiple-cluster:dev01 /bin/bash
```

## Start new elasticsearch clusters

The following command lines start three clusters: `myCluster01`, `myCluster02` and `myCluster03` on port `9201`, `9202` and `9203`, respectively.

```
/start-new-elasticsearch-cluster.sh myCluster01 9201
/start-new-elasticsearch-cluster.sh myCluster02 9202
/start-new-elasticsearch-cluster.sh myCluster03 9203
```
