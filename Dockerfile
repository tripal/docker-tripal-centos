# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest

## Install elasticsearch
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && yum update -y && \
        yum install -y elasticsearch

ADD start-new-elasticsearch-cluster.sh /home/elasticsearch/
RUN sh /home/elasticsearch/start-new-elasticsearch-cluster.sh myCluster01 9021 && \\
    sh /home/elasticsearch/start-new-elasticsearch-cluster.sh myCluster02 9022 && \\
    sh /home/elasticsearch/start-new-elasticsearch-cluster.sh myCluster03 9023
