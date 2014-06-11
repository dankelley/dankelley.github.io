---
layout: post
title: slumping model
tags: [R, sedimentation]
category: R
year: 2014
month: 6
day: 08
summary: A simple model of sedimentation with slumping.
description: A simple model of sedimentation with slumping.
---

# Introduction

I got interested in layered sedimentation from viewing [a video](http://www.simonsfoundation.org/multimedia/mathematical-impressions-multimedia/mathematical-impressions-spontaneous-stratification/) and decided it would be interesting to code this into R.  More on that in due course, but my first step was to code a syatem with one sediment "type".

# Procedure

The following code drops sediment particles at x=1, and lets them roll downhill
until they reach the bottom or a ledge.  It draws numbers at the sedimented
particles' final positions.  Since the numbers start at 1, the values are like
inverse ages.


{% highlight r linenos=table %}
m <- 50  # number of particles
n <- 10  # grid width
debug <- FALSE  # set TRUE to trace steps
info <- function(...) if (debug) cat(...)
pch <- 20
cex <- 4/log2(n)
type <- "t"
set.seed(1)
slump <- function(X, Z) {
    info("slump(", X, ",", Z, ")\n", sep = "")
    if (Z == 1) 
        return(list(x = X, z = Z))
    ## Particles roll down-slope until they hit the bottom or a ledge with at
    ## least one particle to the right.
    XX <- X
    ZZ <- Z
    ## Small particles stop rolling if 2 points below move down and to right
    while (0 == S[XX + 1, ZZ - 1]) {
        info("  XX:", XX, " ZZ:", ZZ, "\n")
        XX <- XX + 1
        ZZ <- which(0 == S[XX, ])[1]
        if (ZZ == 1) 
            break
        if (XX == n) 
            break
    }
    return(list(x = XX, z = ZZ))
}

S <- matrix(0, nrow = n, ncol = n)  # 'S' means 'space'
par(mar = c(2, 2, 1/2, 1/2), mgp = c(2, 0.7, 0))
plot(1:n, 1:n, type = "n", xlab = "", ylab = "")
xDrop <- 1  # location of drop; everything goes here or to right
for (i in 1:m) {
    # 'p' means partcle
    while (is.na(zDrop <- which(0 == S[xDrop, ])[1])) {
        xDrop <- xDrop + 1
        if (xDrop == n) 
            break
    }
    if (is.na(zDrop)) 
        break
    info("particle:", i, " ")
    p <- slump(xDrop, zDrop)
    if (p$x < (n + 1)) {
        S[p$x, p$z] <- 1
        if (type == "p") {
            points(p$x, p$z, col = "gray", pch = pch, cex = cex)
        } else {
            text(p$x, p$z, i, col = "gray")
        }
    } else {
        str(p)
    }
}
{% endhighlight %}

![center](http://dankelley.github.io/figs/2014-06-08-slumping-model/slumping-model.png) 



# Discussion and conclusions

Reading the numbers on the graph as inverse age, one can see an interesting age
structure through the sediments.  

1. Viewed along diagonals (i.e. along a given depth below the sediment
   surface), age increase by 1 time unit with every lateral step away from the
   source.  

2. Viewed as a vertical slice (i.e. a core), the time step per unit depth
   depends on distance from sediment source.

3. Viewed along Z levels (i.e. what might be a surface trace if something
   sliced the sediment pile horizontally), the time step per unit X distance
   depends on Z.

I wonder if these patterns (or the code) are of interest to geologists?

# Resources

* Source code: [2014-06-08-slumping-model.R]({{ site.url }}/assets/2014-06-08-slumping-model.R)
