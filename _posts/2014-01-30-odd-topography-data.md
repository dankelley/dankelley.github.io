---
layout: post
title: odd topography data
tags: [oceanography, R]
category: R
year: 2014
month: 01
day: 30
summary: The Oce dataset named ``topoWorld`` has some intriguing patterns in the north Pacific (and elsewhere).  I think they are just fault lines, but until I plotted them this way I never realized how much they are like Heaviside functions, with an offset on either side of the fault.
description: The Oce dataset topoWorld has some weird patterns.
---

I enjoyed the [blog posting](http://menugget.blogspot.ca/2014/01/importing-bathymetry-and-coastline-data.html), which I ran across on R-bloggers, and so I decided to try that author's GMT colourscheme.  This revealed some intriguing patterns in the Oce dataset named ``topoWorld``.  The following code produces a graph


{% highlight r %}
## test GMT colours as suggested by
## http://menugget.blogspot.ca/2014/01/importing-bathymetry-and-coastline-data.html

# 1. colours as suggested on "menuggest" blog
ocean.pal <- colorRampPalette(c("#000000","#000209","#000413","#00061E",
                                "#000728","#000932","#002650","#00426E",
                                "#005E8C","#007AAA","#0096C8","#22A9C2",
                                "#45BCBB","#67CFB5","#8AE2AE","#ACF6A8",
                                "#BCF8B9","#CBF9CA","#DBFBDC","#EBFDED"))
land.pal <- colorRampPalette(c("#336600","#F3CA89","#D9A627","#A49019",
                               "#9F7B0D","#996600","#B27676","#C2B0B0",
                               "#E5E5E5","#FFFFFF"))

# 2. test in oce
if (!interactive()) png("gmt.png", width=8, height=4, unit="in", res=150, pointsize=7)
library(oce)
data(topoWorld)
waterBreaks <- seq(-10000, -100, by=50)
landBreaks <- seq(100, 10000, by=50)
imagep(topoWorld, asp=1,
       breaks=c(waterBreaks, 0, landBreaks),
       col=c(ocean.pal(length(waterBreaks)), land.pal(length(landBreaks))))
if (!interactive()) dev.off()
{% endhighlight %}

I have attached below the results, with some hand-drawn arrows that show some of the fault-line features in the North Pacific.  It is amazing how a simple change of a colorscale can sometimes reveal something to the eye.

[![graph]({{ site.url }}/assets/odd-topography-data-thumbnail.png)]({{ site.url }}/assets/odd-topography-data.png)



