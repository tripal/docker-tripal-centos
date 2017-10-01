# Multiple elasticsearch cluster
#
# Version 0.1

FROM centos:latest


##======== Elasticsearch =================
## Includes:
##		- elasticsearch
##		- Development tools
##		- java 1.8
##========================================
ADD elasticsearch/elasticsearch.repo /etc/yum.repos.d/
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum update -y && \
    yum groupinstall -y "Development tools" && \
    yum install -y elasticsearch initscripts sudo which wget java-1.8.0-openjdk.x86_64
##========================================



##======== Apache ========================
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all
##========================================

##======= Install php5.6 =================
## Includes:
##		- install default php5.4
##		- upgrade php5.4 to php5.6
##		- install other required php extensions
##========================================
RUN yum install -y php && \
    cd /tmp && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh epel-release-latest-7.noarch.rpm && \
    wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    rpm -Uvh remi-release-7.rpm

## Upgrade php from default 5.4 to 5.6
USER root
ADD php5.6/remi.repo /etc/yum.repos.d/remi.repo
RUN yum upgrade -y php* && \
    yum install -y php-gd php-pgsql php-mbstring php-xml php-pecl-json
##========================================   



##=========== Postgresql =================
## Includes:
##		- install postgresql-server
##		- initiate database
##		- create database and database user
##========================================
ENV TRIPAL_PG_USER=tripal \
     TRIPAL_PG_DB=tripal_db
RUN yum install -y postgresql-server

USER postgres

RUN initdb --encoding=UTF8 -D /var/lib/pgsql/data/
ADD postgresql/* /var/lib/pgsql/data/
RUN pg_ctl start -D /var/lib/pgsql/data/ && sleep 5 && \
    psql -c "CREATE USER $TRIPAL_PG_USER WITH PASSWORD 'tripal_db_passwd';" && \
    createdb --encoding=UTF8 $TRIPAL_PG_DB -O $TRIPAL_PG_USER
##=========================================



##========= Drush =========================
USER root
RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush && \
    chmod +x drush && \
    mv drush /usr/local/bin && \
    yes | drush init
##=========================================



##========= Drupal and Tripal ========================
## Install drupal
## You must have postgres server running before you can install drupal. Remember that each
## instruction in a Dockerfile builds a layer (running a container), when the execution of
## of instruction finish, the intermediate container will be removed. Therefore all the
## connections will lose. So you have to run any dependent servers within the same layer.
##=========================================
RUN sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers
ADD apache/httpd.conf /etc/httpd/conf/httpd.conf
WORKDIR /var/www/html
RUN git clone https://github.com/tripal/tripal_install.git && \
    mv tripal_install/* ./
RUN sed -i 's/.*Name of the site.*/\$site_name = "Tripal V3";/g' tripal_install.drush.inc && \
    sed -i 's/.*Admin email for the site.*/\$site_email = "admin@gmail.com";/g' tripal_install.drush.inc && \
    sed -i 's/.*Name for your admin user on the site.*/\$username = "admin";/g' tripal_install.drush.inc && \
    sed -i 's/.*Password for the admin user.*/\$user_password = "P@55w0rd";/g' tripal_install.drush.inc && \
    sed -i 's/.*site_settings.*Is this information correct.*/\$site_settings = TRUE;/g' tripal_install.drush.inc && \
    sed -i 's/.*database name.*/\$database = "tripal_db";/g' tripal_install.drush.inc && \
    sed -i 's/.*postgres username.*/\$postgres_username = "tripal";/g' tripal_install.drush.inc && \
    sed -i 's/.*postgres password.*/\$postgres_password = "tripal_db_passwd";/g' tripal_install.drush.inc && \
    sed -i 's/.*like localhost.*/\$host = "127.0.0.1";/g' tripal_install.drush.inc && \
    sed -i 's/.*settings_php.*Is this information correct.*/\$settings_php = TRUE;/g' tripal_install.drush.inc && \
    sed -i 's/.*Which version of Chado would you like installed.*/\$version = "Install Chado v1.3";/g' tripal_install.drush.inc
RUN rm -rf /var/lib/pgsql/data/postmaster.pid && \
	sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 30 && \
    drush --include=. tripal-generic-install && \
    drush en -y devel admin_menu && \
    drush dis -y toolbar


##=== Install some linux tools ====================================
RUN sudo yum install vim cronie htop iotop -y
##=================================================================

##==== Build two elasticsearch clusters, each has two nodes =======
ADD add-elasticsearch-instance.sh /add-elasticsearch-instance.sh
RUN sh /add-elasticsearch-instance.sh my-cluster node-01 9201 2 && \
    sh /add-elasticsearch-instance.sh my-cluster node-02 9202 2
##========================================

EXPOSE 5432

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
