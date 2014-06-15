
## ------------------------------------------------------------------------
library(deSolve)
de <- function(t, y, parms, ...)
{
    theta <- y[1]
    phi <- y[2]
    list(c(dthetadt=phi, dphidt=-sin(theta)))
}

a <- 0.1
y0 <- c(0, a)
t <- seq(0, 4*pi, pi/100)
sol <- lsoda(y=y0, times=t, func=de)
ylim <- max(range(sol[,2])) * c(-1, 1)
par(mar=c(3.5, 3.5, 1, 1), mgp=c(2, 0.7, 0))
plot(sol[,1], sol[,2], type='l', ylim=ylim, col='blue',
     xlab=expression(t), ylab=expression(theta(t)))
grid()
lines(t, a*sin(t), col='red', lty='dashed')


## ------------------------------------------------------------------------
library(deSolve)
oscillator <- function(a=0.1)
{
    de <- function(t, y, parms, ...)
    {
        theta <- y[1]
        phi <- y[2]
        list(c(dthetadt=phi, dphidt=-sin(theta)))
    }
    y0 <- c(0, a)
    t <- seq(0, 8*pi, pi/100)
    sol <- lsoda(y=y0, times=t, func=de)
    ylim <- max(range(sol[,2])) * c(-1, 1)
    par(mar=c(3.5, 3.5, 1, 1), mgp=c(2, 0.7, 0))
    plot(sol[,1], sol[,2], type='l', ylim=ylim, col='blue',
         xlab=expression(t), ylab=expression(theta(t)))
    grid()
    lines(t, a*sin(t), col='red')
    legend("bottomleft", col=c("blue", "red"), lwd=1,
           legend=c("linear", "nonlinear"),
           bg="white")
}


## ------------------------------------------------------------------------
oscillator(1)


## ------------------------------------------------------------------------
oscillator(1.999)


