#!/bin/bash

rm -rf /var/lib/pgsql/data/postmaster.pid
sudo -u pg_ctl start -D /var/lib/pgsql/data/
sleep 15
