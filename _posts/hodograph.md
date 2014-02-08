hodograph <- function(x, y, t, Rings, tcut=c("daily", "yearly"), ...)
{
    tcut <- match.arg(tcut)
    if (missing(t)) {
        stop("x-y method not coded yet\n")
    } else {
        if (!missing(y)) {
            stop("cannot give y if t is given\n")
        }
        if (tcut== "yearly") {
            ## x=x(t)
            t <- as.POSIXlt(t)
            start <- ISOdatetime(1900+as.POSIXlt(t[1])$year, 1, 1, 0, 0, 0,
                                 tz=attr(t, "tzone"))
            day <- as.numeric(julian(t, origin=start))
            xx <- x * cos(day / 365 * 2 * pi)
            yy <- x * sin(day / 365 * 2 * pi)
            ## axes
            Rings <- if (missing(Rings)) pretty(sqrt(xx^2 + yy^2))
            Rscale <- 1.04 * max(Rings)
            theta <- seq(0, 2 * pi, length.out=200)
            plot(xx, yy, asp=1, xlim=Rscale*c(-1.1,1.1), ylim=Rscale*c(-1.1, 1.1),
                 type='n', xlab="", ylab="", axes=FALSE)
            ## month lines
            month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
            for (m in 1:12) {
                phi <- 2*pi*(m-1)/12
                lines(Rscale*cos(phi)*c(-1.1,1.1), Rscale*sin(phi)*c(-1.1,1.1), col='gray')
                phi <- 2*pi*(0.5/12+(m-1)/12)
                text(1.1*Rscale * cos(phi), 1.1*Rscale * sin(phi), month[m]) 
            }
            for (R in Rings) {
                gx <- R * cos(theta)
                gy <- R * sin(theta)
                lines(gx, gy, col='gray')
            }
            points(xx, yy, ...)
        } else {
            stop("only tcut=\"yearly\" works at this time\n")
        }
    }
}

library(oce)

data(co2)
year <- as.numeric(time(co2))
t0 <- as.POSIXlt("1959-01-01 00:00:00", tz="UTC")
t <- t0 + (year - year[1]) *365*86400
par(mar=c(3, 3, 1, 1), mfrow=c(1,2))
plot(co2)
par(mar=rep(1, 4))
hodograph(x=co2-co2[1], t=t, tcut="yearly", type="l")
