
## ----fig.height=4, fig.width=8, dpi=120----------------------------------
library(oce)
data(section)
## Extract Gulf Stream (and reverse station order)
GS <- subset(section, 109<=stationId & stationId<=129)
GS <- sectionSort(GS, by="longitude")
GS <- sectionGrid(GS)
## Compute and plot normalized dynamic height
dh <- swDynamicHeight(GS)
h <- dh$height
x <- dh$distance

par(mfrow=c(1, 3), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(x, h, xlab="Distance [km]", ylab="Dynamic Height [m]")

## tanh fit
m <- nls(h~a+b*(1+tanh((x-x0)/L)), start=list(a=0,b=1,x0=100,L=100))
hp <- predict(m)
lines(x, hp, col='blue')
x0 <- coef(m)[["x0"]]

plot(GS, which="temperature")
abline(v=x0, col='blue')

## Determine and plot lon and lat of midpoints
lon <- GS[["longitude", "byStation"]]
lat <- GS[["latitude", "byStation"]]
distance <- geodDist(lon, lat, alongPath=TRUE)
lat0 <- approxfun(lat~distance)(x0)
lon0 <- approxfun(lon~distance)(x0)
plot(GS, which="map",
     map.xlim=lon0+c(-6,6), map.ylim=lat0+c(-6, 6))
points(lon0, lat0, pch=1, cex=2, col='blue')
data(topoWorld)
## Show isobaths
depth <- -topoWorld[["z"]]
contour(topoWorld[["longitude"]]-360, topoWorld[["latitude"]], depth,
        level=1000*1:5, add=TRUE, col=gray(0.4))
## Show Drinkwater September climatological North Wall of Gulf Stream.
data("gs", package="ocedata")
lines(gs$longitude, gs$latitude[,9], col='blue', lwd=2, lty='dotted')


