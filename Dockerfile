# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest

## Install elasticsearch
ENV CLUSTER01=myCluster01
ENV PORT01=9201
ENV CLUSTER02=myCluster02
ENV PORT02=9202
ENV CLUSTER03=myCluster03
ENV PORT03=9203
ENV CLUSTER04=myCluster04
ENV PORT01=9204
ENV CLUSTER05=myCluster05
ENV PORT05=9205
ADD elasticsearch.repo /etc/yum.repos.d/
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch \
    && yum update -y \
    && yum groupinstall -y "Development tools" \
    && yum install -y elasticsearch initscripts sudo which wget \
    java-1.8.0-openjdk.x86_64 postgresql-server httpd 

## Install php5.6
RUN yum install -y php \
    && cd /tmp && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && rpm -Uvh epel-release-latest-7.noarch.rpm \
    && wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    && rpm -Uvh remi-release-7.rpm
     

## Build 5 elasticsearch clusters
ADD start-new-elasticsearch-cluster.sh /
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER01 $PORT01
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER02 $PORT02
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER03 $PORT03
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER04 $PORT04
RUN sh /start-new-elasticsearch-cluster.sh $CLUSTER05 $PORT05

## Install postgresql
ENV TRIPAL_PG_USER=tripal
ENV TRIPAL_PG_DB=tripal_db
#ENV $TRIPAL_PG_PASSWD=tripal
RUN yum install -y postgresql-server

USER postgres

RUN initdb -D /var/lib/pgsql/data/
ADD pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
ADD postgresql.conf /var/lib/pgsql/data/postgresql.conf
RUN pg_ctl start -D /var/lib/pgsql/data/ \
    && sleep 5 \ 
    && psql -c "CREATE USER $TRIPAL_PG_USER WITH PASSWORD 'tripal_db_passwd';" \
    && createdb $TRIPAL_PG_DB -O $TRIPAL_PG_USER

## Upgrade php from default 5.4 to 5.6
USER root
ADD remi.repo /etc/yum.repos.d/remi.repo
RUN yum upgrade -y php* \
    && yum install -y php-gd php-pgsql php-mbstring php-xml php-pecl-json

## Install drush
RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush \
    && chmod +x drush \
    && mv drush /usr/local/bin \
    && yes | drush init


EXPOSE 80
EXPOSE 5432
