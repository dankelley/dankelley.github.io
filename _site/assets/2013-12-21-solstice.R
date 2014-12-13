
## ------------------------------------------------------------------------
t <- as.POSIXct("2013-12-21 17:11:00", tz="UTC") # winter solstice
xy <- list(x=-63.60, y=44.65)          # centre of map (Halifax)
D <- 9                                 # map span in km


## ----,message=FALSE,warning=FALSE----------------------------------------
library(oce)
t0 <- t - 86400 / 4
sunrise <- uniroot(function(t)
                   sunAngle(t, lat=xy$y, lon=xy$x)$altitude,
                   interval=as.numeric(c(t0, t)))$root
sunrise <- numberAsPOSIXct(sunrise)
azimuth <- 90 - sunAngle(sunrise, lat=xy$y, lon=xy$x)$azimuth


## ------------------------------------------------------------------------
D <- D / 111                           # deg
Dlon <- D / cos(xy$y * pi / 180)


## ----solstice-map, fig.height=4, fig.width=7, dpi=100, message=FALSE, warning=FALSE----
library(OpenStreetMap)
map <- openmap(c(lat=xy$y+D/2, lon=xy$x-Dlon/2),
               c(lat=xy$y-D/2, lon=xy$x+Dlon/2),
               minNumTiles=9)
plot(map)
## Draw lines along which sunrise or sunset can be sighted.
cx <- mean(par('usr')[1:2])
cy <- mean(par('usr')[3:4])
d <- diff(par('usr')[3:4]) # scales as the map
for (o in d*seq(-1, 1, length.out=30)) {
    lines(cx+c(-1,1)*d*cos(azimuth*pi/180),
          cy+o+c(-1,1)*d*sin(azimuth*pi/180), col='red')
}
## a title doesn't hurt
mtext(sprintf("sunrise angles on day of winter solstice (%s)",
              format(t, "%Y-%m-%d")), side=3, line=2, cex=1.5)


