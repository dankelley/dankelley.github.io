## -----------------------------------------------------------------------------
library(oce)
library(proj4)
library(mapproj)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]


## ----projection-existing, fig.height=4, dpi=100-------------------------------
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- mapproject(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
plot(xy$x, xy$y, type='l', asp=1)


## ----projection-proposed, fig.height=4, dpi=100-------------------------------
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- project(cbind(lon,lat), "+proj=moll")
plot(xy[,1], xy[,2], type='l', asp=1)

