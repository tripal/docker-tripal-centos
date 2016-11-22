# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest

## Install elasticsearch
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && yum update -y && \
        yum install -y elasticsearch
