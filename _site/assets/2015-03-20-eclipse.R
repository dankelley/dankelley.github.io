
## ----,message=FALSE,warning=FALSE----------------------------------------
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
    scale <- cos(0.5*(ma$altitude+sa$altitude) * pi / 180)
    sqrt((scale*(saz-maz))^2 + (sal-mal)^2)
}
# time is from reference 3
nasa <- as.POSIXct("2015-03-20 9:45:39", tz="UTC")
times <- nasa + seq(-1800, 1800, 30)
misfit <- NULL
for (i in seq_along(times)) {
    misfit <- c(misfit, angle(times[i]))
}
oce.plot.ts(times, misfit, ylab="Angular misfit [deg]")
o <- optimize(function(t) angle(nasa+t), lower=-3600, upper=3600)
eclipse <- nasa + o$minimum
abline(v=eclipse, col='black')
abline(v=nasa, col='red')
mtext(sprintf("Here: %s ", format(eclipse)), line=-1, adj=1, col="black")
mtext(sprintf("NASA: %s ", format(nasa)), line=-2, adj=1, col="red")


