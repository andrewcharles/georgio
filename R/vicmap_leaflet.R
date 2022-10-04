library(VicmapR)
VicmapR::check_geoserver()
listLayers(pattern = "ele", ignore.case = T)

melbourne <- sf::st_read(system.file("shapes/melbourne.geojson", package="VicmapR"), quiet = T)
#elevation <- vicmap_query(layer = "datavic:VMELEV_EL_CONTOUR") %>%
elevation <- vicmap_query(layer = "datavic:VMELEV_EL_GRND_SURFACE_POINT") %>%
  filter(INTERSECTS(melbourne)) %>% # more advanced geometric filter
  collect()
elevation
typeof(elevation[[1]])

watercourse <- vicmap_query(layer = "datavic:VMHYDRO_WATERCOURSE_DRAIN") %>% # layer to query
  #filter(HIERARCHY == "L") %>% # simple filter for a column
  filter(INTERSECTS(melbourne)) %>% # more advanced geometric filter
  #select(HIERARCHY, PFI) %>%
  collect()

library(sf)
mylayer <- st_transform(st_as_sf(elevation$geometry),4326)
elevation_trans <- st_transform(elevation,4326)

elevation_points <- elevation_trans

library(leaflet)

library(stars)
#elevation_raster <- elevation %>% st_rasterize()
library(raster) # deprecated
elevation_raster <- elevation_trans %>% raster()

library(terra)
# First create an empty template
# then use the rasterize function to map the vector to the raster data.
raster_template <- elevation_trans %>% terra::rast()
er <- terra::rasterize(elevation_trans,raster_template,field='ALTITUDE')
class(er)
values(er)
plot(er)
elevation_raster <- er %>% raster()
crs(elevation_raster) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

m <- leaflet() %>% addTiles() %>% #setView(-93.65, 42.0285, zoom = 4) %>%
  #addPolygons(data=melbourne) %>%
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


