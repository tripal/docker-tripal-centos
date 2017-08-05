## `docker-tripal-v3` image

The `docker-tripal-v3` image has Tripal v3 installed on centos system. It
also runs an Elasticsearch cluster. The chado v1.3 has been installed and
site preparation step executed. To run a Tripal instance, you just need
to run the following command:

```
docker run -it -p 8080:80 mingchen0919/docker-tripal-v3 /bin/bash
```

This command will launch an interactive docker container with apache, postgres
and an Elasticsearch cluster running. With this docker image, you can easily 
set up a tripal 3 site for testing or tripal module development in just a couple
of minutes. Go to [http://127.0.0.1:8080/](http://127.0.0.1:8080/) and login
to the tripal site as an admin user.

## Mount a local directory for custom modules

If you mount a local directory to the custom module directory in your docker container,
you will be able to edit files on your local machine. And any changes will be reflected
on your container. A big advantage is that you can use your local editor (for instance, phpstorm) 
to open and edit files.

```
docker run -it -p 8080:80 \
  -v /Users/mingchen/google_drive/projects/docker-volume-tripal-modules/tripal_Elasticsearch:/var/www/html/sites/all/modules/tripal_Elasticsearch \
  mingchen0919/docker-tripal-v3 /bin/bash
```

## Account names and passwords

* Tripal site admin username: admin
* Tripal site password: admin
* Postgres database name: tripal_db
* Postgres database username: tripal
* Postgres database password: tripal_db_passwd

## Elsticsearch

Use the following command lines to check the status of running Elasticsearch
clusters

```
curl localhost:9201/_cat/health?v
curl localhost:9202/_cat/health?v
```

## Install Drupal/Tripal modules

```
cd /var/www/html/sites/all/modules

## install tripal_Elasticsearch
git clone https://github.com/tripal/tripal_Elasticsearch.git
drush en tripal_Elasticsearch -y

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
* Lanuch a tripal site with the *docker-tripal-v3* image

```
docker run -it -p 8080:80 mingchen0919/docker-tripal-v3 /bin/bash
```

* When the launching process is done, you can go to [http://your.jetstream.image.ip:8080/](http://your.jetstream.image.ip:8080/)
