## ----eval=FALSE---------------------------------------------------------------
## # Not run here, so no graph
## plot(x, y1)
## points(x, y2, col=2)


## -----------------------------------------------------------------------------
x <- 1:8
palette("R4") # not actually needed unless R3 was previously selected
plot(x, rep(0.9, 8), ylim=c(0.5,1.5), pch=20, cex=4, col=1:8)
points(x, rep(0.95, 8), cex=4, col=1:8)
palette("R3") # switch to the old scheme
points(x, rep(1.1, 8), pch=20, cex=4, col=1:8)
points(x, rep(1.15, 8), cex=4, col=1:8)

