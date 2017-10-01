# Tripal docker images

This repository builds docker images for Tripal v2 and Tripal v3 installed upon Drupal 7.56 with PostGreSQL database.

# Launch Tripal site

The two docker images are available from [Docker hub](https://hub.docker.com/).

* Docker image for Tripal 2: `mingchen0919/docker-tripal-v2`
* Docker image for Tripal 3: `mingchen0919/docker-tripal-v3`

## Launch a Tripal 2 site

The command line below will launch an interactive docker container with a Tripal 2 site displayed on [http://127.0.0.1:8080/](http://127.0.0.1:8080/)

```
docker run -it -p 8080:80 mingchen0919/docker-tripal-v2 /bin/bash
```

## Account names and passwords for Tripal 2 site

* Tripal site admin username: `admin`
* Tripal site password: `admin`
* Postgres database name: `tripal_db`
* Postgres database username: `tripal`
* Postgres database password: `tripal_db_passwd`

## Launch a Tripal 3 site

The command line below will launch an interactive docker container with a Tripal 3 site displayed on [http://127.0.0.1:8080/](http://127.0.0.1:8080/)

```
docker run -it -p 8080:80 mingchen0919/docker-tripal-v3 /bin/bash
```

## Account names and passwords for Tripal 3 site

* Tripal site admin username: `admin`
* Tripal site password: `P@55w0rd`
* Postgres database name: `tripal_db`
* Postgres database username: `tripal`
* Postgres database password: `tripal_db_passwd`

## Restart httpd

Sometimes when you stop the docker container and then restart it, the httpd may stop working. To restart httpd, run the following command within the container:

```
/usr/sbin/httpd
```
