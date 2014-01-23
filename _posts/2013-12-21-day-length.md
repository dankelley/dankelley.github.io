---
layout: post
title: Day length calculation
tags: [astronomy, R]
category: R
year: 2013
month: 12
day: 21
summary: Day length is calculated for a month
description: Day length is calculated for a month
---

The winter solstice has been on many minds lately.  The days are about to start getting longer ... but just how fast will they do that?

This post provides R that calculates and graphs day length and its variation, using ``uniroot()`` to find sunrises and sunsets as indicated by solar altitude that is calculated with ``sunAngle()`` in the oce package.

The day of the solstice is indicated with vertical lines. All times are in UTC, which is the conventional system for scientific work and the one required by ``sunAngle()``.

**Exercises.** (a) Alter line 2 for another location, or line 13 for another month. (b) Remove the need for t0 to be during local daylight hours, perhaps by using the longitude, or by checking sun altitude trends as the horizon is crossed.

![daylength graph]({{ site.url }}/assets/daylength.png)

{% highlight r %}
library(oce)
daylength <- function(t, lon=-63.60, lat=44.65)
{
    t <- as.numeric(t)
    alt <- function(t)
        sunAngle(t, longitude=lon, latitude=lat)$altitude
    rise <- uniroot(alt, lower=t-86400/2, upper=t)$root
    set <- uniroot(alt, lower=t, upper=t+86400/2)$root
    set - rise
}
## December 2013
solstice <- as.POSIXct("2013-12-21", tz="UTC")
t0 <- as.POSIXct("2013-12-01 12:00:00", tz="UTC")
t <- seq.POSIXt(t0, by="1 day", length.out=1*31)
dayLength <- unlist(lapply(t, daylength))

## Two panels, with tightened margins
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))

## Top panel: day length
plot(t, dayLength/3600, type='o', pch=20,
     xlab="", ylab="Day length (hours)")
grid()
abline(v=solstice+c(0, 86400))

## Bottom panel: daily change in day length
plot(t[-1], diff(dayLength), type='o', pch=20,
     xlab="Day in 2013", ylab="Seconds gained per day")
grid()
abline(v=solstice+c(0, 86400))
{% endhighlight %}



