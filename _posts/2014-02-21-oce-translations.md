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
status: draft
---

A new user wondered how to get Spanish labels on axes, so I did some reading and got some help from R-help; this posting describes what I did, in hopes that it will smooth the path to doing this in another language

## Update work cycle

Step 1. Set up a directory named ``oce/po/``.

Step 2. Add some text like ``gettext("Pressure")`` in the ``resizableLabel()`` function in ``oce/R/misc.R``.  This, and other text strings, will be scanned by the next step.

Step 3. Go to the ``oce`` directory, launch R, and do as follows

{% highlight R linenos=table %}
library(tools)
update_pkg_po(".")
{% endhighlight %}

This will insert a file named ``R-oce.pot`` in the ``po`` directory.  (Actually, I'm not sure if a step has to be done before this one... possibly one has to do ``msginit`` in the ``po`` directory.)

Step 4. To start work on, say, a French translation table, do

{% highlight bash %}
cd oce/po
msginit --locale=R-fr --input R-oce.pot
{% endhighlight %}

in the shell.

Step 5. Edit ``po/R-fr.po`` as desired, inserting translations.  The easiest way is to insert accents with the text editor, and for this to work it will be necessary to edit one of the lines near the top of this file to read ``Content-Type: text/plain; charset=UTF-8``.  In doing the translation, I focussed on words used on axes, and worked on translations at the same time as I added ``gettext()`` calls to especally ``resizableLabel()`` in ``R/misc.R``.

## Update work cycle

Here I'm a bit foggy.  I think the work cycle (say, for French) is:

Edit your source code ... repeat step 3 ... run the following in the shell.

{% highlight bash %}
msgmerge --update R-fr.po R-oce.pot
{% endhighlight %}

Then build your package and test.  The test could be e.g. as follows, for Spanish, French, and English.  BUG: pressure is not translated, and I'm not sure why!


{% highlight r linenos=table %}
library(oce)
{% endhighlight %}



{% highlight text %}
## Loading required package: methods
## Loading required package: mapproj
## Loading required package: maps
{% endhighlight %}


{% highlight r linenos=table %}
data(ctd)
par(mfrow = c(1, 3))
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "es")
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "fr")
plotProfile(ctd, "T")
{% endhighlight %}

[![center]({{ site.url }}/assets/2014-02-21-oce-translations-thumbnail.png)]({{ site.url }}/assets/2014-02-21-oce-translations.png)


Instead of using ``Sys.setenv()`` one can define the language in the shell, as (temporarily) in the following invocation.

{% highlight bash %}
LANG=es_ES.UTF-8 R --no-save < spanish.R
{% endhighlight %}

## Bugs

As noted, I'm hazy on some steps because I got confused and redid things a fair bit.  Most likely this page will need revision.

