library(tidyverse)
library(leaflet)
library(DBI)
library(RPostgres)
library(sf)
library(sp)
library(rgdal)
# Connect to the default postgres database
con <- dbConnect(RPostgres::Postgres(),
                 dbname = 'vic',
                 host = 'localhost',
                 port = 5432,
                 user = 'postgres',
                 password = 'password')
dbListTables(con)
con

lga <- st_read(con,layer="lga_2020")

# Can do PostGIS queries
#query <- paste('SELECT "LGA_CODE22", "LGA_NAME22", "GEOMETRY"',
#               'FROM "lga_2020"',
#               'WHERE "STE_NAME21" = "Victoria";'
#)
library(dbplyr)
tbl(con,'lga_2020') %>% filter(STE_NAME21 == 'Victoria') %>% dplyr::show_query()
vic_lga <- st_read(con,query=query)

# Get some information
st_geometry_type(lga_raw)
sf::st_crs(lga_raw)
class(lga_raw)
sf_proj_info(type = "proj", lga)

# Fails
#m <- leaflet(lga_raw) %>% addPolygons(data=lga_raw$geom) %>% addProviderTiles(providers$CartoDB.Positron)

lga_trans <- st_transform(st_as_sf(lga),4326)
#lga_trans <-lga %>% st_transform(lga,crs = st_crs(lga))
#lga_trans <-lga %>% st_as_sf() %>%  st_transform(lga,crs = "+proj=longlat +ellps=WGS84 +datum=WGS84")

simplified <- rmapshaper::ms_simplify(fullsize)

m <- leaflet(lga_trans) %>% addPolygons(data=lga_trans$geom) %>% addTiles() %>%
  addWMSTiles(
    "https://base.maps.vic.gov.au/service?",
    layers = "CARTO_WM",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "VicMap"
  )
m



