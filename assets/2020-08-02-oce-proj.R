## ----message=FALSE------------------------------------------------------------
library(oce)
data(coastlineWorld)
cl45 <- coastlineCut(coastlineWorld, lon_0=-45)

par(mar=rep(2, 4))
line <- 0.25
pcol <- "blue"
ecol <- "red"
font <- 1
col <- "lightgray"

p <- "+proj=aea +lat_1=10 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=aeqd +lon_0=-45"
mapPlot(coastlineWorld, projection=p,
        longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=aitoff +lon_0=-45"
mapPlot(coastlineWorld, projection=p,
        longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Problem at top, unless coastlineCut() used", line=line, adj=0, col=ecol, font=font)

p <- "+proj=aitoff +lon_0=-45"
mapPlot(cl45, projection=p,
        longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Using coastlineCut()", line=line+0.9, adj=1, col=pcol, font=font)

p <- "+proj=bipc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=bonne +lat_1=45"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=cass +lon_0=-45"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=cass +lon_0=-45"
mapPlot(cl45, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Using coastlineCut()", line=line+0.9, adj=1, col=pcol, font=font)

p <- "+proj=cc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(-40,40), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=cea"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=collg"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=crast"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck1"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck2"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck3"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck4"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck5"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eck6"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eqc"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=eqearth"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=euler +lat_1=45 +lat_2=50 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=etmerc +ellps=WGS84 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=etmerc +ellps=WGS84 +lon_0=-40"
mapPlot(cl45, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Using coastlineCut()", line=line+0.9, adj=1, col=pcol, font=font)

p <- "+proj=fahey"
mapPlot(coastlineWorld, projection=p, col=col)
mtext("+proj=fahey", line=line, adj=1, col=pcol, font=font)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=fouc"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=fouc_s"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gall"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=geos +h=1e8"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gn_sinu +n=6 +m=3"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=gnom +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(-30,30), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=goode"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=hatano"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

## fails 2020-08-02 ## p <- "+proj=healpix +a=1"
## fails 2020-08-02 ## mapPlot(coastlineWorld, projection=p, col=col)
## fails 2020-08-02 ## mtext(p, line=line, adj=1, col=pcol, font=font)
## fails 2020-08-02 ## mtext("Problem in Canada", line=line, adj=0, col=ecol, font=font)

## fails 2020-08-02 ## p <- "+proj=rhealpix +south_square=0 +north_square=1"
## fails 2020-08-02 ## mapPlot(coastlineWorld, projection=p)
## fails 2020-08-02 ## mtext(p, line=line, adj=1, col=pcol, font=font)
## fails 2020-08-02 ## mtext("Is this an acid trip?", line=line, adj=0, col=ecol, font=font)

p <- "+proj=igh"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Connection through cutout region", line=line, adj=0, col=ecol, font=font)

p <- "+proj=kav5"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=kav7"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=laea +lon_0=-40"
mapPlot(coastlineWorld, projection=p, col=col)
mtext("+proj=laea +lon_0=-40", line=line, adj=1, col=pcol, font=font)

p <- "+proj=longlat"
mapPlot(coastlineWorld, projection=p, col=col)
mtext("+proj=lonlat", line=line, adj=1, col=pcol, font=font)

p <- "+proj=latlong"
mapPlot(coastlineWorld, projection=p, col=col)
mtext("+proj=lonlat", line=line, adj=1, col=pcol, font=font)

p <- "+proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=leac +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=loxim"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbt_s"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbt_fps"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfpp"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfpq"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mbtfps"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=merc"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mil_os"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 120), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=mill"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=moll"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=natearth"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=nell"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=nell_h"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

## fails 2020-08-02 ## p <- "+proj=nsper +h=90000000"
## fails 2020-08-02 ## mapPlot(coastlineWorld, projection=p, col=col)
## fails 2020-08-02 ## mtext(p, line=line, adj=1, col=pcol, font=font)
## fails 2020-08-02 ## mtext("Problem in Antarctica", line=line, adj=0, col=ecol, font=font)

p <- "+proj=ob_tran +o_proj=mill +o_lon_p=40 +o_lat_p=50"
mapPlot(coastlineWorld, projection=p, col=col)
mtext("Ugly Horizontal Lines; weird gradicules", line=line, adj=0, col=ecol, font=font)

p <- "+proj=ocea"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Ugly Horizontal Lines", line=line, adj=0, col=ecol, font=font)

p <- "+proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=ortho"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Problem in Antarctica", line=line, adj=0, col=ecol, font=font)

## fails 2020-08-02 ## > p <- "+proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40"
## fails 2020-08-02 ## > mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
## fails 2020-08-02 ## Error in CPL_geos_op2(op, x, y) : 
## fails 2020-08-02 ##   Evaluation error: TopologyException: found non-noded intersection between LINESTRING (2.90185e+06 6.38497e+07, 3.59738e+06 7.62361e+07) and LINESTRING (2.42138e+07 4.43386e+08, -699901 -292340) at 2901848.262176008 63849691.953739122.

p <- "+proj=poly +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp1"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp2"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp3"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp5"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp6"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp3p"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp5p"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=putp6p"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=qua_aut"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=qsc +lon_0=-100"
mapPlot(coastlineWorld, projection=p, grid=15, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=robin"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=rouss +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=sinu"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=stere +lat_0=90"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=sterea +lat_0=90"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tcea +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tmerc +lon_0=-40 +lat_1=30 +lat_2=60"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tpeqd +lat_1=30 +lon_1=-80"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,60), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=tpers +h=1e8"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)
mtext("Problem in Antarctica", line=line, adj=0, col=ecol, font=font)

p <- "+proj=ups +ellps=WGS84"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(70, 110), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=urmfps +n=0.9"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=utm +ellps=WGS84 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=vandg"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40"
mapPlot(coastlineWorld, projection=p, longitudelim=c(-80,0), latitudelim=c(0,45), col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag1"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag2"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag3"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag4"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag5"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wag6"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=weren"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wink1"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

p <- "+proj=wintri"
mapPlot(coastlineWorld, projection=p, col=col)
mtext(p, line=line, adj=1, col=pcol, font=font)

