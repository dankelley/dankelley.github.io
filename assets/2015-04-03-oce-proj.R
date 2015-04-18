
## ----,message=FALSE,warning=FALSE----------------------------------------
library(oce)
data(coastlineWorld)

par(mar=rep(2, 4))
line <- 0.25
pcol <- "blue"
ecol <- "red"
font <- 2

p <- "+proj=aea +lat_1=10 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=aeqd +lon_0=-45"
mapPlot(coastlineWorld, projection=p,
        longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=aitoff +lon_0=-45"
mapPlot(coastlineWorld, projection=p,
        longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=bipc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=bonne +lat_1=45"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=cass +lon_0=-45"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Bad merdians", line=line, adj=0, col='red')

p <- "+proj=cc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(-40,40))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=cea"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=collg"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=crast"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck1"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck2"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck3"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck4"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck5"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck6"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eqc"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=euler +lat_1=45 +lat_2=50 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=etmerc +ellps=WGS84 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=fahey"
mapPlot(coastlineWorld, projection=p)
mtext("+proj=fahey", line=line, adj=1, col=pcol, font=font)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=fouc"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=fouc_s"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gall"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=geos +h=1e8"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gn_sinu +n=6 +m=3"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gnom +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(-30,30))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=goode"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=hatano"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=healpix"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=rhealpix"
mapPlot(coastlineWorld, projection=p)# +north_square=1 +south_square=2")
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=igh"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=imw_p +lat_1=10 +lat_2=70 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=kav5"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=kav7"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=laea +lon_0=-40"
mapPlot(coastlineWorld, projection=p)
mtext("+proj=laea +lon_0=-40", line=line, adj=1, col=pcol, font=font)

p <- "+proj=lonlat"
mapPlot(coastlineWorld, projection=p)
mtext("+proj=lonlat", line=line, adj=1, col=pcol, font=font)

p <- "+proj=latlon"
mapPlot(coastlineWorld, projection=p)
mtext("+proj=lonlat", line=line, adj=1, col=pcol, font=font)

p <- "+proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=lcca +lat_0=20 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=leac +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=loxim"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=lsat +lsat=1 +path=200"
mapPlot(coastlineWorld, projection=p,
            longitudelim=c(-180,-120), latitudelim=c(70,120))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbt_s"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbt_fps"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfpp"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfpq"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfps"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=merc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mil_os"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 120))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mill"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=moll"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)


p <- "+proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=natearth"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=nell"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=nell_h"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=nsper +h=90000000"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=ob_tran"
## mapPlot(coastlineWorld, projection=p, longitudelim=c(-180,-120), latitudelim=c(-50,-20))
plot(0:1, 0:1, axes=FALSE, type='n', xlab="", ylab="")
box()
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Usage?", line=line, adj=0, col=ecol, font=font)

p <- "+proj=ocea"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=ortho"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=poly +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp1"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp2"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp3"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp5"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp6"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp3p"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp5p"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp6p"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=qua_aut"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=qsc +lon_0=-100"
mapPlot(coastlineWorld, projection=p, grid=15, fill='lightgray')
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=robin"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=rouss +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=sinu"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=stere +lat_0=90"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=sterea +lat_0=90"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tcea +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Extraneous lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tmerc +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tpeqd +lat_1=30 +lon_1=-80"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tpers +h=1e8"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=ups +ellps=WGS84"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=urmfps +n=0.9"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=utm +ellps=WGS84 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=vandg"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45))
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag1"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag2"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag3"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag4"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag5"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag6"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=weren"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wink1"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wintri"
mapPlot(coastlineWorld, projection=p)
mtext(p, line=line, adj=1, col=pcol, font=font)


