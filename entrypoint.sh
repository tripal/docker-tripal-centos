#!/bin/bash

export CLUSTER01=myCluster01
export PORT01=9201
export CLUSTER02=myCluster02
export PORT02=9202
export CLUSTER03=myCluster03
export PORT03=9203
export CLUSTER04=myCluster04
export PORT01=9204
export CLUSTER05=myCluster05
export PORT05=9205

sh /start-new-elasticsearch-cluster.sh $CLUSTER01 $PORT01
sh /start-new-elasticsearch-cluster.sh $CLUSTER02 $PORT02
sh /start-new-elasticsearch-cluster.sh $CLUSTER03 $PORT03
sh /start-new-elasticsearch-cluster.sh $CLUSTER04 $PORT04
sh /start-new-elasticsearch-cluster.sh $CLUSTER05 $PORT05


