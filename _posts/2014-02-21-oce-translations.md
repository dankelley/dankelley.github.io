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

Edit ``po/R-fr.po`` as desired, inserting translations.  The easiest way is to insert accents is with the text editor, and for this to work it will be necessary to edit one of the lines near the top of this file to read ``Content-Type: text/plain; charset=UTF-8``.  In doing the translation, I focussed on words used on axes, and worked on translations at the same time as I added ``gettext()`` calls to especially ``resizableLabel()`` in ``R/misc.R``.

## Update work cycle

Here I am a bit foggy.  I think the work cycle (say, for French) is:

Edit your source code ... repeat step 3 ... build your package and test.

(NOTE: once, I thought step 3 had to be accompanied with ``msgmerge --update R-fr.po R-oce.pot`` in the shell, but now I do not think this is needed.)

As an example, the following tests some CTD plots in English, Spanish, and French.

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

At the moment, Oce works in English, with some support for Spanish and French, and just a few test words for Mandarin.  (For Mandarine, be sure to specify your PDF plot device as e.g. ``pdf(..., family="BG1")`` so that proper fonts will be loaded.)

If you would like Oce graphs to work in another language with which you have high familiarity, please contact me.  I will need you to write down a few relevant words in your language and send them to me via PDF or scanned hand-written document (MSword and OpenOffice formats cannot are not useful).  Minimally, the words should be the ones used on axes of the graphs you use, but it would help other users if you could translate the phrases listed below.  Also, translate ``E``, ``W``, ``N``, and ``S``, as used in longitude and latitude, as well as any other unit abbreviations that differ between English and your language.

{% highlight bash linenos=table %}
Absolute Salinity
Conservative Temperature
Depth
Distance
Elevation
Longitude
Latitude
Potential Temperature
Potential Density Anomaly
Practical Salinity
Pressure
Sea Level
Speed
Temperature
Velocity
{% endhighlight %}

