---
layout: post
title: Why I use base graphics instead of ggplot2
tags: [oce, map, R]
category: R
year: 2020
month: 9
day: 30
summary: ggplot can be slow ... 1970s slow.
---

The following comparison explains my preference for base graphics over
ggplot[2] graphics ...

**Base graphics**

With base graphics, running

{% highlight r linenos=table %}
d <- data.frame(x=rnorm(1e8))
system.time(hist(x))
{% endhighlight %}
produces
```
     user  system elapsed
    0.044   0.004   0.052
```
whereas with ggplot

{% highlight r linenos=table %}
library(ggplot2)
system.time({p<-ggplot(d) + aes(x=x) + geom_histogram();print(p)})
{% endhighlight %}
we get
```
  `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
     user  system elapsed
   43.877  13.766  60.200
```

In this case, the base-graphics result is completed while my finger is still
rising from the 'return' key, while with ggplot, I have to wait a full minute.

I prefer using tools that don't make my brand-new machine act like something
from the 1980s.

# References and resources

1. Jekyll source code for this blog entry: [2020-09-30-dislike-ggplot.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-09-30-dislike-ggplot.Rmd)

