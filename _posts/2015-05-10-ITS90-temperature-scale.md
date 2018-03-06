---
layout: post
title: ITS-90 temperature scale
tags: [oce,R]
category: R
year: 2015
month: 5
day: 10
summary: Oce will soon be getting functions to convert between the IPTS-68 and ITS-90 temperature scales. This posting investigates how much difference this might make in practical work.
---

# Introduction

Recently, oce has been gaining flexibility in terms of conductivities stored in
data files. This is necessitated by the fact that RBR files store conductivity
in mS/cm, whereas calculations for seawater properties use the unitless
conductivity ratio.  With the CTD code under examination for this work, it
might make sense to also handle temperatures stored in files. The two choices
for that seem to be the IPTS-68 and ITS-90 conventions [1,2], and a natural
question is whether using ITS-90 temperatures in formula designed for IPTS-68
will yield errors of practical significance.

# Functions
The following are functions for the conversion, as suggested in [1].

{% highlight r linenos=table %}
T90toT68 <- function(T90) 1.00024 * T90
T68toT90 <- function(T68) T68 / 1.00024
{% endhighlight %}

# Test of inferred density

First, define some base quantities

{% highlight r linenos=table %}
library(oce)
S <- 35
T90 <- 20
p <- 100
{% endhighlight %}
and then do some calculations, e.g.

{% highlight r linenos=table %}
T90toT68(T90)
{% endhighlight %}



{% highlight text %}
## [1] 20.0048
{% endhighlight %}
This temperature difference, 0.0048, is several
times larger than the 
SBE911plus initial accuracy of 0.001 C as stated at [3]. (It is about double the stated
stability over a year of drift.)

Another test is of density:


{% highlight r linenos=table %}
swRho(S, T90, p) # incorrect
{% endhighlight %}



{% highlight text %}
## Error in swRho(S, T90, p): must supply longitude
{% endhighlight %}



{% highlight r linenos=table %}
swRho(S, T90toT68(T90), p)
{% endhighlight %}



{% highlight text %}
## Error in swRho(S, T90toT68(T90), p): must supply longitude
{% endhighlight %}

Finally, the following tests the amount that salinity would need to be adjusted to 
compensate (in density terms) for a temperature misapplication.

{% highlight r linenos=table %}
rho0 <- swRho(S, T90toT68(T90), p)
{% endhighlight %}



{% highlight text %}
## Error in swRho(S, T90toT68(T90), p): must supply longitude
{% endhighlight %}



{% highlight r linenos=table %}
uniroot(function(S) swRho(S, T90, p) - rho0, lower=34, upper=36)$root
{% endhighlight %}



{% highlight text %}
## Error in swRho(S, T90, p): must supply longitude
{% endhighlight %}

