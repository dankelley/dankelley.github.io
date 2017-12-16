## ----eval=FALSE----------------------------------------------------------
## library(oce)
## l <- read.landsat("LC80080292014065LGN00", band="tirs1")
## tirs1 <- l[["tirs1"]]
## ML <- l@metadata$header$radiance_mult_band_10
## AL <- l@metadata$header$radiance_add_band_10
## K1 <- l@metadata$header$k1_constant_band_10
## K2 <- l@metadata$header$k2_constant_band_10
## Llambda <- ML * tirs1 + AL
## SSTkelvin <- K2 / log(K1 / Llambda + 1)
## SST <- SSTkelvin - 273.15                 # convert Kelvin to Celcius
## l@data$SST <- SST
## plot(l, band="SST", col=oceColorsJet)
## mtext(l[["time"]])

