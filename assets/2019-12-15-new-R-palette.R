## ----eval=FALSE---------------------------------------------------------------
## # Not run here, so no graph
## plot(x, y1)
## points(x, y2, col=2)


## -----------------------------------------------------------------------------
x <- 1:8
# The next call to palette() is not actually needed unless there was a prior
# cal specifying R3.  Still, retaining this call is useful because it
# means that the user does not have to check previous code (including in
# functions they may not have written, to be sure that we are not using R3.
palette("R4")
plot(x, rep(0.9, 8), ylab="", ylim=c(0.5,1.5), pch=20, cex=4, col=1:8)
points(x, rep(0.85, 8), cex=2, col=1:8)
for (i in 1:8) abline(h=0.85-i/40, col=i)

# Now, show th old colours. Note how bad the yellow is.
palette("R3")
points(x, rep(1.1, 8), pch=20, cex=4, col=1:8)
points(x, rep(1.15, 8), cex=2, col=1:8)
for (i in 1:8) abline(h=1.15+i/40, col=i)

