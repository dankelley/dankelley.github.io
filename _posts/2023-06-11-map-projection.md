---
layout: post
title: oce map projections in context of switch from rgdal to sf
tags: [oce, map, R]
category: R
year: 2023
month: 6
day: 11
summary: This blog repeats the posting from August 2, 2020.  The difference is that now the +proj=utm now requires a +zone= value.

---

**Executive Summary.** 
this updates a [previous posting](http:
//dankelley.github.io/r/2020/08/02/map-projection.html) from August 2, 2020.
The difference is that now the +proj=utm now requires a +zone= value.

# Introduction

The goal is to test the existing oce projections, and also the new proj
projections. The latter are recovered by typing the following in a unix
console.

{% highlight r linenos=table %}
proj -l       # list names of all projections
{% endhighlight %}
but note that a handful are actually transformations, not projections, and
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
## gdal::project(...,'+proj=aea +lat_1=10 +lat_2=60 +lon_0=-40') failed
## projNew '+proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'
##   is projNew bad? FALSE 
## new: +proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
{% endhighlight %}



{% highlight text %}
## Error in loadNamespace(x): there is no package called 'rgdal'
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
## gdal::project(...,'+proj=aea +lat_1=10 +lat_2=60 +lon_0=-40') failed
## new: +proj=aea +lat_0=0 +lon_0=-40 +lat_1=10 +lat_2=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs 
## sf    with old: (0,0) -> (4669884,857748.7)
## sf    with new: (0,0) -> (4669884,857748.7)
{% endhighlight %}



{% highlight text %}
## Error in loadNamespace(x): there is no package called 'rgdal'
{% endhighlight %}

# References and resources

1. [Oce website](https://dankelley.github.io/oce/)

2. [proj website](https://proj.org/operations/projections/index.html)

3. Jekyll source code for this blog entry: [2020-04-16-map-projection.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-01-16-map-projection.Rmd)


