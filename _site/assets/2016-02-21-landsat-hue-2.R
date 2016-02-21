## ----eval=FALSE----------------------------------------------------------
## library(oce)
## if (0 == length(ls(pattern="^d$"))) d <- read.landsat("/data/archive/landsat/LC80450292013225LGN00")
## 
## ## http://earthobservatory.nasa.gov/blogs/elegantfigures/2013/10/22/how-to-make-a-true-color-landsat-8-image/
## 
## L <- c(0.24, 0.12)
## threeSisters <- c(-121.73, 44.13)
## ts <- landsatTrim(d, ll=threeSisters-L, ur=threeSisters+L)
## 
## demo <- function(l, red.f, green.f, blue.f, offset=rep(0,4), name=NULL, label="")
## {
##     dim <- dim(l[["red"]])
##     w <- 6
##     h <- round(w * dim[2] / dim[1], 2) # proper ratios can yield horiz. stripes
##     if (!is.null(name)) png(name, unit="in", width=w, height=h, res=150, pointsize=9)
##     plot(l, band="terralook", mar=c(2, 2, 1.5, 1),
##          red.f=red.f, green.f=green.f, blue.f=blue.f, offset=offset)
##     mtext(label, font=2, side=3, line=0, adj=1)
##     mtext(sprintf("red.f=%g green.f=%g blue.f=%g offset=c(%g,%g,%g,%g)",
##                   red.f, green.f, blue.f, offset[1], offset[2], offset[3], offset[4]),
##           side=3, line=0, adj=0)
##     if (!is.null(name)) dev.off()
## }
## 
## ## red.f, green.f and blue.f as in posting from yesterday
## demo(ts, 1.7, 1.6, 6, rep(0,4), "2016-02-21-landsat-01.png", "Fig. 1A")
## 
## ## Reducing blue factor removes the blue tinge to the land,
## ## at the expense of making the clouds unnaturally green. Also,
## ## various land areas are still not as red as in the reference
## ## image.
## demo(ts, 1.7, 1.6, 3, rep(0,4), "2016-02-21-landsat-02.png", "Fig. 1B")
## 
## ## After some adjustment of red, green and blue together, the results can
## ## be improved to some extent.
## demo(ts, 2.2, 1.6, 5, rep(0,4), "2016-02-21-landsat-03.png", "Fig. 1C")
## 
## ## Next, try altering the offset in the linear relationship,
## ## as opposed to the multiplicative factor. This is done with
## ## the `offset` argument, rather than with `red.f`, etc.
## demo(ts, 1.7, 1.6, 6, c(0, -0.05, -0.2, 0), "2016-02-21-landsat-04.png", "Fig. 1D")
## 
## ## For reference, apply these values to the Halifax
## ## winter test image.
## load("Hw.rda")
## demo(Hw, 1.7, 1.6, 6, rep(0,4), "2016-02-21-landsat-05.png", "Fig. 2A")
## demo(Hw, 1.7, 1.6, 2, rep(0,4), "2016-02-21-landsat-06.png", "Fig. 2B")
## demo(Hw, 2.2, 1.6, 5, rep(0,4), "2016-02-21-landsat-07.png", "Fig. 2C")
## demo(Hw, 1.7, 1.6, 6, c(0,-0.05,-0.2,0), "2016-02-21-landsat-08.png", "Fig. 2D")
## 
## load("Hs.rda")
## demo(Hs, 1.7, 1.6, 6, rep(0,4), "2016-02-21-landsat-09.png", "Fig. 3A")
## demo(Hs, 1.7, 1.6, 2, rep(0,4), "2016-02-21-landsat-10.png", "Fig. 3B")
## demo(Hs, 2.2, 1.6, 5, rep(0,4), "2016-02-21-landsat-11.png", "Fig. 3C")
## demo(Hs, 1.7, 1.6, 6, c(0,-0.05,-0.2,0), "2016-02-21-landsat-12.png", "Fig. 3D")
## 

## ----eval=FALSE----------------------------------------------------------
## plot.landsat(..., red.f=2.2, green.f=1.6, blue.f=5, offset=rep(0,4), ...)

