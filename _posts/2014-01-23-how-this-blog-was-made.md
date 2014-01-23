---
layout: post
title: How this blog was made
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

## Some snags and how to deal with them:

1. Any errors on the github server can yield blank pages, and the time delay of a minute or so makes it important to get things right locally before uploading.  The solution is simple: run a local jekyll server with the unix command ``jekyll serve --watch`` (the last word means that it should automatically regenerate files if it sees that any sourcefile has changed).  Once things work well locally, do ``make`` and then the usual ``git add/commit/push`` to upload to github.

2. The method of generating tags (which I got from ocramius, who got it from erjjones) puts the tag-list files into ``_site/tags`` but jekyll will not serve the files from there.  They must go into ``tags`` at the top level.  The solution I am using is to continue using the ruby script that I found for creating tags, but to use a Makefile to shift the file locations.

