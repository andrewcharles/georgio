-- SQL commands to setup database
create user postgres;
CREATE EXTENSION postgis;
CREATE DATABASE vic;
grant all privileges on database vic to postgres
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;
-- CREATE table_name
-- raster2pgsql -U postgres
