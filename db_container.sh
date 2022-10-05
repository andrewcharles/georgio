#docker run --name docked-postgis -e POSTGRES_PASSWORD=kubexapa -d postgis/postgis -p 5432:5434
docker run --name docked-postgis -p 5432:5432 -e POSTGRES_PASSWORD=password -d postgis/postgis
docker exec -ti some-postgis psql -U postgres
# docker volume create --name postgres_data
