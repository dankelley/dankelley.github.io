---
layout: post
title: oce map projection
tags: [mapping, oce, oceanography, mapping, R]
category: R
year: 2014
month: 2
day: 10
summary: The Oce package presently handles map projections by using the ``mapproj`` package, but an alternative is the ``proj4`` package.  This post compares the two, focussing on the vexing problem of islands crossing the edge of the earth, which causes spurious lines on some Oce maps at present.
description: The Oce package presently handles map projections by using the ``mapproj`` package, but an alternative is the ``proj4`` package.  This post compares the two, focussing on the vexing problem of islands crossing the edge of the earth, which causes spurious lines on some Oce maps at present.
---

# Introduction

Soon after map projections were added to Oce, bug reports showed that coastline plots in some projections were subject to anomalous lines that run horizontally on the plot.  A ad-hoc scheme was code to try to prevent this, but it does not always work.  Problems are compounded for filled coastlines.

I had thought this was a basic problem of all projection coding, until I happened to try using the ``projr`` package instead of ``mapproj`` to carry out the projections.  The result is that the annoying lines went away.

I am still thinking about whether to make a transition in Oce.  The ``proj4`` syntax is too tricky for simple inclusion in Oce, and tricky, and users (including me) are accustomed to the existing syntax, so it would be necessary to convert the internal linkage in a somewhat nontrivial way.  Nevertheless, the point of the present post is simply to illustrate that the problem is solved, at least in one test case.


# Test case

First, load libraries and extract the coastline.


{% highlight r linenos=table %}
library(oce)
{% endhighlight %}



{% highlight text %}
## Loading required package: methods
## Loading required package: mapproj
## Loading required package: maps
{% endhighlight %}



{% highlight r linenos=table %}
library(proj4)
{% endhighlight %}



{% highlight text %}
## Error: there is no package called 'proj4'
{% endhighlight %}



{% highlight r linenos=table %}
library(mapproj)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]
{% endhighlight %}

Next, plot with existing (mapproj) projection.


{% highlight r linenos=table %}
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- mapproject(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
plot(xy$x, xy$y, type='l', asp=1)
{% endhighlight %}

![center](http://dankelley.github.io/figs/2014-02-10-oce-map-projection/projection-existing.png) 

Finally, plot with proposed (proj4) projection.


{% highlight r linenos=table %}
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- project(cbind(lon,lat), "+proj=moll")
{% endhighlight %}



{% highlight text %}
## Error: could not find function "project"
{% endhighlight %}



{% highlight r linenos=table %}
plot(xy[,1], xy[,2], type='l', asp=1)
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error in xy[, 1] : incorrect number of dimensions
{% endhighlight %}
# Conclusions

At least in this example, the ``proj4`` package produces better coastlines, somehow being clever enough to cut the polygons that cross the "edge" of the earth.

I will do some more tests to see if this is a fluke case, but if I think ``proj4`` is promising, I will see how to invent a scheme for handling the ``mapproj`` arguments called ``parameters`` and ``orientation`` with ``proj4``.  THis seems to be a bit tricky, at first glance, but let's keep the cart behind the horse for now.


# Resources
* Source code: [2014-04-10-oce-map-projection.R]({{ site.url }}/assets/2014-02-10-oce-map-projection.R)
