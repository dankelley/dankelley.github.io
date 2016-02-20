## ----eval=FALSE----------------------------------------------------------
## library(oce)
## ## 1. Create local-view datasets
## Hc <- c(-63.57, 44.63)                 # south end of Halifax, NS
## Hd <- 0.025 * c(1/cos(pi*Hc[2]/180), 1) # approx 5 km box
## band <- c("red", "green", "nir") # lets us plot 'terralook'
## ## Wintertime
## if (0==length(list.files(pattern="^Hw.rda$"))) {
##     w <- read.landsat("/data/archive/landsat/LC80080292014065LGN00", band=band)
##     Hw <- landsatTrim(w, ll=Hc-Hd, ur=Hc+Hd)
##     save(Hw, file="Hw.rda")
##     rm(w)
## } else {
##     load("Hw.rda")
## }
## 
## ## Summertime
## if (0==length(list.files(pattern="^Hs.rda$"))) {
##     s <- read.landsat("/data/archive/landsat/LC80070292014170LGN00", band=band)
##     Hs <- landsatTrim(s, ll=Hc-Hd, ur=Hc+Hd)
##     save(Hs, file="Hs.rda")
##     rm(s)
## } else {
##     load("Hs.rda")
## }

## ----eval=FALSE----------------------------------------------------------
## demo <- function(red.f, green.f, blue.f, name="")
## {
##     if (!missing(name)) png(name, unit="in", width=6, height=3.1, res=200)
##     par(mfrow=c(1,2))
##     mar <- c(0.25, 0.25, 1, 0.25)
##     mar <- c(2, 2, 1.5, 0.5)
##     axes <- TRUE
##     cex <- 0.8
##     plot(Hw, band='terralook', red.f=red.f, green.f=green.f, blue.f=blue.f,
##          mar=mar, axes=axes, cex=cex)
##     mtext(sprintf("red.f=%g, green.f=%g, blue.f=%g", red.f, green.f, blue.f),
##           side=3, line=0, adj=0, cex=cex)
##     mtext(format(Hw[['time']], "%B %Y"), side=3, line=0, adj=1, cex=cex)
##     plot(Hs, band='terralook', red.f=red.f, green.f=green.f, blue.f=blue.f,
##          mar=mar, axes=axes, cex=cex)
##     mtext(sprintf("red.f=%g, green.f=%g, blue.f=%g", red.f, green.f, blue.f),
##           side=3, line=0, adj=0, cex=cex)
##     mtext(format(Hs[['time']], "%B %Y"), side=3, line=0, adj=1, cex=cex)
##     if (!missing(name)) dev.off()
## }

## ----eval=FALSE----------------------------------------------------------
## demo(2, 2, 4, "landsat-1.png")

## ----eval=FALSE----------------------------------------------------------
## demo(2, 1.7, 4, "landsat-2.png")

## ----eval=FALSE----------------------------------------------------------
## demo(1.7, 1.7, 6, "landsat-3.png")

