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



##========= Drupal ========================
## Install drupal
## You must have postgres server running before you can install drupal. Remember that each
## instruction in a Dockerfile builds a layer (running a container), when the execution of
## of instruction finish, the intermediate container will be removed. Therefore all the
## connections will lose. So you have to run any dependent servers within the same layer.
##=========================================
RUN sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers
ADD apache/httpd.conf /etc/httpd/conf/httpd.conf
ADD drupal/settings.php /tmp/settings.php
WORKDIR /var/www/html
RUN rm -rf /var/lib/pgsql/data/postmaster.pid && \
	sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 30 && \
	drush dl drupal-7.56 -y && \
    mv drupal*/* ./ && \
    mv drupal*/.htaccess ./ && \
    rm -rf drupal-7.56 && \
    chmod 777 sites/default/settings.php && \
    mkdir sites/default/files && chown -R apache:apache sites/default/files/ && \
    yum install sendmail -y && \
    yes | drush site-install --site-name="Tripal-V3"  --db-url=pgsql://tripal:tripal_db_passwd@localhost/tripal_db --account-name=admin --account-pass=admin -y && \
    cp /tmp/settings.php sites/default/settings.php && \
    chmod 555 sites/default/settings.php && \
##===========================================


##======== Tripal ===========================
## Includes:
##		- start postgresql server
##		- start apache server
##		- install tripal
##		- install chado database
##		- load OBO ontology
##===========================================
ADD chado_install_and_data_load_scripts /var/www/html/sites/all/modules/chado_install_and_data_load_scripts/
RUN rm -rf /var/lib/pgsql/data/postmaster.pid && \
    sudo -u postgres pg_ctl start -D /var/lib/pgsql/data/ && sleep 60 && \
    rm -f /usr/local/apache2/logs/httpd.pid && \
    /usr/sbin/httpd && sleep 5 && \
    drush dl entity -y && \
    drush en entity -y && \
    drush dl ctools views -y && \
    drush en ctools views views_ui -y && \
    drush dl date ds field_group field_group_table field_formatter_class field_formatter_settings -y && \
    drush en date ds field_group field_group_table field_formatter_class field_formatter_settings -y && \
    cd sites/all/modules && git clone -b 7.x-3.x https://github.com/tripal/tripal.git && \
    cd /var/www/html && wget --no-check-certificate https://drupal.org/files/drupal.pgsql-bytea.27.patch && \
    patch -p1 < drupal.pgsql-bytea.27.patch && \
    cd /var/www/html/sites/all/modules/views && \
    patch -p1 < ../tripal/tripal_chado_views/views-sql-compliant-three-tier-naming-1971160-22.patch && \
    drush en tripal -y && \
    drush en tripal_chado -y && \
    drush en tripal_ds tripal_ws -y && \
    drush php-script ../chado_install_and_data_load_scripts/install-chado-v-1.3.php && \
    	drush trp-run-jobs --username=admin --root=/var/www/html && \
    drush en tripal_ds tripal_ws -y 
    #drush php-script ../chado_install_and_data_load_scripts/OBO-loader.php && \
    #	drush trp-run-jobs --username=admin --root=/var/www/html
##============================================


##=== Install some linux tools ====================================
RUN sudo yum install vim cronie htop iotop -y 
##=================================================================



##==== Build two elasticsearch clusters, each has two nodes =======
ADD add-elasticsearch-instance.sh /add-elasticsearch-instance.sh
RUN sh /add-elasticsearch-instance.sh my-cluster node-01 9201 2 && \
    sh /add-elasticsearch-instance.sh my-cluster node-02 9202 2 && \
##========================================


RUN mkdir -p /var/www/html/sites/all/modules/custom
VOLUME ["/var/www/html/sites/all/modules/custom"]

EXPOSE 8080
EXPOSE 5432

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]