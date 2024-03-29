---
layout: post
title: oce map projections in context of switch from rgdal to sf
tags: [oce, map, R]
category: R
year: 2020
month: 8
day: 2
summary: This blog posting tests whether the projections used in a previous posting about oce will work with the `sf` scheme as of Aug 30, 2020, and is an update to a similar test on Jan 16, 2020, after removing tests of `geoc`, `healpix`, `helmert` and `rhealpix`, which now fail with `sf`. Of these problematic projections, only `healpix` and `rhealpix` were provided by the latest CRAN release of `oce`, and they will be removed from the development version, since they never were useful, as `oce::mapPlot()` plotted in the off-world regions (see http://dankelley.github.io/r/2020/01/04/oce-proj.html).

---

**Executive Summary.** this updates a [previous
posting](http://dankelley.github.io/r/2020/01/16/map-projection.html) by
removing `healpix` and `rhealpix`, which are not handled properly by `sf`.
These projections were useless anyway, since `oce::mapPlot()` plotted in the
off-world regions (see http://dankelley.github.io/r/2020/01/04/oce-proj.html).


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



These functions are in oce, but not in proj: **longlat, latlong**.

These functions are in proj, but not in oce: **affine, airy, alsk, apian, august, bacon, bertin, boggs, calcofi, cart, ccon, chamb, comill, denoy, eqdc, geogoffset, gins, gs, gs, hammer, imw_p, isea, krovak, labrd, lagrng, larr, lask, lonlat, latlon, lcca, lee_os, lsat, misrsom, nicol, nzmg, noop, ortel, patterson, pop, push, rpoly, somerc, gstmerc, tcc, times, tobmerc, webmerc**.

# Test oce list


{% highlight r linenos=table %}
#options(warn=-1)
zero <- cbind(0, 0)
ll <- sf::st_crs("+proj=longlat")$proj4string
for (projOld in oceTest) {
    cat("projOld '", projOld, "'\n", sep="")
    xy <- try(rgdal::project(zero, projOld), silent=TRUE)
    if (inherits(xy, "try-error")) {
        cat("gdal::project(...,'", projOld, "') failed\n", sep="")
    } else {
        cat("gdal with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
    }
    projNew <- try(sf::st_crs(projOld)$proj4string, silent=TRUE)
    if (inherits(projNew, "try-error")) {
        cat("sf::st_crs(projOld)$proj4string failed\n")
    } else {
        cat("projNew '", projNew, "'\n", sep="")
        cat('  is projNew bad?', inherits(projNew, "try-error"), "\n")
        if (!is.na(projNew)) {
            cat("new:", projNew, "\n")
            xy <- sf::sf_project(ll, projOld, zero)
            if (inherits(xy, "try-error")) {
                cat("sf::sf_project failed with projOld='", projOld, "'\n", sep="")
            } else {
                cat("sf    with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
                xy <- sf::sf_project(ll, projNew, zero)
                if (inherits(xy, "try-error")) {
                    cat("cannot transform projNew='", projNew, "'\n", sep="")
                } else {
                    cat("sf    with new: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
                    xy <- rgdal::project(zero, projNew)
                }
            }
        } else {
            cat("sf::st_crs() cannot handle this string\n")
        }
    }
    cat("\n")
}
{% endhighlight %}



{% highlight text %}
## projOld '+proj=aea +lat_1=10 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (4669884,857748.7)
## projNew '+proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
## 
## projOld '+proj=aeqd +lon_0=-45'
## gdal with old: (0,0) -> (5009377,3.067359e-10)
## projNew '+proj=aeqd +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=aeqd +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,3.067359e-10)
## sf    with new: (0,0) -> (5009377,3.067359e-10)
## 
## projOld '+proj=aitoff +lon_0=-45'
## gdal with old: (0,0) -> (5009377,0)
## projNew '+proj=aitoff +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=aitoff +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,0)
## sf    with new: (0,0) -> (5009377,0)
## 
## projOld '+proj=bipc'
## gdal with old: (0,0) -> (2235009,-14651858)
## projNew '+proj=bipc +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=bipc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (2235009,-14651858)
## sf    with new: (0,0) -> (2235009,-14651858)
## 
## projOld '+proj=bonne +lat_1=45'
## gdal with old: (0,0) -> (0,-4984944)
## projNew '+proj=bonne +lat_1=45 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=bonne +lat_1=45 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4984944)
## sf    with new: (0,0) -> (0,-4984944)
## 
## projOld '+proj=cass +lon_0=-45'
## gdal with old: (0,0) -> (5009377,0)
## projNew '+proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,0)
## sf    with new: (0,0) -> (5009377,0)
## 
## projOld '+proj=cass +lon_0=-45'
## gdal with old: (0,0) -> (5009377,0)
## projNew '+proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=cass +lat_0=0 +lon_0=-45 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5009377,0)
## sf    with new: (0,0) -> (5009377,0)
## 
## projOld '+proj=cc'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=cc +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=cc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=cea'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=cea +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=cea +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=collg'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=collg +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=collg +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=crast'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=crast +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=crast +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck1'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck2'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck3'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck3 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck3 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck4'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck5'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eck6'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eck6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eck6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eqc'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=eqearth'
## gdal with old: (0,0) -> (0,0)
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Equal Earth
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Equal Earth
{% endhighlight %}



{% highlight text %}
## projNew '+proj=eqearth +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=eqearth +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=euler +lat_1=45 +lat_2=50 +lon_0=-40'
## gdal with old: (0,0) -> (5478194,1441354)
## projNew '+proj=euler +lat_1=45 +lat_2=50 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=euler +lat_1=45 +lat_2=50 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5478194,1441354)
## sf    with new: (0,0) -> (5478194,1441354)
## 
## projOld '+proj=etmerc +ellps=WGS84 +lon_0=-40'
## gdal with old: (0,0) -> (4869526,0)
## projNew '+proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## projOld '+proj=etmerc +ellps=WGS84 +lon_0=-40'
## gdal with old: (0,0) -> (4869526,0)
## projNew '+proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## projOld '+proj=fahey'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=fahey +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=fahey +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=fouc'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=fouc +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=fouc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=fouc_s'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=fouc_s +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=fouc_s +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=gall'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=gall +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=gall +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=geos +h=1e8'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=geos +lon_0=0 +h=100000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=geos +lon_0=0 +h=100000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=gn_sinu +n=6 +m=3'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=gn_sinu +n=6 +m=3 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=gn_sinu +n=6 +m=3 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=gnom +lon_0=-40'
## gdal with old: (0,0) -> (5351892,0)
## projNew '+proj=gnom +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=gnom +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5351892,0)
## sf    with new: (0,0) -> (5351892,0)
## 
## projOld '+proj=goode'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=goode +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=goode +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=hatano'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=hatano +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=hatano +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=igh'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=igh +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=igh +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=kav5'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=kav5 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=kav5 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=kav7'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=kav7 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=kav7 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=laea +lon_0=-40'
## gdal with old: (0,0) -> (4362903,0)
## projNew '+proj=laea +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=laea +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4362903,0)
## sf    with new: (0,0) -> (4362903,0)
## 
## projOld '+proj=longlat'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=longlat +datum=WGS84 +no_defs'
##   is projNew bad? FALSE 
## new: +proj=longlat +datum=WGS84 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=latlong'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=longlat +datum=WGS84 +no_defs'
##   is projNew bad? FALSE 
## new: +proj=longlat +datum=WGS84 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40'
## gdal with old: (0,0) -> (5628709,1578828)
## projNew '+proj=lcc +lat_0=0 +lon_0=-40 +lat_1=30 +lat_2=70 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=lcc +lat_0=0 +lon_0=-40 +lat_1=30 +lat_2=70 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5628709,1578828)
## sf    with new: (0,0) -> (5628709,1578828)
## 
## projOld '+proj=leac +lon_0=-40'
## gdal with old: (0,0) -> (4362502,770985.1)
## projNew '+proj=leac +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=leac +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4362502,770985.1)
## sf    with new: (0,0) -> (4362502,770985.1)
## 
## projOld '+proj=loxim'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=loxim +lat_1=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=loxim +lat_1=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=mbt_s'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=mbt_s +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mbt_s +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=mbt_fps'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=mbt_fps +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mbt_fps +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=mbtfpp'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=mbtfpp +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mbtfpp +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=mbtfpq'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=mbtfpq +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mbtfpq +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=mbtfps'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=mbtfps +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mbtfps +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=merc'
## gdal with old: (0,0) -> (0,7.081155e-10)
## projNew '+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,7.081155e-10)
## sf    with new: (0,0) -> (0,7.081155e-10)
## 
## projOld '+proj=mil_os'
## gdal with old: (0,0) -> (-2123168,-1819674)
## projNew '+proj=mil_os +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mil_os +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-2123168,-1819674)
## sf    with new: (0,0) -> (-2123168,-1819674)
## 
## projOld '+proj=mill'
## gdal with old: (0,0) -> (0,-8.841549e-10)
## projNew '+proj=mill +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=mill +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-8.841549e-10)
## sf    with new: (0,0) -> (0,-8.841549e-10)
## 
## projOld '+proj=moll'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=moll +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=moll +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5361528,1350915)
## projNew '+proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5361528,1350915)
## sf    with new: (0,0) -> (5361528,1350915)
## 
## projOld '+proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5897888,1459482)
## projNew '+proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5897888,1459482)
## sf    with new: (0,0) -> (5897888,1459482)
## 
## projOld '+proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5384331,1373406)
## projNew '+proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5384331,1373406)
## sf    with new: (0,0) -> (5384331,1373406)
## 
## projOld '+proj=natearth'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=natearth +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=natearth +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=nell'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=nell +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=nell +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=nell_h'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=nell_h +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=nell_h +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=nsper +h=90000000'
## gdal with old: (0,0) -> (0,0)
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Vertical Perspective
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Vertical Perspective
{% endhighlight %}



{% highlight text %}
## projNew '+proj=nsper +lat_0=0 +lon_0=0 +h=90000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=nsper +lat_0=0 +lon_0=0 +h=90000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=ocea'
## gdal with old: (0,0) -> (10018754,3.905483e-10)
## projNew '+proj=ocea +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=ocea +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (10018754,3.905483e-10)
## sf    with new: (0,0) -> (10018754,3.905483e-10)
## 
## projOld '+proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60'
## gdal with old: (0,0) -> (0,1.411483e-09)
## projNew '+proj=omerc +lat_0=0 +lonc=0 +alpha=0 +gamma=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=omerc +lat_0=0 +lonc=0 +alpha=0 +gamma=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,1.411483e-09)
## sf    with new: (0,0) -> (0,1.411483e-09)
## 
## projOld '+proj=ortho'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5280655,1205140)
## projNew '+proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5280655,1205140)
## sf    with new: (0,0) -> (5280655,1205140)
## 
## projOld '+proj=poly +lon_0=-40'
## gdal with old: (0,0) -> (4452780,0)
## projNew '+proj=poly +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=poly +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4452780,0)
## sf    with new: (0,0) -> (4452780,0)
## 
## projOld '+proj=putp1'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp1 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp1 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp2'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp2 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp2 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp3'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp3 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp3 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp5'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp5 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp5 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp6'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp6 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp6 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp3p'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp3p +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp3p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp5p'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp5p +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp5p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=putp6p'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=putp6p +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=putp6p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=qua_aut'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=qua_aut +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=qua_aut +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=qsc +lon_0=-100'
## gdal with old: (0,0) -> (12767567,0)
## projNew '+proj=qsc +lat_0=0 +lon_0=-100 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=qsc +lat_0=0 +lon_0=-100 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (12767567,0)
## sf    with new: (0,0) -> (12767567,0)
## 
## projOld '+proj=robin'
## gdal with old: (0,0) -> (0,-4.488677e-11)
## projNew '+proj=robin +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=robin +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4.488677e-11)
## sf    with new: (0,0) -> (0,-4.488677e-11)
## 
## projOld '+proj=rouss +lon_0=-40'
## gdal with old: (0,0) -> (4643785,0)
## projNew '+proj=rouss +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=rouss +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4643785,0)
## sf    with new: (0,0) -> (4643785,0)
## 
## projOld '+proj=sinu'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=sinu +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=stere +lat_0=90'
## gdal with old: (0,0) -> (0,-12713600)
## projNew '+proj=stere +lat_0=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=stere +lat_0=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-12713600)
## sf    with new: (0,0) -> (0,-12713600)
## 
## projOld '+proj=sterea +lat_0=90'
## gdal with old: (0,0) -> (0,-12713600)
## projNew '+proj=sterea +lat_0=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=sterea +lat_0=90 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-12713600)
## sf    with new: (0,0) -> (0,-12713600)
## 
## projOld '+proj=tcea +lon_0=-40'
## gdal with old: (0,0) -> (4099787,0)
## projNew '+proj=tcea +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tcea +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4099787,0)
## sf    with new: (0,0) -> (4099787,0)
## 
## projOld '+proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5938018,-678110.7)
## projNew '+proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5938018,-678110.7)
## sf    with new: (0,0) -> (5938018,-678110.7)
## 
## projOld '+proj=tmerc +lon_0=-40 +lat_1=30 +lat_2=60'
## gdal with old: (0,0) -> (4869526,0)
## projNew '+proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## projOld '+proj=tpeqd +lat_1=30 +lon_1=-80'
## gdal with old: (0,0) -> (4527967,0)
## projNew '+proj=tpeqd +lat_1=30 +lon_1=-80 +lat_2=0 +lon_2=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tpeqd +lat_1=30 +lon_1=-80 +lat_2=0 +lon_2=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4527967,0)
## sf    with new: (0,0) -> (4527967,0)
## 
## projOld '+proj=tpers +h=1e8'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=tpers +h=100000000 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tpers +h=100000000 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=ups +ellps=WGS84'
## gdal with old: (0,0) -> (2e+06,-10637318)
## projNew '+proj=ups +ellps=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=ups +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (2e+06,-10637318)
## sf    with new: (0,0) -> (2e+06,-10637318)
## 
## projOld '+proj=urmfps +n=0.9'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=urmfps +n=0.9 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=urmfps +n=0.9 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=utm +ellps=WGS84 +lon_0=-40'
## gdal with old: (0,0) -> (5223033,0)
## projNew '+proj=tmerc +lat_0=0 +lon_0=-183 +k=0.9996 +x_0=500000 +y_0=0 +ellps=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=tmerc +lat_0=0 +lon_0=-183 +k=0.9996 +x_0=500000 +y_0=0 +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5223033,0)
## sf    with new: (0,0) -> (166021.4,19995930)
## 
## projOld '+proj=vandg'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=vandg +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=vandg +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40'
## gdal with old: (0,0) -> (5296219,1262193)
## projNew '+proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5296219,1262193)
## sf    with new: (0,0) -> (5296219,1262193)
## 
## projOld '+proj=wag1'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wag2'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wag3'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag3 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag3 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wag4'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wag5'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wag6'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wag6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wag6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=weren'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=weren +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=weren +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wink1'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wink1 +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wink1 +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## projOld '+proj=wintri'
## gdal with old: (0,0) -> (0,0)
## projNew '+proj=wintri +lon_0=0 +lat_1=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=wintri +lon_0=0 +lat_1=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
{% endhighlight %}

# Test proj list


{% highlight r linenos=table %}
#options(warn=-1)
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
## new: +proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
## 
## old: +proj=aeqd 
## gdal with old: (0,0) -> (0,0)
## new: +proj=aeqd +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=affine 
## gdal with old: (0,0) -> (0,0)
## new: +proj=affine +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=airy 
## gdal with old: (0,0) -> (0,0)
## new: +proj=airy +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=aitoff 
## gdal with old: (0,0) -> (0,0)
## new: +proj=aitoff +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=alsk 
## gdal with old: (0,0) -> (1400338545,-1610256873)
## new: +proj=alsk +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (1400338545,-1610256873)
## sf    with new: (0,0) -> (1400338545,-1610256873)
## 
## old: +proj=apian 
## gdal with old: (0,0) -> (0,0)
## new: +proj=apian +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=august 
## gdal with old: (0,0) -> (0,0)
## new: +proj=august +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=bacon 
## gdal with old: (0,0) -> (0,0)
## new: +proj=bacon +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=bertin1953 
## gdal with old: (0,0) -> (-1659633,-4370466)
## new: +proj=bertin1953 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-1659633,-4370466)
## sf    with new: (0,0) -> (-1659633,-4370466)
## 
## old: +proj=bipc 
## gdal with old: (0,0) -> (2235009,-14651858)
## new: +proj=bipc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (2235009,-14651858)
## sf    with new: (0,0) -> (2235009,-14651858)
## 
## old: +proj=boggs 
## gdal with old: (0,0) -> (0,0)
## new: +proj=boggs +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=bonne +lat_1=45 
## gdal with old: (0,0) -> (0,-4984944)
## new: +proj=bonne +lat_1=45 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4984944)
## sf    with new: (0,0) -> (0,-4984944)
## 
## old: +proj=calcofi 
## gdal with old: (0,0) -> (507.9077,-1138.973)
## new: +proj=calcofi +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (507.9077,-1138.973)
## sf    with new: (0,0) -> (507.9077,-1138.973)
## 
## old: +proj=cart 
## gdal with old: (0,0) -> (0,0)
## new: +proj=geocent +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (6378137,0)
## sf    with new: (0,0) -> (6378137,0)
## 
## old: +proj=cass 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cass +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=cc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=ccon +lat_1=45 
## gdal with old: (0,0) -> (0,-6378137)
## new: +proj=ccon +lat_1=45 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-6378137)
## sf    with new: (0,0) -> (0,-6378137)
## 
## old: +proj=cea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=cea +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=chamb +lat_1=10 +lon_1=30 +lon_2=40 
## gdal with old: (0,0) -> (-2404290,0)
## new: +proj=chamb +lat_1=10 +lon_1=30 +lon_2=40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-2404290,0)
## sf    with new: (0,0) -> (-2404290,0)
## 
## old: +proj=collg 
## gdal with old: (0,0) -> (0,0)
## new: +proj=collg +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=comill 
## gdal with old: (0,0) -> (0,0)
## new: +proj=comill +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=crast 
## gdal with old: (0,0) -> (0,0)
## new: +proj=crast +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=denoy 
## gdal with old: (0,0) -> (0,0)
## new: +proj=denoy +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck3 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eck6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eck6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eqc +lat_ts=0 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqdc +lat_1=55 +lat_2=60 
## gdal with old: (0,0) -> (0,0)
## new: +proj=eqdc +lat_0=0 +lon_0=0 +lat_1=55 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=eqearth 
## gdal with old: (0,0) -> (0,0)
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Equal Earth
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Equal Earth
{% endhighlight %}



{% highlight text %}
## new: +proj=eqearth +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=euler +lat_1=67 +lat_2=75 
## gdal with old: (0,0) -> (0,0)
## new: +proj=euler +lat_1=67 +lat_2=75 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=etmerc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=tmerc +lat_0=0 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=fahey 
## gdal with old: (0,0) -> (0,0)
## new: +proj=fahey +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=fouc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=fouc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=fouc_s 
## gdal with old: (0,0) -> (0,0)
## new: +proj=fouc_s +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gall 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gall +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=geogoffset 
## gdal with old: (0,0) -> (0,0)
## new: +proj=geogoffset +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=geos +h=1e8 
## gdal with old: (0,0) -> (0,0)
## new: +proj=geos +lon_0=0 +h=100000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gins8 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gins8 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gn_sinu +n=6 +m=3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gn_sinu +n=6 +m=3 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gnom 
## gdal with old: (0,0) -> (0,0)
## new: +proj=gnom +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=goode 
## gdal with old: (0,0) -> (0,0)
## new: +proj=goode +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gs48 
## gdal with old: (0,0) -> (32274266,7751687)
## new: +proj=gs48 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (32274266,7751687)
## sf    with new: (0,0) -> (32274266,7751687)
## 
## old: +proj=gs50 
## gdal with old: (0,0) -> (23082711329,-13573057574)
## new: +proj=gs50 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (23082711329,-13573057574)
## sf    with new: (0,0) -> (23082711329,-13573057574)
## 
## old: +proj=hammer 
## gdal with old: (0,0) -> (0,0)
## new: +proj=hammer +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=hatano 
## gdal with old: (0,0) -> (0,0)
## new: +proj=hatano +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=igh 
## gdal with old: (0,0) -> (0,0)
## new: +proj=igh +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=imw_p +lat_1=30 +lat_2=-40 
## gdal with old: (0,0) -> (0,0)
## new: +proj=imw_p +lon_0=0 +lat_1=30 +lat_2=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=isea 
## gdal with old: (0,0) -> (-1332944,3326857)
## new: +proj=isea +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-1332944,3326857)
## sf    with new: (0,0) -> (-1332944,3326857)
## 
## old: +proj=kav5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=kav5 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=kav7 
## gdal with old: (0,0) -> (0,0)
## new: +proj=kav7 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=krovak 
## gdal with old: (0,0) -> (0,-7118426)
## new: +proj=krovak +lat_0=0 +lon_0=0 +alpha=30.2881397527778 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-7118426)
## sf    with new: (0,0) -> (0,-7118426)
## 
## old: +proj=labrd +lon_0=40 +lat_0=-10 
## gdal with old: (0,0) -> (-4861426,1105769)
## new: +proj=labrd +lat_0=-10 +lon_0=40 +azi=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-4861426,1105769)
## sf    with new: (0,0) -> (-4861426,1105769)
## 
## old: +proj=laea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=laea +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lagrng 
## gdal with old: (0,0) -> (0,0)
## new: +proj=lagrng +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=larr 
## gdal with old: (0,0) -> (0,0)
## new: +proj=larr +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lask 
## gdal with old: (0,0) -> (0,0)
## new: +proj=lask +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lonlat 
## gdal with old: (0,0) -> (0,0)
## new: +proj=longlat +datum=WGS84 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=latlon 
## gdal with old: (0,0) -> (0,0)
## new: +proj=longlat +datum=WGS84 +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lcc +lat_1=30 +lat_2=70 +lon_0=-40 
## gdal with old: (0,0) -> (5628709,1578828)
## new: +proj=lcc +lat_0=0 +lon_0=-40 +lat_1=30 +lat_2=70 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5628709,1578828)
## sf    with new: (0,0) -> (5628709,1578828)
## 
## old: +proj=lcca +lat_0=35 
## gdal with old: (0,0) -> (0,-4113452)
## new: +proj=lcca +lat_0=35 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4113452)
## sf    with new: (0,0) -> (0,-4113452)
## 
## old: +proj=leac 
## gdal with old: (0,0) -> (0,0)
## new: +proj=leac +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lee_os 
## gdal with old: (0,0) -> (-12466562,93160410)
## new: +proj=lee_os +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-12466562,93160410)
## sf    with new: (0,0) -> (-12466562,93160410)
## 
## old: +proj=loxim 
## gdal with old: (0,0) -> (0,0)
## new: +proj=loxim +lat_1=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=lsat +lat_1=-60 +lat_2=60 +lsat=2 +path=2 
## gdal with old: (0,0) -> (18650560,9627463)
## new: +proj=lsat +lsat=2 +path=2 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (18650560,9627463)
## sf    with new: (0,0) -> (18650560,9627463)
## 
## old: +proj=mbt_s 
## gdal with old: (0,0) -> (0,0)
## new: +proj=mbt_s +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=mbt_fps 
## gdal with old: (0,0) -> (0,0)
## new: +proj=mbt_fps +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=mbtfpp 
## gdal with old: (0,0) -> (0,0)
## new: +proj=mbtfpp +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=mbtfpq 
## gdal with old: (0,0) -> (0,0)
## new: +proj=mbtfpq +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=mbtfps 
## gdal with old: (0,0) -> (0,0)
## new: +proj=mbtfps +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=merc 
## gdal with old: (0,0) -> (0,7.081155e-10)
## new: +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,7.081155e-10)
## sf    with new: (0,0) -> (0,7.081155e-10)
## 
## old: +proj=mil_os 
## gdal with old: (0,0) -> (-2123168,-1819674)
## new: +proj=mil_os +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-2123168,-1819674)
## sf    with new: (0,0) -> (-2123168,-1819674)
## 
## old: +proj=mill 
## gdal with old: (0,0) -> (0,-8.841549e-10)
## new: +proj=mill +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-8.841549e-10)
## sf    with new: (0,0) -> (0,-8.841549e-10)
## 
## old: +proj=misrsom +path=1 
## gdal with old: (0,0) -> (18922397,9157574)
## new: +proj=misrsom +path=1 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (18922397,9157574)
## sf    with new: (0,0) -> (18922397,9157574)
## 
## old: +proj=moll 
## gdal with old: (0,0) -> (0,0)
## new: +proj=moll +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5361528,1350915)
## new: +proj=murd1 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5361528,1350915)
## sf    with new: (0,0) -> (5361528,1350915)
## 
## old: +proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5897888,1459482)
## new: +proj=murd2 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5897888,1459482)
## sf    with new: (0,0) -> (5897888,1459482)
## 
## old: +proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5384331,1373406)
## new: +proj=murd3 +lat_1=30 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5384331,1373406)
## sf    with new: (0,0) -> (5384331,1373406)
## 
## old: +proj=natearth 
## gdal with old: (0,0) -> (0,0)
## new: +proj=natearth +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=natearth2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=natearth2 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=nell 
## gdal with old: (0,0) -> (0,0)
## new: +proj=nell +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=nell_h 
## gdal with old: (0,0) -> (0,0)
## new: +proj=nell_h +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=nicol 
## gdal with old: (0,0) -> (0,0)
## new: +proj=nicol +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=nsper +h=90000000 
## gdal with old: (0,0) -> (0,0)
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Vertical Perspective
{% endhighlight %}



{% highlight text %}
## Warning in CPL_crs_parameters(x): GDAL Error 1: PROJ: proj_as_wkt: Unsupported
## conversion method: Vertical Perspective
{% endhighlight %}



{% highlight text %}
## new: +proj=nsper +lat_0=0 +lon_0=0 +h=90000000 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=nzmg 
## gdal with old: (0,0) -> (3889446253,-7280543850)
## new: +proj=nzmg +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (3889446253,-7280543850)
## sf    with new: (0,0) -> (3889446253,-7280543850)
## 
## old: +proj=noop 
## gdal with old: (0,0) -> (0,0)
## new: +proj=noop +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=ocea 
## gdal with old: (0,0) -> (10018754,3.905483e-10)
## new: +proj=ocea +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (10018754,3.905483e-10)
## sf    with new: (0,0) -> (10018754,3.905483e-10)
## 
## old: +proj=omerc +lat_1=30 +lon_1=-40 +lat_2=60 
## gdal with old: (0,0) -> (0,1.411483e-09)
## new: +proj=omerc +lat_0=0 +lonc=0 +alpha=0 +gamma=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,1.411483e-09)
## sf    with new: (0,0) -> (0,1.411483e-09)
## 
## old: +proj=ortel 
## gdal with old: (0,0) -> (0,0)
## new: +proj=ortel +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=ortho 
## gdal with old: (0,0) -> (0,0)
## new: +proj=ortho +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5280655,1205140)
## new: +proj=pconic +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5280655,1205140)
## sf    with new: (0,0) -> (5280655,1205140)
## 
## old: +proj=patterson 
## gdal with old: (0,0) -> (0,0)
## new: +proj=patterson +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=poly +lon_0=-40 
## gdal with old: (0,0) -> (4452780,0)
## new: +proj=poly +lat_0=0 +lon_0=-40 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4452780,0)
## sf    with new: (0,0) -> (4452780,0)
## 
## old: +proj=pop 
## gdal with old: (0,0) -> (0,0)
## new: +proj=pop +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=push 
## gdal with old: (0,0) -> (0,0)
## new: +proj=push +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp1 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp2 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp3 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp3p 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp3p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp4p 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp4p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp5 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp5p 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp5p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp6 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=putp6p 
## gdal with old: (0,0) -> (0,0)
## new: +proj=putp6p +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=qua_aut 
## gdal with old: (0,0) -> (0,0)
## new: +proj=qua_aut +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=qsc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=qsc +lat_0=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=robin 
## gdal with old: (0,0) -> (0,-4.488677e-11)
## new: +proj=robin +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-4.488677e-11)
## sf    with new: (0,0) -> (0,-4.488677e-11)
## 
## old: +proj=rouss 
## gdal with old: (0,0) -> (0,0)
## new: +proj=rouss +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=rpoly 
## gdal with old: (0,0) -> (0,0)
## new: +proj=rpoly +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=sinu 
## gdal with old: (0,0) -> (0,0)
## new: +proj=sinu +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=somerc 
## gdal with old: (0,0) -> (0,-7.057413e-10)
## new: +proj=somerc +lat_0=0 +lon_0=0 +k_0=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,-7.057413e-10)
## sf    with new: (0,0) -> (0,-7.057413e-10)
## 
## old: +proj=stere 
## gdal with old: (0,0) -> (0,0)
## new: +proj=stere +lat_0=0 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=sterea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=sterea +lat_0=0 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=gstmerc 
## gdal with old: (0,0) -> (-7.057413e-10,-7.057413e-10)
## new: +proj=gstmerc +lat_0=0 +lon_0=0 +k_0=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-7.057413e-10,-7.057413e-10)
## sf    with new: (0,0) -> (-7.057413e-10,-7.057413e-10)
## 
## old: +proj=tcc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=tcc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=tcea 
## gdal with old: (0,0) -> (0,0)
## new: +proj=tcea +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=times 
## gdal with old: (0,0) -> (0,0)
## new: +proj=times +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5938018,-678110.7)
## new: +proj=tissot +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5938018,-678110.7)
## sf    with new: (0,0) -> (5938018,-678110.7)
## 
## old: +proj=tmerc +lon_0=-40 +lat_1=30 +lat_2=60 
## gdal with old: (0,0) -> (4869526,0)
## new: +proj=tmerc +lat_0=0 +lon_0=-40 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4869526,0)
## sf    with new: (0,0) -> (4869526,0)
## 
## old: +proj=tobmerc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=tobmerc +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=tpeqd +lat_1=60 +lat_2=65 
## gdal with old: (0,0) -> (-6957468,0)
## new: +proj=tpeqd +lat_1=60 +lon_1=0 +lat_2=65 +lon_2=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (-6957468,0)
## sf    with new: (0,0) -> (-6957468,0)
## 
## old: +proj=tpers +h=1e8 
## gdal with old: (0,0) -> (0,0)
## new: +proj=tpers +h=100000000 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=ups +ellps=WGS84 
## gdal with old: (0,0) -> (2e+06,-10637318)
## new: +proj=ups +ellps=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (2e+06,-10637318)
## sf    with new: (0,0) -> (2e+06,-10637318)
## 
## old: +proj=urmfps +n=0.9 
## gdal with old: (0,0) -> (0,0)
## new: +proj=urmfps +n=0.9 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=utm 
## gdal with old: (0,0) -> (166021.4,19995930)
## new: +proj=tmerc +lat_0=0 +lon_0=-183 +k=0.9996 +x_0=500000 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (166021.4,19995930)
## sf    with new: (0,0) -> (166021.4,19995930)
## 
## old: +proj=vandg 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg +R_A +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vandg2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg2 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vandg3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg3 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vandg4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=vandg4 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 
## gdal with old: (0,0) -> (5296219,1262193)
## new: +proj=vitk1 +lat_1=20 +lat_2=60 +lon_0=-40 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (5296219,1262193)
## sf    with new: (0,0) -> (5296219,1262193)
## 
## old: +proj=wag1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag1 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag2 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag3 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag3 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag4 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag5 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag5 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag6 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag6 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wag7 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wag7 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=webmerc 
## gdal with old: (0,0) -> (0,0)
## new: +proj=merc +a=6378137 +b=6378137 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +k=1 +units=m +nadgrids=@null +wktext +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=weren 
## gdal with old: (0,0) -> (0,0)
## new: +proj=weren +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wink1 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wink1 +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wink2 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wink2 +lon_0=0 +lat_1=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
## 
## old: +proj=wintri 
## gdal with old: (0,0) -> (0,0)
## new: +proj=wintri +lon_0=0 +lat_1=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (0,0)
## sf    with new: (0,0) -> (0,0)
{% endhighlight %}

# References and resources

1. [Oce website](https://dankelley.github.io/oce/)

2. [proj website](https://proj.org/operations/projections/index.html)

3. Jekyll source code for this blog entry: [2020-04-16-map-projection.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-01-16-map-projection.Rmd)


