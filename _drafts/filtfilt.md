---
layout: post
title: Improved filtfilt() for R
tags: [R, time-series]
category: R
year: 2014
month: 2
day: 18
summary: A better filtfilt() for R.
description: A better filtfilt() for R.
---
Octave does as follows, which looks pretty simple.  Since Octave is GPL, it seems perfectly reasonable to build R code based on this.

# Octave implementation

{% highlight matlab %}
## Compute a the initial state taking inspiration from
## Likhterov & Kopeika, 2003. "Hardware-efficient technique for
##     minimizing startup transients in Direct Form II digital filters"
kdc = sum(b) / sum(a);
if (abs(kdc) < inf) # neither NaN nor +/- Inf
  si = fliplr(cumsum(fliplr(b - kdc * a)));
else
  si = zeros(size(a)); # fall back to zero initialization
endif
si(1) = [];

for (c = 1:size(x,2)) # filter all columns, one by one
  v = [2*x(1,c)-x((lrefl+1):-1:2,c); x(:,c);
       2*x(end,c)-x((end-1):-1:end-lrefl,c)]; # a column vector

  ## Do forward and reverse filtering
  v = filter(b,a,v,si*v(1));                   # forward filter
  v = flipud(filter(b,a,flipud(v),si*v(end))); # reverse filter
  y(:,c) = v((lrefl+1):(lx+lrefl));
endfor
{% endhighlight %}

## R implementation


{% highlight r linenos=table %}
x <- rnorm(100) + sin((1:100) * 2 * pi/20)
ab <- signal::butter(2, 0.1)
a <- ab$a
b <- ab$b
kdc <- sum(b)/sum(a)
if (!is.nan(kdc)) {
    si <- rev(cumsum(rev(b - kdc * a)))
} else {
    si <- rep(0, length(a))
}
lx <- length(x)
si <- si[-1]
nx <- length(x)
n <- max(length(a), length(b))
lrefl <- 3 * (n - 1)
v <- cbind(c(2 * x[1] - x[seq(lrefl + 1, 2, -1)]), x, c(2 * x[nx] - x[seq(nx - 
    1, nx - lrefl, -1)]))
{% endhighlight %}



{% highlight text %}
## Warning: number of rows of result is not a multiple of vector length (arg
## 1)
{% endhighlight %}



{% highlight r linenos=table %}
v <- signal::filter(b, a, v, si * v[1])  # forward filter
v <- rev(signal::filter(b, a, rev(v), si * v[nx]))  # reverse filter
y <- v[seq.int(lrefl + 1, lx + lrefl)]
t <- seq_along(x)
plot(t, x, type = "l")
lines(t, y, col = "red")
{% endhighlight %}

![center]({{ site.url }}/assets/figs/filtfilt/unnamed-chunk-1.png) 

{% highlight r linenos=table %}
# v = [2*x(1)-x((lrefl+1):-1:2); x(:); 2*x(end)-x((end-1):-1:end-lrefl)]; #
# a column vector ## Do forward and reverse filtering v =
# filter(b,a,v,si*v(1)); # forward filter v =
# flipud(filter(b,a,flipud(v),si*v(end))); # reverse filter y(:) =
# v((lrefl+1):(lx+lrefl));
{% endhighlight %}


