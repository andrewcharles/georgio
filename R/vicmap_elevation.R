# Focus in particular on the elevation layer provided by Vicmap

library(VicmapR)
library(sf)
library(leaflet)
library(terra)

VicmapR::check_geoserver()
listLayers(pattern = "ele", ignore.case = T)

melbourne <- sf::st_read(system.file("shapes/melbourne.geojson", package="VicmapR"), quiet = T)
#elevation <- vicmap_query(layer = "datavic:VMELEV_EL_CONTOUR") %>%
elevation <- vicmap_query(layer = "datavic:VMELEV_EL_GRND_SURFACE_POINT") %>%
#elevation <- vicmap_query(layer = "datavic:VMELEV_EL_GRND_TYPE_POINT") %>%
#elevation <- vicmap_query(layer = "datavic:VMELEV_EL_GRND_SURFACE_POINT_1TO5M") %>%
  filter(INTERSECTS(melbourne)) %>% # more advanced geometric filter
  collect()
elevation
typeof(elevation[[1]])

elevation_trans <- st_transform(elevation,4326)
elevation_points <- elevation_trans

# First create an empty template
# then use the rasterize function to map the vector to the raster data.
raster_template <- elevation_trans %>% terra::rast()
er <- terra::rasterize(elevation_trans,raster_template,fun=mean,field='ALTITUDE')
er2 <- terra::rasterize(elevation_trans,raster_template,field='ALTITUDE')
class(er)
values(er)
plot(er)
plot(er2)
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
  addRasterImage(elevation_raster, opacity = 0.5)
m

