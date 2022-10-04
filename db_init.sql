-- !preview conn=DBI::dbConnect(RSQLite::SQLite())
# port is host:container
# docker run --name docked-postgis -p 5434:5432 -e POSTGRES_PASSWORD=kubexapa -d postgis/postgis
# container is the standard postgres port, host is whatever you want
# for every new table you need to enable the postgis extension
# docker exec -ti some-postgis psql -U postgres
# docker exec -ti docked-postgis psql -U postgres -d vic -c "CREATE EXTENSION postgis;"

CREATE DATABASE vic
