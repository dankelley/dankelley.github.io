---
layout: post
title: how this blog was made
tags: blogging
category: development
year: 2014
month: 1
day: 23
summary: How this blog was made
description: Ongoing notes on the construction of this blog.
---

## Motivation

After using wordpress for a month or so, I got tired of the divergence that always seemed to happen between my local (R-markdown) source and the normal-markdown on wordpress.  My pattern was to write something rough locally in Rmd and then use knitr to create local markdown, and then upload it.  That would be fine but WP has some special tricks for figure inclusion, so the markdown file on WP will not be the same as locally.  And then I always edit everything when I see it on the screen, so that also makes the WP markdown file differ from the local one.  And, finally, WP changes some of the markdown from characters I like (less-than, for example) into silly html characters.  The consequence of all this is that my local "source" copy is not the same as the source on WP, and I do not like that since it means I have no archive in case WP decides to charge me, or goes out of business, or puts larger ads on their site.  I wanted to try other blogging methods, and github/jekyll came to mind because I use github a lot.

## Methods

I read through the jekyll docs to get a general idea, and made a blog.  Of course it did not work, so I started searching for hints.  I do not even recall the original problem, but in any case I solved it, and along the way I ran across [http://ocramius.github.io](http://ocramius.github.io), a site that had what I wanted (especially tags, which the jekyll docs do not discuss), so I started using that as a resource.  Then I noticed that it was in turn based on [http://erjjones.github.io/blog/Part-two-how-I-built-my-blog/](http://erjjones.github.io/blog/Part-two-how-I-built-my-blog/), so that became my go-to source for practical hints.

## Status

Tagging works locally (with a local jekyll serving the pages) but not on github.  I have no idea why, but I suspect that the problem is that I must tell jekyll to serve up pages in ``_site/tags``, or that the tag files need another name, or some damned thing.  OH, UPDATE -- I see from erjjones that you have to do ``mv _site/tags .`` for it to work (i.e. ``tags``) has to be at the top level.  I will do that in a Makefile.

