---
layout: post
title: updating oce::magneticField()
tags: [oce, R]
category: R
year: 2020
month: 3
day: 3
summary: This note sketches the procedure used to update `magneticField()` in the `oce` package, to use the updated formulae released by the International Association of Geomagnetism and Aeronomy (IAGA) in late 2019.
---

# Introduction

The `magneticField()` function in the `oce` packages uses formulae for the
International Geomagnetic Reference Field (IGRF) provided by the International
Association of Geomagnetism and Aeronomy (IAGA, Ref. 1) to compute the earth's
magnetic field.

The formulae are provided in a standalone Fortran program (Ref. 2) and this
must manipulated to get it into a form that can be used by `oce`.  This posting
outlines the procedure for that manipulation. It was written as I was updating
from IAGA version 12 to version 13, but the similarity of the Fortran code in
those two versions may suggest that these notes may be helpful for a future
update.

# Updating procedure

The steps are as follows.  But, before proceeding, the reader is cautioned that
these instructions are for the *developers*, or for others who are comfortable
programming in Fortran and are aware of its evolution over the past 60 years,
for the code has remnants that go back to 1960s style of coding.

1. In a unix shell:
    1. `git checkout develop       # switch to develop branch`
    2. `git pull                   # get the latest updates`
    3. `git checkout magneticField # switch branch`
    4. `git pull                   # get updates
    5. `git merge --no-ff develop  # now we have the "develop" updates and are ready to code`
    6. `cd src                     # got to right directory`

2. In R:
    1. `download.file("https://www.ngdc.noaa.gov/IAGA/vmod/igrf13.f", "igrf13.f")`

3. In a unix shell:
    1. `git add igrf13.f`
    2. `git commit -m "download igrf13.f"`

4. In an editor, change `igrf13.f` in stages. To make it easier to follow changes, it makes sense to store explanations in git comments, and so I am listing some explanatory below, in hopes that they cn be used in a future version.
    1. Delete the main program, the DMDDEC subroutine, and the DDECDM subroutine.  Commit note: `"delete MAIN, DMDDEC and DDECDM"`.
    2. Notice that in line 58 and many lines thereafter, there is a comment at the end. On line 58, it is ` 1900` (space, then the number). This is following an old Fortran convention that any characters appearing in columns 73 to 80 is ignored. When R tries to compile the code, a warning will be issued for every one of these lines. Since the CRAN team does not approve of warnings, these lines should all be edited.  Do *not* remove material in column 72, because that will entirely break the fortran code. Be careful, since you are editing about 500 lines, and doing this without a decent programming editor is a recipe for errors.  Commit note: `"remove column 73-80 comments"`.

5. At this stage, the code should compile without errors, but it is likely to have lots of warnings, e.g. the following. You ought to check that you get *only* these warnings, because if more crop up, that will mean some more thought will be required.
```
igrf13.f:670:72:

  670 |    10 m     = m + 1
      |                                                                        1
Warning: Fortran 2018 deleted feature: DO termination statement which is not END DO or CONTINUE with label 10 at (1)
igrf13.f:546:14:

  546 |       ll    = t
      |              1
Warning: Possible change of value in conversion from REAL(8) to INTEGER(4) at (1) [-Wconversion]
igrf13.f:560:15:

  560 |        ll    = 0.2*(date - 1995.0)
      |               1
Warning: Possible change of value in conversion from REAL(8) to INTEGER(4) at (1) [-Wconversion]
igrf13.f:646:0:

  646 |        three = (fn + gn)/one
      | 
Warning: 'gn' may be used uninitialized in this function [-Wmaybe-uninitialized]
igrf13.f:631:0:

  631 |        fn    = n
      | 
Warning: 'fn' may be used uninitialized in this function [-Wmaybe-uninitialized]
```

6. Since we want `oce` to build *without* warnings, these must be addressed.  It's a bit pointless to explain the details of how to fix these (it's a Fortran lesson) so I'll just give the diff, which will tell what I did:
```diff
diff --git a/src/igrf13.f b/src/igrf13.f
index fd31699c..d227a008 100644
--- a/src/igrf13.f
+++ b/src/igrf13.f
@@ -536,6 +536,15 @@ c
       x     = 0.0
       y     = 0.0
       z     = 0.0
+c *** oce: give several fn, three and gn initial values, to prevent
+c *** oce: warnings issued during compilation by R. (It seems likely
+c *** oce: that the original code was either using knowledge that
+c *** oce: things would always be assigned, or was using the
+c *** oce: zero-initialization property of fortran.)
+      fn = 0.0
+      three = 0.0
+      gn = 0.0
+
       if (date.lt.1900.0.or.date.gt.2030.0) go to 11
       if (date.gt.2025.0) write (6,960) date
   960 format (/' This version of the IGRF is intended for use up',
@@ -543,7 +552,7 @@ c
      2        ' but may be of reduced accuracy'/)
       if (date.ge.2020.0) go to 1
       t     = 0.2*(date - 1900.0)                                             
-      ll    = t
+      ll    = int(t)
       one   = ll
       t     = t - one
 c
@@ -557,7 +566,7 @@ c
       else
        nmx   = 13
        nc    = nmx*(nmx+2)
-       ll    = 0.2*(date - 1995.0)
+       ll    = int(0.2*(date - 1995.0))
 c
 c     19 is the number of SH models that extend to degree 10
 c
@@ -623,7 +632,7 @@ c
       p(3)  = st
       q(1)  = 0.0
       q(3)  =  ct
-      do 10 k=2,kmx                                                       
+      do k=2,kmx                                                       
        if (n.ge.m) go to 4
        m     = 0
        n     = n + 1
@@ -668,6 +677,7 @@ c
        z     = z - (fn + 1.0)*one*p(k)
        l     = l + 1
    10 m     = m + 1
+       end do
 c
 c     conversion to coordinate system specified by itype
 c
```
We must remove all code that writes messages to the terminal output. There is a way to do that in C, so I suspect there is a way also in Fortran, but I cannot be bothered to look that up, and instead I will just comment all those lines out.  (I am commenting them out instead of deleting them because if bugs arise, we might want to reinvigorate these lines.)
Commit note: `" remove fortran warnings, comment-out write()"`
7. If things are compiling without warnings, edit `src/magdec.f` to handle the new function. Doing that should be obvious to someone familiar with fortran.  Commit note: `"let fortran see new igrf13.f code"`)
8. In an editor, alter `R/misc.R` so that the new version (here, number 13) is (a) in the of permitted versions and (b) is the new default.
9. Try a test build. It it produces errors or warnings, you'll need to do some detective work to find out why.  (Anyone who knows both R and Fortran will have no issues in this, I think.)

