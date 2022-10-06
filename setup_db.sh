# Installing and Setting up Postgres on Linux on Windows

# First install the packages
sudo apt-get install postgresql
sudo apt-get install postgis

# Check the service by running this command
sudo service postgresql start

# Administer the database using the psql commmand line utility
sudo -u postgres psql

# Can also run batched commands
psql -h localhost -p 5432 -U postgres -f stuff.sql

# If the postgres user doesn't already exist, create it
sudo -u postgres createuser

# To enable access from the Windows host, so that pgadmin can connect
# you need to edit two configuration files.

# edit postgresql.conf;
sudo vim /etc/postgresql/12/main/postgresql.conf
# uncomment listen_address line, and
# change it to this to listen for incoming connections from any IP
# listen_address = '*' 
# Restart the PostgreSQL instance, so the new settings take effect.
# To enable authentication from another host, edit this file
sudo vim /etc/postgresql/12/main/pg_hba.conf
# add these lines
# host    all             all             0.0.0.0/0              peer
# host    all             all             ::/0                   peer

# Guides and instructions from the grey literature online:
# https://harshityadav95.medium.com/postgresql-in-windows-subsystem-for-linux-wsl-6dc751ac1ff3
# https://badcodernocookie.com/psql-run-sql-file-from-command-line/
# https://www.cybertec-postgresql.com/en/postgresql-on-wsl2-for-windows-install-and-setup/