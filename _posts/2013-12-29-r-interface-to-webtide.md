---
layout: post
title: R interface to WebTide
tags: [oceanography, R]
category: R
year: 2013
month: 12
day: 29
summary: R interface to WebTide
description: The oce package in the R language provides a convenient interface to the WebTide tidal-prediction system.
---

A previous posting explained how to install WebTide on an OSX machine. This one shows how to hook up to an installed WebTide database, so that R code can get tidal predictions.

The following code in the R language will produce a graph in which the top panel mimics the tidal-elevation graph produced by WebTide itself (see previous blog posting for comparison).

{% highlight r %}
library(oce)
tStart <- as.POSIXct("2013-12-29 14:21:00", tz="UTC")
tEnd <- as.POSIXct("2014-01-13 15:21:00", tz="UTC")
time<-seq(tStart, tEnd, by=15, units="minutes")
prediction <- webtide("predict", lon=-65.06747, lat=45.36544, time=time)
{% endhighlight %}

[![graph]({{ site.url }}/assets/webtide-thumbnail1.png)]({{ site.url }}/assets/webtide1.png)

One of the advantages of accessing the tidal prediction from within oce is to make it easier to undertake further analysis, e.g. a node nearer Halifax has a mixed tide, with the following illustrating in terms of velocity and a so-called progressive vector.

{% highlight r %}
p <- webtide("predict", node=14569)
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(p$u, p$v, asp=1, type="o")
dt <- diff(as.numeric(p$time[1:2]))
x <- dt * cumsum(p$u)
y <- dt * cumsum(p$v)
plot(x, y, asp=1, type="o")
{% endhighlight %}


[![graph]({{ site.url }}/assets/webtide-thumbnail2.png)]({{ site.url }}/assets/webtide2.png)

