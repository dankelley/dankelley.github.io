---
layout: post
title: butterworth filters
tags: time-series, R
category: R
year: 2014
month: 1
day: 15
summary: Butterworth filters with order exceeding 1 suffer an overshooting problem.
description: A series of examples with a tophat function illustrate the problem of overshoot in Butterworth filters.
---

*Abstract.* Demonstrate overshoot for butterworth filters in R.

**1. Introduction.**

Butterworth filters with order other than 1 have an overshoot phenomenon that can be problematic in some cases.  For example, if smoothing is used on an estimate of kinetic energy, overshoots might yield negative values that are nonphysical.  This post simply illustrates this with made-up data that the reader can experiment with.  

**2. Methods.**

First, create and plot some fake data, a top-hat function.  (Note the use of ``par`` to tighten the margins.)

{% highlight R %}
library(signal)
n <- 100
x <- 1:n
y <- ifelse(0.3*n < x & x < 0.7*n, 1, 0)
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(x, y, type='o', pch=20, ylim=c(-0.1, 1.1))
{% endhighlight %}

Next, decide on the cutoff frequency for a low-pass filter.  Setting ``W`` to 0.1 means a cutoff at 1/10-th of the Nyquist frequency.


{% highlight R %}
W <- 0.1
{% endhighlight %}

Finally, filter with orders 1, 2 and 3, and add coloured lines indicating the results

{% highlight R %}
b1 <- butter(1, W)
y1 <- filtfilt(b1, y)
points(x, y1, type='o', pch=20, col='red')

b2 <- butter(2, W)
y2 <- filtfilt(b2, y)
points(x, y2, type='o', pch=20, col='blue')

b3 <- butter(3, W)
y3 <- filtfilt(b3, y)
points(x, y3, type='o', pch=20, col='forestgreen')

legend("topright", lwd=2, col=c("black", "red", "blue", "green"),
        legend=c("Signal", "Order 1", "Order 2", "Order 3"))


{% endhighlight %}

**3. Results**


![graph]({{ site.url }}/assets/butter.png)

The graph illustrates; for the colour coding, see the code above.


**4. Conclusions**

Be careful in using butterworth filters of order 2 and higher.


