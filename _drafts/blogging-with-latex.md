---
layout: post
title: Blogging with latex
tags: blogging
category: R
year: 2013
month: 12
day: 25
summary: The scheme for setting up a latex-aware Jekyll blog is explained.
description: The scheme for setting up a latex-aware Jekyll blog is explained.
latex: true
---


The [Jekyll docs](http://jekyllrb.com/docs/extras/) indicate that latex can be supported by using ``blahtex``.  The latter is a program whose source may be found at [https://github.com/gvanas/blahtexml](https://github.com/gvanas/blahtexml).  I tried compiling and installing the source (on an OSX machine) involves two steps, once the source is downloaded:

{% highlight bash linenos=table %}
blahtex-mac
sudo cp blahtex /usr/local/bin
{% endhighlight %}

but was not sure what to do next, since the jekyll docs said very little and none of the other things I found were worked for me.

Then I ran across a [blog posting](http://dasonk.github.io/blog/2012/10/09/Using-Jekyll-and-Mathjax/) on point-mass-prior (a very nice looking site) and that seemed to work fine. Just install the following in the ``<head>`` portion of the html (e.g. in ``_layouts/post.html``).

{% highlight html %}
<script type="text/javascript"
src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
{% endhighlight %}


# Test 1: inline math

Inline mathematical elements do not work.

# Test 2: floating math

Double-dollarsign notation works, e.g. ``$$a\sin(b)$$`` creates the following

$$a\sin(b)$$

# Implementation

On the presumption that it sensible to download the latex software with every page (e.g. consider a mobile phone with data charges), in my ``_layouts/post.html`` file I wrap the script inclusion in a test on whether ``latex`` is true.

With this done, one can include the following line in the YAML preface of posts that use latex:
{% highlight html %}
latex: true
{% endhighlight %}


