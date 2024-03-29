#!/bin/bash

__mod_user() {
usermod -G wheel postgres
}

__create_db() {
su --login postgres --command "/usr/bin/postgres -D /var/lib/pgsql/data -p 5432" &
sleep 10
ps aux 

su --login - postgres --command "psql -c \"CREATE USER candlepin with CREATEROLE superuser PASSWORD 'candlepin';\""
su --login - postgres --command "psql -c \"CREATE DATABASE candlepin;\""
su --login - postgres --command "psql -c \"\du;\""
}

# Call functions
__mod_user
__create_db
