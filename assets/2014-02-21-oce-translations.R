
## ----oce-translations, fig.path='2014-02-21-', fig.height=4, dpi=100-----
library(oce)
data(ctd)
par(mfrow=c(1,3))
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE="es")
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE="fr")
plotProfile(ctd, "T")


