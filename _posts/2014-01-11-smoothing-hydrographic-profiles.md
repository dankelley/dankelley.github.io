---
layout: post
title: Smoothing hydrographic profiles
tags: [oceanography, time-series, R]
category: R
year: 2014
month: 01
day: 11
summary: Filtering and spline-based approaches to the smoothing of hydrographic profiles are outlined, and recommendations are made.
description: Filtering and spline-based approaches to the smoothing of hydrographic profiles are outlined, and recommendations are made.
---

# Introduction

Smoothing hydrographic profiles with conventional time-series methods is problematic for two reasons: (a) the data are commonly not equi-spaced in depth and (b) the data seldom lack trends in depth. The issues and their solutions are illustrated without much discussion here.

![daylength graph]({{ site.url }}/assets/smooth-hydrographic.png)

The first step in making the graph shown above is to load the ``oce`` library and create a function that measures daylength by finding sunrise and sunset times.  Note that ``uniroot()``, which is used to find times of zero solar altitude, needs lower and upper limits on ``t``, and these are calculated by looking back and then forward a half-day.  This works well for application to Halifax, but in other timezones other offsets would be needed.  Interested readers might want to devised a method based on the longitude, which can be transformed into a timezone.

# Methods

{% highlight r %}
library(oce)
library(signal)
data(ctd)
S <- ctd[['salinity']]
p <- ctd[['pressure']]
{% endhighlight %}

Create equispaced data for filtering to make sense.
{% highlight r %}
dp <- median(diff(p))
pp <- seq(min(p), max(p), dp)
S0 <- approx(p, S, pp)$y
{% endhighlight %}

Set critical frequency for the filter (as a ratio to Nyquist)
{% highlight r %}
W <- dp / 2
f1 <- butter(1, W)
f2 <- butter(2, W)
{% endhighlight %}

Set up for a three-panel plot.
{% highlight r %}
par(mfrow=c(1, 3))
{% endhighlight %}
 
Filter the raw profile, and plot as the left-hand panel.
{% highlight r %}
plotProfile(ctd, xtype="salinity", type='l')
S0f1 <- filtfilt(f1, S0)
S0f2 <- filtfilt(f2, S0)
lines(S0f1, pp, col='red')
lines(S0f2, pp, col='blue')
mtext("(a) ", side=3, adj=1, line=-5/4, cex=3/4)
{% endhighlight %}

Middle panel: filter the detrended profile.
{% highlight r %}
plotProfile(ctd, xtype="salinity", type='l')
Sd <- detrend(pp, S0)
S1f1 <- filtfilt(f1, Sd$Y) + Sd$a + Sd$b * pp
S1f2 <- filtfilt(f2, Sd$Y) + Sd$a + Sd$b * pp
lines(S1f1, pp, col='red')
lines(S1f2, pp, col='blue')
mtext("(b) ", side=3, adj=1, line=-5/4, cex=3/4)
{% endhighlight %}

Right panel: show the results of a smoothing spline.
{% highlight r %}
spline <- smooth.spline(pp, S0, df=3/W)
S2 <- predict(spline)$y
plotProfile(ctd, xtype="salinity", type='l')
lines(S2, pp, col='red')
mtext("(c) ", side=3, adj=1, line=-5/4, cex=3/4)
{% endhighlight %}

# Results

Filtering a non-detrended profile is a bad idea because there is almost always a zero-offset problem, and also most properties vary dramatically with depth, so detrending is required as well as zero offsetting.

Smoothing splines provide an attractive alternative to filtering, especially in the not-uncommon cases in which derivative are required.  A downside is that there is no simple way to describe the spline to those who are not familiar with them.  For example, spline the smoothness is here controlled by setting the ``df`` argument; there is no way to specify a half-power frequency as there is for a filter.
