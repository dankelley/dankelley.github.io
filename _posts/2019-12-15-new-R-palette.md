---
layout: post
title: New R Colour Palette
tags: [R, graphics]
category: R
year: 2019
month: 12
day: 15
summary: R version 4 will have a new default palette, and it solves the problem of terrible default colours. A simple demonstration is given here.
---


# Introduction

It can be very handy to use numeric colours in R, to distinguish graphical
features.  Commonly, I write something like


{% highlight r linenos=table %}
# Not run here, so no graph
plot(x, y1)
points(x, y2, col=2)
{% endhighlight %}
which gives black circles for `y1` and a red one for `y2`.  That works
reasonably well for `col` from 1 to 6, but `col=7` is a yellow that it very
difficult to see on a white background.  Also, some of the colours are more
glaring than others, which leads to an ugly unevenness in the results, and
possibly to confusion, since some viewers might think that the glaring colours
are used to indicate importance (akin to glaring highlighter pen).

The upcoming R-4 (4.0 is available now as a pre-release, but it is still in
active development and therefore **not recommended** for routine work) will
solve this. The default colours will be more visible, more balanced, and also
better for those with certain vision challenges.

In R-4.0, you can also use the old palettes, so there is no worry about
compatibility with old plots.  A single function call,

{% highlight r linenos=table %}
palette("R3")
{% endhighlight %}
will switch to the old scheme, so scripts that need compatibility need only
insert a line like this at the top, and the old colours will be used.



Here's a simple example that shows the new scheme

{% highlight r linenos=table %}
x <- 1:8
palette("R4") # not needed unless R3 was previously selected
plot(x, rep(1, 8), ylim=c(1,2), pch=20, col=1:8)
palette("R3") # for the old scheme
points(x, 1+rep(1, 8), pch=20, col=1:8)
{% endhighlight %}

![center](http://dankelley.github.io/figs/2019-12-15-new-R-palette/unnamed-chunk-4-1.png)

Many viewers may find the new palette (lower dots) preferable to the old palette
(upper dots).  For me, the main gain is with the yellow, which is clearly
visible in this new form.

It is worth noting that the new colours are similar enough to the old ones that
text referring to the diagram may still be valid (``yellow'' is still
``yellow'').

Reference [1] explains more about the new palettes in R-4, and it is worth reading,
to learn about other new palettes that are coming, and about efforts to make
the new results more visible for those with difficulties with colour vision.

# References and resources

1. RStudio blog item on the new colour scheme:
[https://developer.r-project.org/Blog/public/2019/11/21/a-new-palette-for-r/index.html](https://developer.r-project.org/Blog/public/2019/11/21/a-new-palette-for-r/index.html)

2. Jekyll source code for this blog entry: [2019-12-15-new-R-palette.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2019-12-15-new-R-palette.Rmd)

