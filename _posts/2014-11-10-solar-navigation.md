---
layout: post
title: Solar navigation
tags: [R, oce, astronomy]
category: R
year: 2014
month: 11
day: 10
summary: Geographical location is inferred from sunrise and sunset times.
latex: true
---

# Introduction

Solar altitude is a function of time, longitude and latitude, and so it may be
possible to infer location based on measurements of solar altitude over time.

I have explored this idea for a school-based project I call "SkyView" [1]
involving light sensors and Arduino microcontrollers, and readers could well
imagine a range of other applications.

I will illustrate the method and its accuracy based on sunrise and sunset times
on Remembrance Day in Halifax, Nova Scotia, a city where respect for the fallen
is very strong.

# Methods

According to various websites [e.g. 2], the Halifax on Remembrance Day of 2014
is at 7:06AM (11:06 UTC), and sunset at 4:51PM (20:51 UTC).

Rather than devising an inverse formula to infer location from time and solar
altitude, the R function ``optim`` may be used to find the longitude and
latitude that minimize angle the sun makes to the horizon.  That angle is given
by the ``altitude`` component of the list returned by ``oce::solarAngle()``.

The first step is to define a function that returns the absolute value of the
solar angle, which of course is a minimum at sunrise and sunset.


{% highlight r linenos=table %}
library(oce)
misfit <- function(lonlat)
{
    riseAlt <- sunAngle(rise, longitude=lonlat[1], latitude=lonlat[2], useRefraction=TRUE)$altitude
    setAlt <- sunAngle(set, longitude=lonlat[1], latitude=lonlat[2], useRefraction=TRUE)$altitude
    0.5 * (abs(riseAlt) + abs(setAlt))
}
{% endhighlight %}
Here, ``useRefraction`` is set to account for the bending of the sunlight near
the horizon, which perturbs the observed sunrise and sunset times.  Note that
the sunrise and sunset times (``rise`` and ``set``) must be defined in order
for ``misfit`` to work.  Use ``help(sunAngle)`` for more about how this
function works.

The goal is to use ``optim`` to find values of longitude and latitude that
yield an optimal match to specified sunrise and sunset times.  This function
needs an initial value, or guess, and for that we pick 50W and 50N.


{% highlight r linenos=table %}
start <- c(-50, 50) # set this vaguely near the expected location
rise <- as.POSIXct("2014-11-11 11:06:00", tz="UTC")
set <- as.POSIXct("2014-11-11 20:51:00", tz="UTC")
bestfit <- optim(start, misfit)
{% endhighlight %}
An examination of the fit

{% highlight r linenos=table %}
str(bestfit)
{% endhighlight %}



{% highlight text %}
## List of 5
##  $ par        : num [1:2] -63.7 44.5
##  $ value      : num 0.000541
##  $ counts     : Named int [1:2] 203 NA
##   ..- attr(*, "names")= chr [1:2] "function" "gradient"
##  $ convergence: int 0
##  $ message    : NULL
{% endhighlight %}
reveals the function value to be very low, indicating a sun just on the
horizon.  The optimal values for longitude and latitude are stored in ``par``.
See ``help("optim")`` to learn more about the return value.

It can be helpful to show the results on a map.  To explore the dependence on
sunrise and sunset times, random values can be added to those times and
resultant positions plotted.  In the present example, the times are reported to
the nearest minute, so random values with standard deviation of 30 seconds will
be used.


{% highlight r linenos=table %}
data(coastlineWorldFine, package="ocedata")
plot(coastlineWorldFine, clon=-64, clat=45, span=500)
grid()

n <- 25                                # use 25 perturbations
rises <- rise + rnorm(n, sd=30)
sets <- set + rnorm(n, sd=30)
set.seed(20141111) # this lets readers reproduce this exactly
for (i in 1:n) {
    rise <- rises[i]
    set <- sets[i]
    fit <- optim(start, misfit)
    points(fit$par[1], fit$par[2], pch=21, bg="pink", cex=1.4)
}
# Show the unperturbed fit
points(bestfit$par[1], bestfit$par[2], pch=21, cex=2, bg="red")
# Show the actual location of Halifax
points(-63.571, 44.649, pch=22, cex=2, bg='yellow')
# A legend summarizes all this work
legend("bottomright", bg="white", 
       pch=c(21, 21, 22), pt.bg=c("red", "pink", "yellow"),
       legend=c("Best", "Range", "True"))
{% endhighlight %}

![center](http://dankelley.github.io/figs/2014-11-10-solar-navigation/solar-navigation.png) 

# Results

The diagram indicates that reported sunrise and sunset times on Rembrance Day,
2014, are sufficient to locate Halifax to within about 10km.  (Note that 1
degree of latitude is 111km.)

Adjusting sunrise and sunset times by half a minute (corresponding to the
rounding interval in public forecasts of sunrise and sunset times) yields
approximately 25km uncertainty in geographical position.

# Discussion and conclusions

Since it is easy to observe sunrise and sunset times to a precision of 1
minute, the method outlined here might be the basis for school projects that
combine computer work with field work, with proper instruction on observing the
sun.

Plastic sextants are available for a few tens of dollars, and this opens up
many more possibilities for exploring solar (and lunar) navigation using the
Oce package to do the celestial calculations.

Further discussion of matters relating to solar angles can be found in my
upcoming book [3].  For example, the method can be used to test a phrase about
an eclipse in a famous Carly Simon song.

# Exercises

1. Alter the initial guess to see what effect it has.

2. Evaluate the relationship between positional uncertainty and temporal
   uncertainty.

3. Try similar exercises at various times of the year, and map the uncertainty
   as a function of season.

4. Buy a cheap sextant, and try extending the analysis to times other than
   sunrise and sunset.

# References and resources

1. A website for the SkyView project is
[http://emit.phys.ocean.dal.ca/~kelley/skyview](http://emit.phys.ocean.dal.ca/~kelley/skyview/).
   
2. A website providing the requisite sunrise and sunset times is
[http://www.timeanddate.com/astronomy/canada/halifax](http://www.timeanddate.com/astronomy/canada/halifax).

3. Dan Kelley, in preparation.  Oceanographic Analysis with R. Springer-Verlag.

4. R source code used here: [2014-11-10-solar-navigation.R]({{ site.url }}/assets/2014-11-10-solar-navigation.R).

5. Jekyll source code for this blog entry: [2014-11-10-solar-navigation.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2014-11-10-solar-navigation.Rmd)
