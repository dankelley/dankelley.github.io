---
layout: post
title: hodograph
tags: [R, plotting]
category: R
year: 2014
month: 2
day: 8
summary: simple hodograph function
description: Show the use of a simple hodograph function, perhaps destined for the Oce package.
---

# Introduction

The polar graph known as a hodograph can be useful for vector plots, and also for showing varition within nearly-cyclical time series data.  The Oce R package should have a function to create hodographs, but as usual my first step is to start by writing isolated code, testing to find the right match between the function and real-world needs.

The code chunk given below is such a test, with the build-in dataset named ``co2``, which is a time-series starting in 1959.  The hodograph is for the variation of CO2 from its value in 1959, so the data start at zero radius.  Climatologists will why this makes sense, and climate-change deniars will think it's part of a hoax.

I will leave documentation of the function for a later time, conscious of the fact that the argument list and the aesthtics of the output are likely to change with use.


# Methods


{% highlight r linenos=table %}
hodograph <- function(x, y, t, rings, tcut = c("daily", "yearly"), ...) {
    tcut <- match.arg(tcut)
    if (missing(t)) {
        stop("x-y method not coded yet\n")
    } else {
        if (!missing(y)) {
            stop("cannot give y if t is given\n")
        }
        if (tcut == "yearly") {
            ## x=x(t)
            t <- as.POSIXlt(t)
            start <- ISOdatetime(1900 + as.POSIXlt(t[1])$year, 1, 1, 0, 0, 0, 
                tz = attr(t, "tzone"))
            day <- as.numeric(julian(t, origin = start))
            xx <- x * cos(day/365 * 2 * pi)
            yy <- x * sin(day/365 * 2 * pi)
            ## axes
            if (!missing(rings)) 
                rings <- pretty(sqrt(xx^2 + yy^2))
            rscale <- 1.04 * max(rings)
            theta <- seq(0, 2 * pi, length.out = 200)
            plot(xx, yy, asp = 1, xlim = rscale * c(-1.1, 1.1), ylim = rscale * 
                c(-1.1, 1.1), type = "n", xlab = "", ylab = "", axes = FALSE)
            ## month lines
            month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", 
                "Sep", "Oct", "Nov", "Dec")
            for (m in 1:12) {
                phi <- 2 * pi * (m - 1)/12
                lines(rscale * cos(phi) * c(-1.1, 1.1), rscale * sin(phi) * 
                  c(-1.1, 1.1), col = "gray")
                phi <- 2 * pi * (0.5/12 + (m - 1)/12)
                text(1.1 * rscale * cos(phi), 1.1 * rscale * sin(phi), month[m])
            }
            for (r in rings) {
                gx <- r * cos(theta)
                gy <- r * sin(theta)
                lines(gx, gy, col = "gray")
                text(gx[1], 0, format(R))
            }
            points(xx, yy, ...)
        } else {
            stop("only tcut=\"yearly\" works at this time\n")
        }
    }
}
data(co2)
year <- as.numeric(time(co2))
t0 <- as.POSIXlt("1959-01-01 00:00:00", tz = "UTC")
t <- t0 + (year - year[1]) * 365 * 86400
par(mar = rep(1, 4))
hodograph(x = co2 - co2[1], t = t, tcut = "yearly", type = "l")
{% endhighlight %}



{% highlight text %}
## Error: 'rings' is missing
{% endhighlight %}


# Results

The plot is surprisingly informative.  I've looked at the ``co2`` data before, without really noticing the interannual variation, which is clearly seen as variation in the spacing of the spiraling data trace.  For comparison, considere a conventional time-series plot.


{% highlight r linenos=table %}
plot(co2)
{% endhighlight %}

![center]({{ site.url }}/assets/2014-02-08-timeseries.png) 


# Conclusions

Even in this draft form, the function may be useful.  Among the aesthetic weaknesses one might list: (a) the month separators are approximate, being a year divided into 12 parts; (b) the ring labels are over-written by the axes.

# Resources

* Source code: [2014-04-08-hodograph.R]({{ site.url }}/assets/2014-02-08-hodograph.R)
