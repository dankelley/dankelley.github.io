
## ----N2-runlm-1, fig.path='2014-02-10_', dpi=100-------------------------
library(oce)
data(ctd)
source('~/src/R-kelley/oce/R/ctd.R')
plot(ctd, which="N2")
## Using runlm() to get d(rho)/dz
rho <- swRho(ctd)
z <- swZ(ctd)

drhodz <- runlm(z, rho, deriv=1)
g <- 9.81
rho0 <- mean(rho, na.rm=TRUE)
N2 <- -g * drhodz / rho0
lines(N2, -z, col='blue')
legend("bottomright", lwd=2, 
       col=c("brown", "blue"), legend=c("spline", "runlm"),
       bg="white")


## ------------------------------------------------------------------------
N2 <- swN2(ctd)
N2fromderiv <- function(L) {
    - g * runlm(z, rho, L=L, deriv=1) / rho0
}
best <- optimize(function(L) sqrt(mean((N2 - N2fromderiv(L))^2)), interval=c(1, 100))
print(best)
N2best <- N2fromderiv(best$minimum)


## ----N2-runlm-2, fig.path='2014-02-10_', dpi=100-------------------------
plotProfile(ctd, "N2")
lines(N2best, ctd[['pressure']], col="red")