This ought to be the end of the coding. Now, clean and rebuild the whole thing.
If it fails, you'll want to find out why, before proceeding.  Once you have it
all working, check that the test suite still works.  Unless the modifications
to the Fortran code (i.e. the underlying formulae) have been minor, it seems
likely that the test suite will fail.  So, your next task will be to figure out
why, and to both fix the existing broken tests and create new tests that
exercise the newly-added code.

Once you think you're all done, please look at the help for the function, and
ensure that it is still relevant.

# Checking the results

The tests shown by `?magneticField` produce some useful graphs, which are reproduced below.

{% highlight r linenos=table %}
library(oce)
{% endhighlight %}



{% highlight text %}
## Loading required package: gsw
{% endhighlight %}



{% highlight text %}
## Loading required package: testthat
{% endhighlight %}



{% highlight r linenos=table %}
# 1. Today's value at Halifax NS
magneticField(-(63+36/60), 44+39/60, Sys.Date())
{% endhighlight %}



{% highlight text %}
## $declination
## [1] -16.96447
## 
## $inclination
## [1] 66.87279
## 
## $intensity
## [1] 51512.67
{% endhighlight %}

World map of declination in year 2000.

{% highlight r linenos=table %}
data(coastlineWorld)
par(mar=rep(0.5, 4)) # no axes on whole-world projection
mapPlot(coastlineWorld, projection="+proj=robin", col="lightgray")
# Construct matrix holding declination
lon <- seq(-180, 180)
lat <- seq(-90, 90)
dec2000 <- function(lon, lat)
    magneticField(lon, lat, 2000)$declination
dec <- outer(lon, lat, dec2000) # hint: outer() is very handy!
# Contour, unlabelled for small increments, labeled for
# larger increments.
mapContour(lon, lat, dec, col='blue', levels=seq(-180, -5, 5),
           lty=3, drawlabels=FALSE)
mapContour(lon, lat, dec, col='blue', levels=seq(-180, -20, 20))
mapContour(lon, lat, dec, col='red', levels=seq(5, 180, 5),
           lty=3, drawlabels=FALSE)
mapContour(lon, lat, dec, col='red', levels=seq(20, 180, 20))
mapContour(lon, lat, dec, levels=180, col='black', lwd=2, drawlabels=FALSE)
mapContour(lon, lat, dec, levels=0, col='black', lwd=2)
{% endhighlight %}

![center](http://dankelley.github.io/figs/2020-03-03-oce-update-magneticField/unnamed-chunk-2-1.png)

Declination differences between versions 12 and 13


{% highlight r linenos=table %}
lon <- seq(-180, 180)
lat <- seq(-90, 90)
decDiff <- function(lon, lat) {
    old <- magneticField(lon, lat, 2020, version=13)$declination
    new <- magneticField(lon, lat, 2020, version=12)$declination
    new - old
}
decDiff <- outer(lon, lat, decDiff)
decDiff <- ifelse(decDiff > 180, decDiff - 360, decDiff)
# Overall (mean) shift -0.1deg
t.test(decDiff)
{% endhighlight %}



{% highlight text %}
## 
## 	One Sample t-test
## 
## data:  decDiff
## t = -21.794, df = 65340, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  -0.10399320 -0.08683188
## sample estimates:
##   mean of x 
## -0.09541254
{% endhighlight %}



{% highlight r linenos=table %}
# View histogram, narrowed to small differences
par(mar=c(3.5, 3.5, 2, 2), mgp=c(2, 0.7, 0))
hist(decDiff, breaks=seq(-180, 180, 0.05), xlim=c(-2, 2),
     xlab="Declination difference [deg] from version=12 to version=13",
     main="Predictions for year 2020")
{% endhighlight %}

![center](http://dankelley.github.io/figs/2020-03-03-oce-update-magneticField/unnamed-chunk-3-1.png)

{% highlight r linenos=table %}
print(quantile(decDiff, c(0.025, 0.975)))
{% endhighlight %}



{% highlight text %}
##       2.5%      97.5% 
## -1.6695352  0.7159345
{% endhighlight %}



{% highlight r linenos=table %}
# Note that the large differences are at high latitudes
imagep(lon,lat,decDiff, zlim=c(-1,1)*max(abs(decDiff)))
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])
{% endhighlight %}

![center](http://dankelley.github.io/figs/2020-03-03-oce-update-magneticField/unnamed-chunk-3-2.png)



# References and resources

1. [IAGA website for IGRF](https://www.ngdc.noaa.gov/IAGA/vmod/igrf.html)

2. [igrf13.f Fortran code](https://www.ngdc.noaa.gov/IAGA/vmod/igrf13.f)

3. Jekyll source code for this blog entry: [2020-03-03-oce-update-magneticField.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-03-03-oce-update-magneticField.Rmd)
