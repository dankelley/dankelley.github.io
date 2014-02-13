---
layout: post
title: Valentines-day full moon
tags: [R, astronomy, romance]
category: R
year: 2014
month: 2
day: 13
summary: There will be a full moon on Valentine's Day this year.  How common is that?
description: There will be a full moon on Valentine's Day this year.  How common is that?
---

# Introduction

A wise person told me that it will be a full moon on the upcoming Valentine's Day, but that it will be a long time until another one.  I decided to check this with astronomical calculation.

# Procedure

The Oce package has a function called ``moonAngle()`` that returns, among other things, the illuminated fraction of the moon visible at any given time.  This can be used to test for a full moon on Valentine's day.

The first step is to construct the times of Valentine's days, starting with the one this year.


{% highlight r linenos=table %}
times <- seq(as.POSIXct("2014-02-14"), length.out = 50, by = "year")
library(oce)
{% endhighlight %}



{% highlight text %}
## Loading required package: methods Loading required package: mapproj
## Loading required package: maps
{% endhighlight %}



{% highlight r linenos=table %}
fraction <- moonAngle(times, lon = -63, lat = 43)$illuminatedFraction
full <- fraction > 0.99
plot(times, fraction, col = ifelse(full, "red", "blue"), pch = 16)
{% endhighlight %}

![center]({{ site.url }}/assets/2014-02-13-valentines.png) 

Here, red has been used to indicate years with full moon on Valentine's Day, and sad blue otherwise.

# Results

Yes, it will be a long time until the next full moon on Valentine's Day:

{% highlight r linenos=table %}
times[full]
{% endhighlight %}



{% highlight text %}
## [1] "2014-02-14 AST" "2033-02-14 AST" "2052-02-14 AST"
{% endhighlight %}


# Conclusions

Buy candy now.

* Source code: [2014-04-13-valentine-moon.R]({{ site.url }}/assets/2014-02-13-valentine-moon.R)