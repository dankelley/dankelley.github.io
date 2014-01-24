---
layout: post
title: Colourizing along a trajectory
tags: R
category: R
year: 2014
month: 1
day: 22
summary: A method is shown for colourizing a line (x,y) in terms of the value of a variable z=z(x,y).
description: Use ``segments()`` to colourize along a line.
---


# Introduction

In Oceanography it can be useful to use colour to display z values along an (x,y) trajectory.  For example, CTD data might be displayed in this way, with x being distance along track, y being depth, and z being temperature. This post shows how one might do this generally with fake data.

# Methods

The R code given below demonstrates this with fake data.  The core idea is to use ``segments()``, here with ``head()`` and ``tail()`` to chop up the trajectory.

{% highlight r %}
library(oce)
x <- 1:50
y <- x * 2/10 + x^2/10
z <- seq(0, 5, length.out = length(x))
zlim <- range(z)
npalette <- 10

palette <- oceColorsJet(npalette)
drawPalette(zlim = zlim, col = palette)
plot(x, y, type = "l")
segments(head(x, -1), head(y, -1),
  tail(x, -1), tail(y, -1),
  col = palette[findInterval(z, 
    seq(zlim[1], zlim[2], length.out = npalette))],
  lwd = 10)
points(x, y, pch = 20)
{% endhighlight %}


# Results

The graph shows that this works reasonably well.  The dots will probably not be useful in an actual application, and are used here just to indicate colourization in groups.

![figure]({{ site.url }}/assets/colorline.png)

The method works well, and is flexible in terms of colour schemes.

# Exercises

Find a way to blend colour between the points, perhaps by defining a euclidian distance in (x,y) space (which will of course require scaling if x and y have different units or ranges) and then using ``approx()``.
