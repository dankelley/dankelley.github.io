
## ----valentines, dpi=100, message=FALSE, warning=FALSE-------------------
times <- seq(as.POSIXct("2014-02-14", tz="UTC"), length.out=50, by="year")
library(oce)
fraction <- moonAngle(times, lon=-63, lat=43)$illuminatedFraction
full <- fraction > 0.99
plot(times, fraction, xlab="Year", ylab="Moon Illuminated Fraction",
     col=ifelse(full, "red", "blue"), pch=16, cex=2)


## ------------------------------------------------------------------------
times[full]


