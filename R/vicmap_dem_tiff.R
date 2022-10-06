# Demonstrates loading a geoTIFF and displaying

imgdir <- "~/src/georgio/inst/extdata/vmelev_dem10m_Geotiff_GDA94_VicGrid"
imgname <- "vmelev_dem10m_Geotiff_GDA94_VicGrid.tif"
imgpath <- file.path(imgdir,imgname)
library(terra)
elevation_raster <- terra::rast(imgpath)
er <- elevation_raster
# this fails due to memory issue
# crds(er)
# potentially use terra options to fix this ...
# terraOptions(memfrac=0.3)
# this issue explains how https://github.com/rspatial/terra/issues/562

# This geotiff is in LCC coordinates
# project it to latitude/longitude

#https://gis.stackexchange.com/questions/142156/r-how-to-get-latitudes-and-longitudes-from-a-rasterlayer
#https://gis.stackexchange.com/questions/45263/converting-geographic-coordinate-system-in-r
#https://stackoverflow.com/questions/36453084/plot-lat-lon-coordinates-on-geotiff-in-r

library(tidyverse)
library(raster)
err<- elevation_raster%>% raster::raster()
r.pts <- rasterToPoints(err, spatial=TRUE)
proj4string(r.pts)

library(rgdal)
geo.prj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
r.pts <- spTransform(r.pts, CRS(geo.prj))
proj4string(r.pts)

crs(r)
# CRS arguments:
# +proj=stere +lat_0=90 +lat_ts=70 +lon_0=-45 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0

df <- data.frame(longitude = rep(22,7), latitude = seq(60,90,5), ID=1:7)

spdf <- SpatialPointsDataFrame(coords = df[,1:2], data = df,
                               proj4string = CRS("+proj=longlat +datum=WGS84"))

library(rgdal)
p <- spTransform(spdf, crs(r))

extract(r, p)

# To project to a new CRS
#newcrs ="+proj=robin +datum=WGS84"
#pr1 <- terra::project(demrast,newcrs)
# Plotting on basemaps
#library(maptiles)
#bg <- get_tiles(demrast$extent)
#plotRGB(bg)

library(sf)
library(leaflet)

# select a subset

# Again, the geotiff is much to pbig to display like this
m <- leaflet() %>% addTiles() %>% #setView(-93.65, 42.0285, zoom = 4) %>%
  leaflet::addRasterImage(elevation_raster%>% raster::raster(), opacity = 0.5)
m
