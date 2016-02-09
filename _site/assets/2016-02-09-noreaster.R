## ----echo=FALSE----------------------------------------------------------

## ----results='hide', message=FALSE, warning=FALSE------------------------
library(oce)
lon <- -64.018
lat <- 42.505
data(coastlineWorldFine, package="ocedata")
plot(coastlineWorldFine, longitudelim=lon+c(-5, 5), latitudelim=lat+c(-7,7))
points(lon, lat, bg='red', cex=2, pch=21)
data(topoWorld)
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]],
        levels=-1000, lty=2, drawlabels=FALSE, add=TRUE)

## ----eval=FALSE----------------------------------------------------------
## download.file("http://www.ndbc.noaa.gov/data/realtime2/44150.txt", "44150.txt")

## ------------------------------------------------------------------------
d <- readLines("44150.txt")
names <- strsplit(gsub("^#", "", d[1]), " +")[[1]]
d <- gsub("MM", "NA", d) # whacky missing-value code
d <- read.table(text=d, header=FALSE, col.names=names)
t <- ISOdatetime(d$YY, d$MM, d$DD, d$hh, d$mm, 0, tz="UTC")
windDirection <- d$WDIR
windSpeed <- d$WSPD
gust <- d$GST
waveHeight <- d$WVHT
dominantWavePeriod <- d$DPD
apd <- d$APD # ? maybe average wave period?
mwd <- d$MWD # ? 
airPressure <- d$PRES
airTemperature <- d$ATMP
waterTemperature <- d$WTMP
dewPoint <- d$DEWP
visibility <- d$VIS
ptdy <- d$PTDY
tide <- d$TIDE
theta <- 90 - windDirection # convert from CW-from-North to CCW-from-East
## multiply by -1 to convert from "wind from" to "wind to"
windU <- -windSpeed * cos(theta*pi/180)
windV <- -windSpeed * sin(theta*pi/180)

## ----results='hide', message=FALSE, warning=FALSE------------------------
par(mfrow=c(5,1))
oce.plot.ts(t, airPressure/10, ylab="Air press [kPa]", drawTimeRange=FALSE, mar=c(2, 3, 1, 1))
oce.plot.ts(t, windSpeed, ylab="Wind speed [m/s]", drawTimeRange=FALSE, mar=c(2, 3, 1, 1))
oce.plot.ts(t, windDirection, ylab="wind dir", drawTimeRange=FALSE, mar=c(2, 3, 1, 1))
oce.plot.ts(t, waveHeight, ylab="Height [m]", drawTimeRange=FALSE, mar=c(2, 3, 1, 1))
oce.plot.ts(t, dominantWavePeriod, ylab="Period [s]", drawTimeRange=FALSE, mar=c(2, 3, 1, 1))

## ------------------------------------------------------------------------
cm <- colormap(waveHeight, zlim=c(0, 10), col=oceColorsJet)
par(mar=c(3.5, 3.5, 1.5, 1), mgp=c(2, 0.7, 0))
drawPalette(zlim=cm$zlim, col=cm$col)
plot(windU, windV, asp=1, cex=2, pch=21, bg=cm$zcol,
     xlab="Eastward wind [m/s]", ylab="Northward wind [m/s]")
mtext("Colour indicates wave height [m]", side=3, line=0.25, adj=1)
for (ring in seq(5, 30, 5)) {
    circleX <- ring * cos(seq(0, 2*pi, pi/20))
    circleY <- ring * sin(seq(0, 2*pi, pi/20))
    lines(circleX, circleY, col='lightgray')
}
abline(h=0, col='lightgray')
abline(v=0, col='lightgray')
abline(0, 1, col='lightgray')
abline(0, -1, col='lightgray')

