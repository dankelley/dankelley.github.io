
## ----gmt, fig.caption='GMT colors', dpi=100, fig.height=3.8, linenos=table----
## test GMT colours as suggested by
## http://menugget.blogspot.ca/2014/01/importing-bathymetry-and-coastline-data.html
ocean.pal <- colorRampPalette(c("#000000","#000209","#000413","#00061E",
                                "#000728","#000932","#002650","#00426E",
                                "#005E8C","#007AAA","#0096C8","#22A9C2",
                                "#45BCBB","#67CFB5","#8AE2AE","#ACF6A8",
                                "#BCF8B9","#CBF9CA","#DBFBDC","#EBFDED"))
land.pal <- colorRampPalette(c("#336600","#F3CA89","#D9A627","#A49019",
                               "#9F7B0D","#996600","#B27676","#C2B0B0",
                               "#E5E5E5","#FFFFFF"))
library(oce)
data(topoWorld)
waterBreaks <- seq(-10000, -100, by=50)
landBreaks <- seq(100, 10000, by=50)
imagep(topoWorld, asp=1,
       breaks=c(waterBreaks, 0, landBreaks),
       col=c(ocean.pal(length(waterBreaks)), land.pal(length(landBreaks))))


