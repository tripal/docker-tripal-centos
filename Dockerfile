# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest


## Install elasticsearch
ADD elasticsearch.repo /etc/yum.repos.d/
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum update -y && yum install -y elasticsearch initscripts sudo which java-1.8.0-openjdk.x86_64

ADD start-new-elasticsearch-cluster.sh /
RUN sh /start-new-elasticsearch-cluster.sh myCluster01 9201
