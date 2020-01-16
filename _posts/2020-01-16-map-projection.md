---
layout: post
title: oce map projections available in PROJ6
tags: [oce, map, R]
category: R
year: 2020
month: 1
day: 16
summary: This blog posting tests whether the projections used in a previous posting about oce will work with the `sf` scheme.
---

# Introduction

The goal is to test the existing oce projections, and also the new proj
projections. The latter are recovered by typing the following in a unix
console.

{% highlight r linenos=table %}
proj -l       # list names of all projections
{% endhighlight %}
but note that a handfull are actually transformations, not projections, and
they are not tested here.

It is possible to get more information on any given projection with e.g.

{% highlight r linenos=table %}
proj -l=ccon  # list info on ccon
{% endhighlight %}





# Overlap

A test of the overlap between oce projections and proj projections can be done with

{% highlight r linenos=table %}
oceName <- gsub("^\\+proj=([a-z_+]*).*$", "\\1", oceTest)
projName <- gsub("^\\+proj=([a-z_+]*).*$", "\\1", projTest)
oceNotInProj <- oceName[!(oceName %in% projName)]
projNotInOce <- projName[!(projName %in% oceName)]
{% endhighlight %}

These functions are in oce, but not in proj: **longlat, latlong**.

These functions are in proj, but not in oce: **affine, airy, alsk, apian, august, bacon, bertin, boggs, calcofi, cart, ccon, chamb, comill, denoy, eqearth, eqdc, geoc, geogoffset, gins, gs, gs, hammer, helmert, imw_p, isea, krovak, labrd, lagrng, larr, lask, lonlat, latlon, lcca, lee_os, lsat, misrsom, nicol, nzmg, noop, ortel, patterson, pop, push, rpoly, somerc, gstmerc, tcc, times, tobmerc, webmerc**.

# Test oce list


