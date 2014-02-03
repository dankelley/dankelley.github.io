library(akima)
x1 <- c( 0,  1,  2,  3,  4,  5,    6,  7,  8,  9, 10)
x2 <- c( 0,  1,  3,  4,  6,  7,    8,  9, 10, 13, 15)
x3 <- c( 0,  2,  3,  5,  6,  7,    8,  9, 10, 14, 15)
y  <- c(10, 10, 10, 10, 10, 10, 10.5, 15, 50, 60, 85)
if (!interactive()) png("splines2.png", width=7, height=4, unit="in", res=150, pointsize=8)
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0), mfrow=c(1,3))
xx <- seq(0, 15, length.out=200)
show <- function(x, y)
{
    plot(x, y, pch=20)
    grid()
    akima <- aspline(x, y, xx)
    lines(akima$x, akima$y)
    fun <- splinefun(x, y, method="fmm")
    lines(xx, fun(xx), col=2)
    fun <- splinefun(x, y, method="natural")
    lines(xx, fun(xx), col=3)
    ## "periodic" is not much use for such data
    ## fun <- splinefun(x, y, method="periodic")
    ## lines(xx, fun(xx), col=4)
    fun <- splinefun(x, y, method="monoH.FC")
    lines(xx, fun(xx), col=4)
    fun <- splinefun(x, y, method="hyman")
    lines(xx, fun(xx), col=5)
    legend("topleft", lwd=par('lwd'), bg='white',
           col=1:5,
           legend=c("aspline", "spline/fmm", "spline/natural", "spline/monoH.FC", "spline/hyman"))
}
show(x1, y)
show(x2, y)
show(x3, y)

if (!interactive()) dev.off()


