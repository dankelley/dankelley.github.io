
## ----profile1, fig.path='2014-02-10_', dpi=100---------------------------
library(oce)
data(ctd)
plot(ctd, which="N2")

## Using ``runderiv()`` to get d(rho)/dz
rho <- swRho(ctd)
z <- swZ(ctd)

drhodz <- runderiv(z, rho)
g <- 9.81
rho0 <- mean(rho, na.rm=TRUE)
N2 <- -g * drhodz / rho0
lines(N2, -z, col='blue')
legend("bottomright", lwd=2, 
       col=c("brown", "blue"), legend=c("spline", "runderiv"),
       bg="white")


## ------------------------------------------------------------------------
N2 <- swN2(ctd)
N2fromderiv <- function(L) {
    - g * runderiv(z, rho, L=L) / rho0
}
best <- optimize(function(L) sqrt(mean((N2 - N2fromderiv(L))^2)), interval=c(1, 100))
print(best)
N2best <- N2fromderiv(best$minimum)


## ----profile2, fig.path='2014-02-10_', dpi=100---------------------------
plotProfile(ctd, "N2")
lines(N2best, ctd[['pressure']], col="red")