{% highlight r linenos=table %}
options(warn=-1)
zero <- cbind(0, 0)
ll <- sf::st_crs("+proj=longlat")$proj4string
for (projOld in oceTest) {
    cat("old:", projOld, "\n")
    xy <- try(rgdal::project(zero, projOld), silent=TRUE)
    if (inherits(xy, "try-error")) {
        cat("gdal::project(...,'", projOld, "') failed\n", sep="")
    } else {
        cat("gdal with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
    }
    projNew <- try(sf::st_crs(projOld)$proj4string, silent=TRUE)
    if (!is.na(projNew)) {
        cat("new:", projNew, "\n")
        xy <- sf::sf_project(ll, projOld, zero)
        cat("sf    with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- sf::sf_project(ll, projNew, zero)
        cat("sf    with new: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- rgdal::project(zero, projNew)
    } else {
        cat("sf::st_crs() cannot handle this string\n")
    }
    cat("\n")
}
{% endhighlight %}



{% highlight text %}
## old: +proj=aea +lat_1=10 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (4669884,857748.7)
## new: +proj=aea +lat_1=10 +lat_2=60 +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
## 
## old: +proj=aeqd +lon_0=-45 
## gdal with old: (0,0) -> (5009377,3.067359e-10)
## new: +proj=aeqd +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,3.067359e-10)
## sf    with new: (0,0) -> (5009377,3.067359e-10)
## 
## old: +proj=aitoff +lon_0=-45 
## gdal with old: (0,0) -> (5009377,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bipc 
## gdal with old: (0,0) -> (2235009,-14651858)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bonne +lat_1=45 
## gdal with old: (0,0) -> (0,-4984944)
## new: +proj=bonne +lon_0=0 +lat_1=45 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4984944)
## sf    with new: (0,0) -> (0,-4984944)
## 
## old: +proj=cass +lon_0=-45 
## gdal with old: (0,0) -> (5009377,0)
## new: +proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,0)
## sf    with new: (0,0) -> (5009377,0)
## 
## old: +proj=cass +lon_0=-45 
## gdal with old: (0,0) -> (5009377,0)
## new: +proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,0)
## sf    with new: (0,0) -> (5009377,0)
## 
## old: +proj=cc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=cea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cea +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=collg 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=crast 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=eck1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck1 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck2 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck3 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck5 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck6 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=euler +lat_1=45 +lat_2=50 +lon_0=-40 
## gdal with old: (0,0) -> (5478194,1441354)
## sf::st_crs() cannot handle this string
## 
## old: +proj=etmerc +ellps=WGS84 +lon_0=-40 
## gdal with old: (0,0) -> (4869526,0)
## new: +proj=etmerc +ellps=WGS84 +lon_0=-40 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## old: +proj=etmerc +ellps=WGS84 +lon_0=-40 
## gdal with old: (0,0) -> (4869526,0)
## new: +proj=etmerc +ellps=WGS84 +lon_0=-40 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## old: +proj=fahey 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=fouc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=fouc_s 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gall 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gall +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=geos +h=1e8 
## gdal with old: (0,0) -> (0,0)
## new: +proj=geos +lon_0=0 +h=100000000 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gn_sinu +n=6 +m=3 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gnom +lon_0=-40 
## gdal with old: (0,0) -> (5351892,0)
## new: +proj=gnom +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5351892,0)
## sf    with new: (0,0) -> (5351892,0)
## 
## old: +proj=goode 
## gdal with old: (0,0) -> (0,0)
## new: +proj=goode +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=hatano 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=healpix +a=1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=rhealpix +south_square=0 +north_square=1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=igh 
## gdal with old: (0,0) -> (0,0)
## new: +proj=igh +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=kav5 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=kav7 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=laea +lon_0=-40 
## gdal with old: (0,0) -> (4362903,0)
## new: +proj=laea +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4362903,0)
## sf    with new: (0,0) -> (4362903,0)
## 
## old: +proj=longlat 
## gdal with old: (0,0) -> (0,0)
## new: +proj=longlat +ellps=GRS80 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=latlong 
## gdal with old: (0,0) -> (0,0)
## new: +proj=longlat +ellps=GRS80 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40 
## gdal with old: (0,0) -> (5628709,1578828)
## new: +proj=lcc +lat_1=30 +lat_2=70 +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5628709,1578828)
## sf    with new: (0,0) -> (5628709,1578828)
## 
## old: +proj=leac +lon_0=-40 
## gdal with old: (0,0) -> (4362502,770985.1)
## sf::st_crs() cannot handle this string
## 
## old: +proj=loxim 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbt_s 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbt_fps 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfpp 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfpq 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfps 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=merc 
## gdal with old: (0,0) -> (0,7.081155e-10)
## new: +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,7.081155e-10)
## sf    with new: (0,0) -> (0,7.081155e-10)
## 
## old: +proj=mil_os 
## gdal with old: (0,0) -> (-2123168,-1819674)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mill 
## gdal with old: (0,0) -> (0,-8.851443e-10)
## new: +proj=mill +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +R_A +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-8.841549e-10)
## sf    with new: (0,0) -> (0,-8.841549e-10)
## 
## old: +proj=moll 
## gdal with old: (0,0) -> (0,0)
## new: +proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5361528,1350915)
## sf::st_crs() cannot handle this string
## 
## old: +proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5897888,1459482)
## sf::st_crs() cannot handle this string
## 
## old: +proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5384331,1373406)
## sf::st_crs() cannot handle this string
## 
## old: +proj=natearth 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nell 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nell_h 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nsper +h=90000000 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ocea 
## gdal with old: (0,0) -> (10018754,3.905483e-10)
## sf::st_crs() cannot handle this string
## 
## old: +proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60 
## gdal with old: (0,0) -> (7141028,617313.8)
## new: +proj=omerc +lat_0=0 +lonc=0 +alpha=0 +k=1 +x_0=0 +y_0=0 +gamma=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,1.411483e-09)
## sf    with new: (0,0) -> (0,1.411483e-09)
## 
## old: +proj=ortho 
## gdal with old: (0,0) -> (0,0)
## new: +proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5280655,1205140)
## sf::st_crs() cannot handle this string
## 
## old: +proj=poly +lon_0=-40 
## gdal with old: (0,0) -> (4452780,0)
## new: +proj=poly +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4452780,0)
## sf    with new: (0,0) -> (4452780,0)
## 
## old: +proj=putp1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp2 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp3 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp5 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp6 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp3p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp5p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp6p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=qua_aut 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=qsc +lon_0=-100 
## gdal with old: (0,0) -> (12767567,0)
## new: +proj=qsc +lat_0=0 +lon_0=-100 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (12767567,0)
## sf    with new: (0,0) -> (12767567,0)
## 
## old: +proj=robin 
## gdal with old: (0,0) -> (0,-4.488677e-11)
## new: +proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4.488677e-11)
## sf    with new: (0,0) -> (0,-4.488677e-11)
## 
## old: +proj=rouss +lon_0=-40 
## gdal with old: (0,0) -> (4643785,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=sinu 
## gdal with old: (0,0) -> (0,0)
## new: +proj=sinu +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=stere +lat_0=90 
## gdal with old: (0,0) -> (0,-12713600)
## new: +proj=stere +lat_0=90 +lat_ts=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-12713600)
## sf    with new: (0,0) -> (0,-12713600)
## 
## old: +proj=sterea +lat_0=90 
## gdal with old: (0,0) -> (0,-12713600)
## new: +proj=sterea +lat_0=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-12713600)
## sf    with new: (0,0) -> (0,-12713600)
## 
## old: +proj=tcea +lon_0=-40 
## gdal with old: (0,0) -> (4099787,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5938018,-678110.7)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tmerc +lon_0=-40 +lat_1=30 +lat_2=60 
## gdal with old: (0,0) -> (4869526,0)
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## old: +proj=tpeqd +lat_1=30 +lon_1=-80 
## gdal with old: (0,0) -> (4527967,0)
## new: +proj=tpeqd +lat_1=30 +lon_1=-80 +lat_2=0 +lon_2=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4527967,0)
## sf    with new: (0,0) -> (4527967,0)
## 
## old: +proj=tpers +h=1e8 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ups +ellps=WGS84 
## gdal with old: (0,0) -> (2e+06,-10637318)
## sf::st_crs() cannot handle this string
## 
## old: +proj=urmfps +n=0.9 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=utm +ellps=WGS84 +lon_0=-40 
## gdal with old: (0,0) -> (5223033,0)
## new: +proj=tmerc +lat_0=0 +lon_0=-183 +k=0.9996 +x_0=500000 +y_0=0 +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5223033,0)
## sf    with new: (0,0) -> (166021.4,19995930)
## 
## old: +proj=vandg 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg +lon_0=0 +x_0=0 +y_0=0 +R_A +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5296219,1262193)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wag1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag2 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag3 +lat_ts=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag4 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag5 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag6 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=weren 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wink1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wintri 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
{% endhighlight %}

# Test proj list


{% highlight r linenos=table %}
options(warn=-1)
zero <- cbind(0, 0)
ll <- sf::st_crs("+proj=longlat")$proj4string
for (projOld in projTest) {
    cat("old:", projOld, "\n")
    xy <- try(rgdal::project(zero, projOld), silent=TRUE)
    if (inherits(xy, "try-error")) {
        cat("gdal::project(...,'", projOld, "') failed\n", sep="")
    } else {
        cat("gdal with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
    }
    projNew <- try(sf::st_crs(projOld)$proj4string, silent=TRUE)
    if (!is.na(projNew)) {
        cat("new:", projNew, "\n")
        xy <- sf::sf_project(ll, projOld, zero)
        cat("sf    with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- sf::sf_project(ll, projNew, zero)
        cat("sf    with new: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- rgdal::project(zero, projNew)
    } else {
        cat("sf::st_crs() cannot handle this string\n")
    }
    cat("\n")
}
{% endhighlight %}



{% highlight text %}
## old: +proj=aea +lat_1=10 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (4669884,857748.7)
## new: +proj=aea +lat_1=10 +lat_2=60 +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
## 
## old: +proj=aeqd 
## gdal with old: (0,0) -> (0,0)
## new: +proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=affine 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=airy 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=aitoff 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=alsk 
## gdal with old: (0,0) -> (1400338545,-1610256873)
## sf::st_crs() cannot handle this string
## 
## old: +proj=apian 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=august 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bacon 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bertin1953 
## gdal with old: (0,0) -> (-1659633,-4370466)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bipc 
## gdal with old: (0,0) -> (2235009,-14651858)
## sf::st_crs() cannot handle this string
## 
## old: +proj=boggs 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=bonne +lat_1=45 
## gdal with old: (0,0) -> (0,-4984944)
## new: +proj=bonne +lon_0=0 +lat_1=45 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4984944)
## sf    with new: (0,0) -> (0,-4984944)
## 
## old: +proj=calcofi 
## gdal with old: (0,0) -> (507.9077,-1138.973)
## sf::st_crs() cannot handle this string
## 
## old: +proj=cart 
## gdal with old: (0,0) -> (6378137,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=cass 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cass +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=cc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ccon +lat_1=45 
## gdal with old: (0,0) -> (0,-6378137)
## sf::st_crs() cannot handle this string
## 
## old: +proj=cea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cea +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=chamb +lat_1=10 +lon_1=30 +lon_2=40 
## gdal with old: (0,0) -> (-2404290,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=collg 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=comill 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=crast 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=denoy 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=eck1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck1 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck2 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck3 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck5 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck6 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqearth 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=eqc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqdc +lat_1=55 +lat_2=60 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eqdc +lat_0=0 +lon_0=0 +lat_1=55 +lat_2=60 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=euler +lat_1=67 +lat_2=75 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=etmerc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=etmerc 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=fahey 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=fouc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=fouc_s 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gall 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gall +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=geoc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=geogoffset 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=geos +h=1e8 
## gdal with old: (0,0) -> (0,0)
## new: +proj=geos +lon_0=0 +h=100000000 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gins8 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gn_sinu +n=6 +m=3 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gnom 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gnom +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=goode 
## gdal with old: (0,0) -> (0,0)
## new: +proj=goode +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gs48 
## gdal with old: (0,0) -> (32274266,7751687)
## sf::st_crs() cannot handle this string
## 
## old: +proj=gs50 
## gdal with old: (0,0) -> (23082711329,-13573057574)
## sf::st_crs() cannot handle this string
## 
## old: +proj=hammer 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=hatano 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=healpix 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=rhealpix 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=helmert 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=igh 
## gdal with old: (0,0) -> (0,0)
## new: +proj=igh +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=imw_p +lat_1=30 +lat_2=-40 
## gdal with old: (0,0) -> (0,0)
## new: +proj=imw_p +lat_1=30 +lat_2=-40 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=isea 
## gdal with old: (0,0) -> (-1332944,3326857)
## sf::st_crs() cannot handle this string
## 
## old: +proj=kav5 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=kav7 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=krovak 
## gdal with old: (0,0) -> (-3511150,-6690756)
## new: +proj=krovak +lat_0=0 +lon_0=0 +alpha=30.28813972222222 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-7118426)
## sf    with new: (0,0) -> (0,-7118426)
## 
## old: +proj=labrd +lon_0=40 +lat_0=-10 
## gdal with old: (0,0) -> (-4861426,1105769)
## sf::st_crs() cannot handle this string
## 
## old: +proj=laea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=laea +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lagrng 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=larr 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=lask 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=lonlat 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=latlon 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40 
## gdal with old: (0,0) -> (5628709,1578828)
## new: +proj=lcc +lat_1=30 +lat_2=70 +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (5628709,1578828)
## sf    with new: (0,0) -> (5628709,1578828)
## 
## old: +proj=lcca +lat_0=35 
## gdal with old: (0,0) -> (0,-4113452)
## sf::st_crs() cannot handle this string
## 
## old: +proj=leac 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=lee_os 
## gdal with old: (0,0) -> (-12466562,93160410)
## sf::st_crs() cannot handle this string
## 
## old: +proj=loxim 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=lsat +lat_1=-60 +lat_2=60 +lsat=2 +path=2 
## gdal with old: (0,0) -> (18650560,9627463)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbt_s 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbt_fps 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfpp 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfpq 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mbtfps 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=merc 
## gdal with old: (0,0) -> (0,7.081155e-10)
## new: +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,7.081155e-10)
## sf    with new: (0,0) -> (0,7.081155e-10)
## 
## old: +proj=mil_os 
## gdal with old: (0,0) -> (-2123168,-1819674)
## sf::st_crs() cannot handle this string
## 
## old: +proj=mill 
## gdal with old: (0,0) -> (0,-8.851443e-10)
## new: +proj=mill +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +R_A +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-8.841549e-10)
## sf    with new: (0,0) -> (0,-8.841549e-10)
## 
## old: +proj=misrsom +path=1 
## gdal with old: (0,0) -> (18922397,9157574)
## sf::st_crs() cannot handle this string
## 
## old: +proj=moll 
## gdal with old: (0,0) -> (0,0)
## new: +proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5361528,1350915)
## sf::st_crs() cannot handle this string
## 
## old: +proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5897888,1459482)
## sf::st_crs() cannot handle this string
## 
## old: +proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5384331,1373406)
## sf::st_crs() cannot handle this string
## 
## old: +proj=natearth 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=natearth2 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nell 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nell_h 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nicol 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nsper +h=90000000 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=nzmg 
## gdal with old: (0,0) -> (3889446253,-7280543850)
## new: +proj=nzmg +lat_0=-41 +lon_0=173 +x_0=2510000 +y_0=6023150 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (3889446253,-7280543850)
## sf    with new: (0,0) -> (3889446253,-7280543850)
## 
## old: +proj=noop 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ocea 
## gdal with old: (0,0) -> (10018754,3.905483e-10)
## sf::st_crs() cannot handle this string
## 
## old: +proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60 
## gdal with old: (0,0) -> (7141028,617313.8)
## new: +proj=omerc +lat_0=0 +lonc=0 +alpha=0 +k=1 +x_0=0 +y_0=0 +gamma=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,1.411483e-09)
## sf    with new: (0,0) -> (0,1.411483e-09)
## 
## old: +proj=ortel 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ortho 
## gdal with old: (0,0) -> (0,0)
## new: +proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5280655,1205140)
## sf::st_crs() cannot handle this string
## 
## old: +proj=patterson 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=poly +lon_0=-40 
## gdal with old: (0,0) -> (4452780,0)
## new: +proj=poly +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4452780,0)
## sf    with new: (0,0) -> (4452780,0)
## 
## old: +proj=pop 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=push 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp2 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp3 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp3p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp4p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp5 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp5p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp6 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=putp6p 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=qua_aut 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=qsc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=qsc +lat_0=0 +lon_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=robin 
## gdal with old: (0,0) -> (0,-4.488677e-11)
## new: +proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4.488677e-11)
## sf    with new: (0,0) -> (0,-4.488677e-11)
## 
## old: +proj=rouss 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=rpoly 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=sinu 
## gdal with old: (0,0) -> (0,0)
## new: +proj=sinu +lon_0=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=somerc 
## gdal with old: (0,0) -> (0,-7.057413e-10)
## new: +proj=somerc +lat_0=0 +lon_0=0 +k_0=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-7.057413e-10)
## sf    with new: (0,0) -> (0,-7.057413e-10)
## 
## old: +proj=stere 
## gdal with old: (0,0) -> (0,0)
## new: +proj=stere +lat_0=0 +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=sterea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=sterea +lat_0=0 +lon_0=0 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gstmerc 
## gdal with old: (0,0) -> (-7.057413e-10,-7.057413e-10)
## new: +proj=gstmerc +lat_0=-21.116666667 +lon_0=55.53333333309 +k_0=1 +x_0=160000 +y_0=50000 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (-7.057413e-10,-7.057413e-10)
## sf    with new: (0,0) -> (-7315328,2384035)
## 
## old: +proj=tcc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tcea 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=times 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5938018,-678110.7)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tmerc +lon_0=-40 +lat_1=30 +lat_2=60 
## gdal with old: (0,0) -> (4869526,0)
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## old: +proj=tobmerc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=tpeqd +lat_1=60 +lat_2=65 
## gdal with old: (0,0) -> (-6957468,0)
## new: +proj=tpeqd +lat_1=60 +lon_1=0 +lat_2=65 +lon_2=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (-6957468,0)
## sf    with new: (0,0) -> (-6957468,0)
## 
## old: +proj=tpers +h=1e8 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=ups +ellps=WGS84 
## gdal with old: (0,0) -> (2e+06,-10637318)
## sf::st_crs() cannot handle this string
## 
## old: +proj=urmfps +n=0.9 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=utm 
## gdal with old: (0,0) -> (833978.6,0)
## new: +proj=tmerc +lat_0=0 +lon_0=-183 +k=0.9996 +x_0=500000 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (166021.4,19995930)
## sf    with new: (0,0) -> (166021.4,19995930)
## 
## old: +proj=vandg 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg +lon_0=0 +x_0=0 +y_0=0 +R_A +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vandg2 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=vandg3 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=vandg4 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5296219,1262193)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wag1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag1 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag2 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag3 +lat_ts=0 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag4 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag5 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag6 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag7 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag7 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=webmerc 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=weren 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wink1 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wink2 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
## 
## old: +proj=wintri 
## gdal with old: (0,0) -> (0,0)
## sf::st_crs() cannot handle this string
{% endhighlight %}

# References and resources

1. [Oce website](https://dankelley.github.io/oce/)

2. [proj website](https://proj.org/operations/projections/index.html)

3. Jekyll source code for this blog entry: [2020-04-16-map-projection.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-01-16-map-projection.Rmd)

