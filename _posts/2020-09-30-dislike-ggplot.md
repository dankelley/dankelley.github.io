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

Running

{% highlight r linenos=table %}
library(ggplot2)
d <- data.frame(x=rnorm(1e8))
system.time(hist(x))
{% endhighlight %}
produces
```
     user  system elapsed
    0.044   0.004   0.052
```

**ggplot2 graphics**


{% highlight text %}
## Error in ggplot(d): could not find function "ggplot"
{% endhighlight %}



{% highlight text %}
## Timing stopped at: 0 0 0.002
{% endhighlight %}
produces
```
  `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
     user  system elapsed
   43.877  13.766  60.200
```


# References and resources

1. Jekyll source code for this blog entry: [2020-09-30-dislike-ggplot.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-09-30-dislike-ggplot.Rmd)


