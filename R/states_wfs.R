# Get state boundaries from the ABS feature service
library(sf)
library(leaflet)
library(terra)

#https://geo.abs.gov.au:443/arcgis/services/ASGS2021/STE/MapServer/WFSServer
#VicmapR::check_geoserver()
#listLayers(pattern = "ele", ignore.case = T)
#melbourne <- sf::st_read(system.file("shapes/melbourne.geojson", package="VicmapR"), quiet = T)
#elevation <- vicmap_query(layer = "datavic:VMELEV_EL_CONTOUR") %>%
#typeof(elevation[[1]])
#elevation_trans <- st_transform(elevation,4326)
#elevation_points <- elevation_trans
# First create an empty template
# then use the rasterize function to map the vector to the raster data.
elevation_raster <- er %>% raster()
crs(elevation_raster) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

m <- leaflet() %>% addTiles() %>% #setView(-93.65, 42.0285, zoom = 4) %>%
  addPolygons(data=melbourne) %>%
 # addPolygons(data=elevation_vector) %>%
  addMarkers(data=elevation_points) %>%
  #addWMSTiles(
  #  "https://base.maps.vic.gov.au/service?",
  #  layers = "CARTO_WM",
  #  options = WMSTileOptions(format = "image/png", transparent = TRUE),
  #  attribution = "VicMap"
  #) %>%
m
