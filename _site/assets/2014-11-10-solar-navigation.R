
## ----,message=FALSE,warning=FALSE----------------------------------------
library(oce)
misfit <- function(lonlat)
{
    riseAlt <- sunAngle(rise, longitude=lonlat[1], latitude=lonlat[2], useRefraction=TRUE)$altitude
    setAlt <- sunAngle(set, longitude=lonlat[1], latitude=lonlat[2], useRefraction=TRUE)$altitude
    0.5 * (abs(riseAlt) + abs(setAlt))
}


## ------------------------------------------------------------------------
start <- c(-50, 50) # set this vaguely near the expected location
rise <- as.POSIXct("2014-11-11 11:06:00", tz="UTC")
set <- as.POSIXct("2014-11-11 20:51:00", tz="UTC")
bestfit <- optim(start, misfit)


## ------------------------------------------------------------------------
str(bestfit)


## ----find-halifax, fig.height=4, fig.width=7, dpi=100--------------------
data(coastlineWorldFine, package="ocedata")
plot(coastlineWorldFine, clon=-64, clat=45, span=500)
grid()

n <- 25                                # use 25 perturbations
rises <- rise + rnorm(n, sd=30)
sets <- set + rnorm(n, sd=30)
set.seed(20141111) # this lets readers reproduce this exactly
for (i in 1:n) {
    rise <- rises[i]
    set <- sets[i]
    fit <- optim(start, misfit)
    points(fit$par[1], fit$par[2], pch=21, bg="pink", cex=1.4)
}
# Show the unperturbed fit
points(bestfit$par[1], bestfit$par[2], pch=21, cex=2, bg="red")
# Show the actual location of Halifax
points(-63.571, 44.649, pch=22, cex=2, bg='yellow')
# A legend summarizes all this work
legend("bottomright", bg="white", 
       pch=c(21, 21, 22), pt.bg=c("red", "pink", "yellow"),
       legend=c("Best", "Range", "True"))


