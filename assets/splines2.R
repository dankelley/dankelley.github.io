if (!interactive()) png("splines2.png", width=7, height=7, unit="in", res=150, pointsize=12)

## Data from "MD=1" set of akima1972iasc
x <- c(0, 1, 2, 3, 3, 4, 5,  6,  6,  7,   8,   9)
y <- c(0, 0, 0, 0, 0, 0, 1, 10, 10, 80, 100, 150)

## A mesh for plotting
xx <- seq(min(x), max(x), length.out=200)

library(akima)                         # for aspline()

start <- function()
{
    plot(x, y, pch=20)
    grid()
    akima <- aspline(x, y, xx, method="original")
    lines(akima$x, akima$y, lty=1)
}

par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0), mfrow=c(2,2))

start()
akima <- aspline(x, y, xx, method="improved")
lines(akima$x, akima$y, col=2)
legend("topleft", lwd=1, col=1:2, legend=c("aspline/original", "aspline/improved"), bg="white")

start()
fun <- splinefun(x, y, method="fmm")
lines(xx, fun(xx), col=2)
legend("topleft", lwd=1, col=1:2, legend=c("aspline/original", "spline/fmm"), bg="white")


start()
fun <- splinefun(x, y, method="natural")
lines(xx, fun(xx), col=2)
legend("topleft", lwd=1, col=1:2, legend=c("aspline/original", "spline/natural"), bg="white")


start()
fun <- splinefun(x, y, method="monoH.FC")
lines(xx, fun(xx), col=2)
legend("topleft", lwd=1, col=1:2, legend=c("aspline/original", "spline/monoH.FC"), bg="white")


if (!interactive()) dev.off()


