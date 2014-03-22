
## ----sunmoon, fig.path='2014-03-22-', dpi=100----------------------------
library(oce)
angles <- function(day=Sys.Date(), lon=-63.61, lat=44.67, tz="America/Halifax", sun=TRUE)
{
    tUTC <- t <- seq(as.POSIXct(paste(day, "00:00:00"), tz=tz), length.out=240, by="6 min")
    attributes(tUTC)$tzone <- "UTC"
    a <- if (sun) sunAngle(tUTC, lon=lon, lat=lat) else moonAngle(tUTC, lon=lon, lat=lat)
    invisible <- a$altitude < 0
    a$altitude[invisible] <- NA
    a$azimuth[invisible] <- NA
    list(t=t, altitude=a$altitude, azimuth=a$azimuth)
}

day <- Sys.Date()
tz <- "America/Halifax"
s <- angles()
m <- angles(sun=FALSE)
max <- 1.04 * max(c(s$altitude, m$altitude), na.rm=TRUE)

par(mar=rep(0.5, 4))
theta <- seq(0, 2*pi, length.out=24 * 10)
radiusx <- cos(theta)
radiusy <- sin(theta)

# Horizon and labels+lines for EW and NS
plot(radiusx, radiusy, type='l', col='gray', asp=1, axes=FALSE, xlab="", ylab="")
lines(c(-1, 1), c(0, 0), col='gray')
lines(c(0, 0), c(-1, 1), col='gray')
D <- 1.06
text( 0, -D, "S", xpd=TRUE) # xpd so can go in margin
text(-D,  0, "W", xpd=TRUE)
text( 0,  D, "N", xpd=TRUE)
text( D,  0, "E", xpd=TRUE)

## Moon
mx <- (90 - m$altitude) / 90 * cos(pi / 180 * (90 - m$azimuth))
my <- (90 - m$altitude) / 90 * sin(pi / 180 * (90 - m$azimuth))
lines(mx, my, col='blue', lwd=3)
t <- s$t
mlt <- as.POSIXct(sprintf("%s %02d:00:00", day, 1:24), tz=tz)
ti <- unlist(lapply(mlt, function(X) which.min(abs(X-t))))
points(mx[ti], my[ti], pch=20, cex=3, col='white')
text(mx[ti], my[ti], 1:24, cex=3/4)

## Sun
sx <- (90 - s$altitude) / 90 *  cos(pi / 180 * (90 - s$azimuth))
sy <- (90 - s$altitude) / 90 *  sin(pi / 180 * (90 - s$azimuth))
lines(sx, sy, col='red', lwd=3)
slt <- as.POSIXct(sprintf("%s %02d:00:00", day, 1:24), tz=tz)
si <- unlist(lapply(slt, function(X) which.min(abs(X-t))))
points(sx[ti], sy[ti], pch=20, cex=3, col='white')
text(sx[ti], sy[ti], 1:24, cex=3/4)

mtext(paste("Halifax NS", day, sep='\n'), side=3, adj=0, line=-2)
mtext("Red sun\nBlue moon", side=3, adj=1, line=-2)


