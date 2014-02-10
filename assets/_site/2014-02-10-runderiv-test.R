
## ----chunkName, fig.path='2014-02-10-'-----------------------------------


## ------------------------------------------------------------------------
library(oce)
data(ctd)
plot(ctd, which="N2")

## Using ``runderiv()`` to get d(rho)/dz
rho <- swRho(ctd)
z <- swZ(ctd)

drhodz <- runderiv(z, rho)
N2 <- -9.8 * drhodz / mean(rho, na.rm=TRUE)
lines(N2, -z, col='blue')
legend("bottomright", lwd=2, 
       col=c("brown", "blue"), legend=c("spline", "runderiv"),
       bg="white")


