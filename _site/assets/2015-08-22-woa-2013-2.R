## ------------------------------------------------------------------------
library(ncdf4)
con <- nc_open("woa13_decav_t00_01v2.nc")
## make a vector for later convenience
longitude <- as.vector(ncvar_get(con, "lon"))
latitude <- as.vector(ncvar_get(con, "lat"))
SST <- ncvar_get(con, "t_an")[,,1]
nc_close(con)
con <- nc_open("woa13_decav_s00_01v2.nc")
SSS <- ncvar_get(con, "s_an")[,,1]
nc_close(con)

## ----message=FALSE,warning=FALSE-----------------------------------------
library(oce)
data("levitus", package="ocedata")
library(MASS) # for truehist
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.5, 0))
dSST <- SST - levitus$SST
dSSS <- SSS - levitus$SSS

## ------------------------------------------------------------------------
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.5, 0))
data(coastlineWorld)
imagep(longitude, latitude, dSST, zlim=c(-3,3))
polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
        col='lightgray') 
mtext("SST change", side=3, adj=1)
imagep(longitude, latitude, dSSS, zlim=c(-3,3))
polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
        col='lightgray') 
mtext("SSS change", side=3, adj=1)

## ------------------------------------------------------------------------
imagep(longitude, latitude, dSST, zlim=c(-3,3), xlim=c(-90,-30), ylim=c(30, 90), asp=1)
polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
        col='lightgray') 
mtext("SST change", side=3, adj=1)
imagep(longitude, latitude, dSSS, zlim=c(-3,3), xlim=c(-90,-30), ylim=c(30, 90), asp=1)
polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
        col='lightgray') 
mtext("SSS change", side=3, adj=1)

