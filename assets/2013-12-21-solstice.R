
## ------------------------------------------------------------------------
t0 <- as.POSIXct("2014-12-21 10:00:00", tz="UTC") # morning of 
xy <- list(x=-63.60, y=44.65)          # centre of map (Halifax)
D <- 9                                 # map span in km


## ----,message=FALSE,warning=FALSE----------------------------------------
library(oce)
sunrise <- uniroot(function(t)
                   sunAngle(t, lat=xy$y, lon=xy$x, useRefraction=TRUE)$altitude,
                   interval=as.numeric(t0 + 3600*c(-5,5)))$root
sunrise <- numberAsPOSIXct(sunrise)
azimuth <- 90 - sunAngle(sunrise, lat=xy$y, lon=xy$x)$azimuth


## ------------------------------------------------------------------------
D <- D / 111                           # deg
Dlon <- D / cos(xy$y * pi / 180)


## ----message=FALSE, warning=FALSE----------------------------------------
library(OpenStreetMap)

## ----solstice-map,fig.height=5,fig.width=5,dpi=150-----------------------
map <- openmap(c(lat=xy$y+D/2, lon=xy$x-Dlon/2),
               c(lat=xy$y-D/2, lon=xy$x+Dlon/2),
               minNumTiles=9)
plot(map)
## Draw lines along which sunrise or sunset can be sighted.
cx <- mean(par('usr')[1:2])
cy <- mean(par('usr')[3:4])
d <- diff(par('usr')[3:4]) # scales as the map
for (o in d*seq(-1, 1, length.out=60)) {
    lines(cx+c(-1,1)*d*cos(azimuth*pi/180),
          cy+o+c(-1,1)*d*sin(azimuth*pi/180), col='red')
}
mtext(paste("Solstice sunrise at ", format(sunrise-4*3600, "%Y-%m-%d %H:%M")), font=2)


