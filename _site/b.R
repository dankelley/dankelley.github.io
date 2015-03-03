library(oce)
x <- 1:50
y <- x * 2/10 + x^2/10
z <- seq(0, 5, length.out = length(x))
zlim <- range(z)
npalette <- 10
mar <- par('mar')

palette <- oceColorsJet(npalette)
cm <- colormap(z=z, zlim=zlim, breaks=seq(zlim[1], zlim[2], 25))
drawPalette(zlim = zlim, col = cm$col)
plot(x, y, type = "l")
segments(head(x, -1), head(y, -1),
  tail(x, -1), tail(y, -1),
  col = cm$zcol,
  lwd = 10)
points(x, y, pch = 20)
par(mar=mar) # reset
