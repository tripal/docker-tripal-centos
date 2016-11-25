## `docker-tripal-centos` image

The `docker-tripal-centos` image has Tripal v2 installed on centos system. It
all runs 5 elasticsearch clusters. The chado v1.3 has been installed and
control vocabularies have been loaded. To run a Tripal instance, you just need
to run the following command:

```
docker run -it -p 8080:80 mingchen0919/mingchen0919/docker-tripal-centos
/bin/bash
```

This command will launch an interactive docker container with apache, postgres
and three elasticsearch clusters running. With this docker image, you can easily 
set up a tripal site for testing or tripal module development in just a couple
of minitues. Go to [http://127.0.0.1:8080/](http://127.0.0.1:8080/) and login
to the tripal site as an admin user.

## Account names and passwords

* Tripal site admin username: admin
* Tripal site password: admin
* Postgres database name: tripal_db
* Postgres database username: tripal
* Postgres database password: tripal_db_passwd




