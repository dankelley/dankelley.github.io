---
layout: post
title: oce map projection
tags: [R, oceanography, mapping, oce]
category: R
year: 2014
month: 2
day: 10
summary: The Oce package presently handles map projections by using the ``mapproj`` package, but an alternative is the ``proj4`` package.  This post compares the two, focussing on the vexing problem of islands crossing the edge of the earth, which causes spurious lines on some Oce maps at present.
description: The Oce package presently handles map projections by using the ``mapproj`` package, but an alternative is the ``proj4`` package.  This post compares the two, focussing on the vexing problem of islands crossing the edge of the earth, which causes spurious lines on some Oce maps at present.
---

# Introduction

Soon after map projections were added to Oce, bug reports showed that coastline plots in some projections were subject to anomalous lines that run horizontally on the plot.  A ad-hoc scheme was code to try to prevent this, but it does not always work.  Problems are compounded for filled coastlines.

I had thought this was a basic problem of all projection coding, until I happened to try using the ``proj4`` package instead of ``mapproj`` to carry out the projections.  The result is that the annoying lines went away.



# Test case

First, load libraries and extract the coastline.


{% highlight r linenos=table %}
library(oce)
{% endhighlight %}



{% highlight text %}
## Loading required package: gsw
{% endhighlight %}



{% highlight text %}
## Loading required package: testthat
{% endhighlight %}



{% highlight text %}
## Loading required package: sf
{% endhighlight %}



{% highlight text %}
## Linking to GEOS 3.8.0, GDAL 2.4.2, PROJ 6.2.1
{% endhighlight %}



{% highlight r linenos=table %}
library(proj4)
{% endhighlight %}



{% highlight text %}
## Error in library(proj4): there is no package called 'proj4'
{% endhighlight %}



{% highlight r linenos=table %}
library(mapproj)
{% endhighlight %}



{% highlight text %}
## Error in library(mapproj): there is no package called 'mapproj'
{% endhighlight %}



{% highlight r linenos=table %}
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]
{% endhighlight %}

Next, plot with existing (mapproj) projection.


{% highlight r linenos=table %}
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- mapproject(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
{% endhighlight %}



{% highlight text %}
## Error in mapproject(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]], : could not find function "mapproject"
{% endhighlight %}



{% highlight r linenos=table %}
plot(xy$x, xy$y, type='l', asp=1)
{% endhighlight %}



{% highlight text %}
## Error in plot(xy$x, xy$y, type = "l", asp = 1): object 'xy' not found
{% endhighlight %}

Finally, plot with proposed (proj4) projection.


{% highlight r linenos=table %}
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- project(cbind(lon,lat), "+proj=moll")
{% endhighlight %}



{% highlight text %}
## Error in project(cbind(lon, lat), "+proj=moll"): could not find function "project"
{% endhighlight %}



{% highlight r linenos=table %}
plot(xy[,1], xy[,2], type='l', asp=1)
{% endhighlight %}



{% highlight text %}
## Error in plot(xy[, 1], xy[, 2], type = "l", asp = 1): object 'xy' not found
{% endhighlight %}

# Conclusions

At least in this example, the ``proj4`` package produces better coastlines, somehow being clever enough to cut the polygons that cross the "edge" of the earth.

I will do some more tests to see if this is a fluke case, but if I think ``proj4`` is promising, I will see how to invent a scheme for handling the ``mapproj`` arguments called ``parameters`` and ``orientation`` with ``proj4``.  THis seems to be a bit tricky, at first glance, but let's keep the cart behind the horse for now.


# Resources
* Source code: [2014-04-10-oce-map-projection.R]({{ site.url }}/assets/2014-02-10-oce-map-projection.R)
