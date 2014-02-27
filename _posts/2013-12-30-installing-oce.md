---
layout: post
title: Installing oce in R
tags: [oceanography, oce, R]
category: R
year: 2013
month: 12
day: 30
summary: Instructions are given for installing oce.
description: Instructions are given for installing oce.
---

Several of the blog items have used the oce package.  The official version of this can be installed from within R by

{% highlight r linenos=table %}
install.packages("oce")
{% endhighlight %}

and more up-to-date versions can be installed using the ``devtools`` package written by Hadley Wickham, which is itself installed with

{% highlight r linenos=table %}
install.packages("devtools")
{% endhighlight %}

after which installing the latest development version of oce is accomplished with

{% highlight r linenos=table %}
library(devtools)
install_github('ocedata', 'dankelley', 'master')
install_github('oce', 'dankelley', 'develop')
{% endhighlight %}

Note that the ``ocedata`` package does not need to be updated frequently, as it only updated when new datasets are added to oce. The official version of oce is only updated every few months, but the branch named ``develop`` (used above) may be updated several times a day, if the author is adding new features or fixing bugs.

For more on oce, see the [oce website on github](http://dankelley.github.io/oce/).
