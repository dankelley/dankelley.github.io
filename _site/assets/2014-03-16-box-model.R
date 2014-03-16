
## ------------------------------------------------------------------------
library(deSolve)


## ------------------------------------------------------------------------
IC <- 0
parms <- list(A=1e6, gamma=10)


## ------------------------------------------------------------------------
day <- 86400
times <- seq(0, 10*day, length.out=200)
F <- function(t)
{
    ifelse (t > day & t < 2*day, 1, 0)
}


## ------------------------------------------------------------------------
DE <- function(t, y, parms)
{
    h <- y[1]
    dhdt <- F(t) / parms$A - parms$gamma * h / parms$A
    list(dhdt)
}


## ------------------------------------------------------------------------
sol <- lsoda(IC, times, DE, parms)


## ----box-model, fig.path='2014-03-17-', dpi=100--------------------------
par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
h <- sol[,2]
days <- times / 86400
plot(days, F(times), type='l', ylab="Riverine input [m^3/s]")
plot(days, h, type='l', ylab="Lake level [m]")


