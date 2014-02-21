---
layout: post
title: Oce translations
tags: [R, oce]
category: R
year: 2014
month: 2
day: 12
summary: The Oce scheme for adding translated axis labels is described.
description: The Oce scheme for adding translated axis labels is described.
---

A new user wondered how to get Spanish labels on axes, so I did some reading and got some help from R-help. This posting describes what I did, in hopes that it will smooth the path to doing this in another language.  I am not entirely clear that the steps I document here are the ones I took, or that anyone else should take, since I got somewhat mixed up in the process (and was grateful to get help from BR on R-help).  I may revise this posting later, if I add a new language and get clearer on the steps.  Readers are advised to exercise care if copying my procedure, and to consult the many other websites dealing with text translation (and how it is done in R).

## Initial work cycle

### Step 1

Create a directory named ``oce/po/``.

### Step 2

Add some text like ``gettext("Pressure")`` in the ``resizableLabel()`` function in ``oce/R/misc.R``.  This, and other text strings, will be scanned by the next step.

### Step 3

Enter the ``oce`` directory, launch R, and type as follows, to will insert a file named ``R-oce.pot`` in the ``po`` directory.  (Actually, I am not sure if a step has to be done before this one... possibly one has to do ``msginit`` in the ``po`` directory.)


{% highlight R linenos=table %}
library(tools)
update_pkg_po(".")
{% endhighlight %}

### Step 4

To start work on, say, a French translation table, type the following in the shell.

{% highlight bash linenos=table %}
cd oce/po
msginit --locale=R-fr --input R-oce.pot
{% endhighlight %}


### Step 5

Edit ``po/R-fr.po`` as desired, inserting translations.  The easiest way is to insert accents is with the text editor, and for this to work it will be necessary to edit one of the lines near the top of this file to read ``Content-Type: text/plain; charset=UTF-8``.  In doing the translation, I focussed on words used on axes, and worked on translations at the same time as I added ``gettext()`` calls to especally ``resizableLabel()`` in ``R/misc.R``.

## Update work cycle

Here I am a bit foggy.  I think the work cycle (say, for French) is:

Edit your source code ... repeat step 3 ... run the following in the shell.

{% highlight bash linenos=table %}
msgmerge --update R-fr.po R-oce.pot
{% endhighlight %}

Then build your package and test.  The test could be e.g. as follows, for Spanish, French, and English.


{% highlight r linenos=table %}
library(oce)
data(ctd)
par(mfrow = c(1, 3))
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "es")
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "fr")
plotProfile(ctd, "T")
{% endhighlight %}

This produces the graph shown below (click to enlarge).

[![center]({{ site.url }}/assets/2014-02-21-oce-translations-thumbnail.png)]({{ site.url }}/assets/2014-02-21-oce-translations.png)


Instead of using ``Sys.setenv()`` one can define the language in the shell, as (temporarily) in the following invocation.

{% highlight bash linenos=table %}
LANG=es_ES.UTF-8 R --no-save < spanish.R
{% endhighlight %}

## How to help with Oce translations

At the moment, Oce works in English, with some support for Spanish and French.

If you would like Oce graphs to work in your language, please contact me via this blog.  I will need you to write down a few relevant words in your language and send them to me via PDF or scanned hand-written document (MSword is not useful).  Minimally, the words should be the ones used on axes of the graphs you use, but it would help other users greatly if you could translate everything on the list given below, line by line.  (Also, translate ``E``, ``W``, ``N``, and ``S``, as used in longitude and latitude.)
{% highlight linenos=table %}
Absolute Salinity
Conservative Temperature
Depth
Distance
Elevation
Longitude
Latitude
Practical Salinity
Potential Temperature
Pressure
Sea Level
Speed
Temperature
Velocity
{% highlight %}

