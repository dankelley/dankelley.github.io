---
layout: post
title: How entries are added to this blog
tags: blogging
category: development
year: 2014
month: 1
day: 24
summary: The system for adding entries to the blog is explained, and hints are given for debugging the formatting.
description: How entries are added to this blog
---

Entries are added to this blog simpy by creating files in the ``_posts/`` directory.  There is an important convention on the file names: they must start with the year, followed by a dash, followed by the decimal number (with leading zero if appropriate), followed by the day, followed by a dash and then followed by some title words, and with ``.md`` at the end.

The format of the blog entries is markdown for the main body, but the first part must be a preface in so-called YAML format.  See any existing blog entry for the format, which should be simple to understand.

Since Markdown errors will cause non-display of the item when it is eventually uploaded to github, it is important to test things locally first.  This is very easy.  In the commandline, type

{% highlight bash %}
jekyll serve --watch
{% endhighlight %}

to start a server.  It will state a local URL that holds the blog.  Cut and past that URL in a browser, and you will see a local copy of the blog.  Every time you edit a file, ``jekyll`` will update the blog, but you will need to do a browser refresh to see the results.

Once things work well locally, type the following in a terminal to upload the blog to github.
{% highlight bash %}
make
git add .
git commit -m MSG
git push
{% endhighlight %}

PS. the ``make`` part of the above is important, because it moves a tags file from a location where github will not find it, to another where it will be found.  Simply using ``git`` to upload files will give a blog that works in all respects except for tagging, but what would be the point of that?

