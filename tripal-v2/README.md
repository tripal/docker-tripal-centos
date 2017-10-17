## Account names and passwords

* Tripal site admin username: admin
* Tripal site password: admin
* Postgres database name: tripal_db
* Postgres database username: tripal
* Postgres database password: tripal_db_passwd

## Elsticsearch

Use the following command lines to check the status of running elasticsearch
clusters

```
curl localhost:9201/_cat/health?v
curl localhost:9202/_cat/health?v
curl localhost:9203/_cat/health?v
```

To start the fourth and fifth elasticsearch clusters

```
/etc/init.d/elasticsearch_myCluster04 start
/etc/init.d/elasticsearch_myCluster05 start
```

## Install Drupal/Tripal modules

```
cd /var/www/html/sites/all/modules

## install tripal_elasticsearch
git clone https://github.com/tripal/tripal_elasticsearch.git
drush en tripal_elasticsearch -y

## install tripal_analysis_expression
git clone https://github.com/tripal/tripal_analysis_expression.git
drush en tripal_analysis_expression -y

## install other drupal modules
drush dl devel -y && drush en devel -y
```

## Launch the image on cloud (Jetstream as an example)

First, you will need to launch a image and get docker installed. For example,
I launch a centos jetstream image and login to the image.

* Install docker: `sudo yum install -y docker`
* Start docker engine: `sudo service docker start`
* Lanuch a tripal site with the *docker-tripal-centos* image

```
docker run -it -p 8080:80 mingchen0919/docker-tripal-centos /bin/bash
```

* When the launching process is done, you can go to [http://your.jetstream.image.ip:8080/](http://your.jetstream.image.ip:8080/)
