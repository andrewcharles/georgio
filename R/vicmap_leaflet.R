library(VicmapR)
VicmapR::check_geoserver()
listLayers(pattern = "ele", ignore.case = T)

#system.file("shapes/melbourne.geojson", package="VicmapR")
elevation <- vicmap_query(layer = "datavic:VMELEV_EL_CONTOUR")

library(leaflet)

m <- leaflet() %>% addTiles() %>% #setView(-93.65, 42.0285, zoom = 4) %>%
  addWMSTiles(
    "https://base.maps.vic.gov.au/service?",
    layers = "CARTO_WM",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "VicMap"
  )
m
