
## ----hodograph, fig.path='2014-02-08-'-----------------------------------
hodograph <- function(x, y, t, rings, ringlabels=TRUE, tcut=c("daily", "yearly"), ...)
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
            if (missing(rings))
                rings <- pretty(sqrt(xx^2 + yy^2))
            rscale <- 1.04 * max(rings)
            theta <- seq(0, 2 * pi, length.out=200)
            plot(xx, yy, asp=1, xlim=rscale*c(-1.1,1.1), ylim=rscale*c(-1.1, 1.1),
                 type='n', xlab="", ylab="", axes=FALSE)
            ## month lines
            month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
            for (m in 1:12) {
                phi <- 2*pi*(m-1)/12
                lines(Rscale*1.1*cos(phi)*c(-1,1), Rscale*1.1*sin(phi)*c(-1,1), col='gray')
                phi <- 2*pi*(0.5/12+(m-1)/12)
                text(1.15*Rscale * cos(phi), 1.15*Rscale * sin(phi), month[m]) 
            }
            for (r in rings) {
                if (r > 0) {
                    gx <- r * cos(theta)
                    gy <- r * sin(theta)
                    lines(gx, gy, col='gray')
                    if (ringlabels)
                        text(gx[1], 0, format(r))
                }
            }
            points(xx, yy, ...)
        } else {
            stop("only tcut=\"yearly\" works at this time\n")
        }
    }
}
data(co2)
year <- as.numeric(time(co2))
t0 <- as.POSIXlt("1959-01-01 00:00:00", tz="UTC")
t <- t0 + (year - year[1]) *365*86400
par(mar=rep(1, 4))
hodograph(x=co2-co2[1], t=t, tcut="yearly", type="l", ringlabels=FALSE)


## ----timeseries, fig.path='2014-02-08-'----------------------------------
plot(co2)


