## -----------------------------------------------------------------------------
library(oce)
# 1. Today's value at Halifax NS
magneticField(-(63+36/60), 44+39/60, Sys.Date())


## -----------------------------------------------------------------------------
data(coastlineWorld)
par(mar=rep(0.5, 4)) # no axes on whole-world projection
mapPlot(coastlineWorld, projection="+proj=robin", col="lightgray")
# Construct matrix holding declination
lon <- seq(-180, 180)
lat <- seq(-90, 90)
dec2000 <- function(lon, lat)
    magneticField(lon, lat, 2000)$declination
dec <- outer(lon, lat, dec2000) # hint: outer() is very handy!
# Contour, unlabelled for small increments, labeled for
# larger increments.
mapContour(lon, lat, dec, col='blue', levels=seq(-180, -5, 5),
           lty=3, drawlabels=FALSE)
mapContour(lon, lat, dec, col='blue', levels=seq(-180, -20, 20))
mapContour(lon, lat, dec, col='red', levels=seq(5, 180, 5),
           lty=3, drawlabels=FALSE)
mapContour(lon, lat, dec, col='red', levels=seq(20, 180, 20))
mapContour(lon, lat, dec, levels=180, col='black', lwd=2, drawlabels=FALSE)
mapContour(lon, lat, dec, levels=0, col='black', lwd=2)


## -----------------------------------------------------------------------------
lon <- seq(-180, 180)
lat <- seq(-90, 90)
decDiff <- function(lon, lat) {
    old <- magneticField(lon, lat, 2020, version=13)$declination
    new <- magneticField(lon, lat, 2020, version=12)$declination
    new - old
}
decDiff <- outer(lon, lat, decDiff)
decDiff <- ifelse(decDiff > 180, decDiff - 360, decDiff)
# Overall (mean) shift -0.1deg
t.test(decDiff)
# View histogram, narrowed to small differences
par(mar=c(3.5, 3.5, 2, 2), mgp=c(2, 0.7, 0))
hist(decDiff, breaks=seq(-180, 180, 0.05), xlim=c(-2, 2),
     xlab="Declination difference [deg] from version=12 to version=13",
     main="Predictions for year 2020")
print(quantile(decDiff, c(0.025, 0.975)))
# Note that the large differences are at high latitudes
imagep(lon,lat,decDiff, zlim=c(-1,1)*max(abs(decDiff)))
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])

