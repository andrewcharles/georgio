# install DB on linux
https://harshityadav95.medium.com/postgresql-in-windows-subsystem-for-linux-wsl-6dc751ac1ff3
sudo apt-get install postgresql
sudo apt-get install postgis

sudo service postgresql start
sudo -u postgres psql
su - postgres
psql
psql -f my_sql_filename.sql
psql -h localhost -p 5432 -U postgres -f stuff.sql
# https://badcodernocookie.com/psql-run-sql-file-from-command-line/
# https://www.cybertec-postgresql.com/en/postgresql-on-wsl2-for-windows-install-and-setup/
sudo -u postgres createuser
edit postgresql.conf;
# uncomment (sic!) listen_address line;
# change it to listen_address = '*' for every available IP address or comma-separated list of addresses;
# restart the PostgreSQL instance, so the new settings take effect.
# Also must edit the hba file
sudo vim /etc/postgresql/12/main/pg_hba.conf
host    all             all             0.0.0.0/0              peer
host    all             all             ::/0                   peer
