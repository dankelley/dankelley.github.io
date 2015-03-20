
## ------------------------------------------------------------------------
library(oce)
angle <- function(t, lon=15+40/60, lat=78+12/60)
{
    ## Default location is Longyearbyen, Svalbard
    sa <- sunAngle(t, lon, lat)
    ma <- moonAngle(t, lon, lat)
    saz <- sa$azimuth
    sal <- sa$altitude
    maz <- ma$azimuth
    mal <- ma$altitude
    C <- cos(0.5*(ma$altitude+sa$altitude) * pi / 180)
    sqrt((C*(saz-maz))^2 + (sal-mal)^2)
}
t0 <- as.POSIXct("2015-03-20 9:45:00", tz="UTC")
times <- t0 + seq(-3600, 3600, 60)
misfit <- NULL
for (i in seq_along(times)) {
    misfit <- c(misfit, angle(times[i]))
}
oce.plot.ts(times, misfit, ylab="Angular misfit [deg]")
o <- optimize(function(t) angle(t0+t), lower=-3600, upper=3600)
eclipse <- t0 + o$minimum
# reference 3
max <- as.POSIXct("2015-03-20 9:45:39", tz="UTC")
abline(v=eclipse, col='black')
abline(v=max, col='red')
mtext(sprintf("Here: %s ", format(eclipse)), line=-1, adj=1, col="black")
mtext(sprintf("NASA: %s ", format(max)), line=-2, adj=1, col="red")


