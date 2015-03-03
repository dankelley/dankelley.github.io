
## ------------------------------------------------------------------------
library(oce)
x <- seq(0, 1, length.out=50)
y <- x
z <- seq(0, 1, length.out = length(x))
zlim <- range(z)
npalette <- 10
mar <- par('mar')

palette <- oceColorsJet(npalette)
drawPalette(zlim = zlim, col = palette)
plot(x, y, type = "l")
grid()
segments(head(x, -1), head(y, -1),
  tail(x, -1), tail(y, -1),
  col = palette[findInterval(z, 
    seq(zlim[1], zlim[2], length.out = npalette + 1))],
  lwd = 8)
points(x, y, pch = 20, cex=1/3)


