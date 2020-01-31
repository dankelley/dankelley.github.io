---
layout: post
title: making epub files with pandoc
tags: [m00n]
category: m00n
year: 2020
month: 1
day: 31
summary: I show how to make an epub file from a mardown file, using `pandoc`.
---

# Introduction

I've started working on a children's book called ``m00n''  (about which, more
on another day) and am using the R bookdown package.  This package creates a
variety of formats, including pdf and epub.

As explained at [1], Epub format is used quite widely for electronic
publishing, and works with a lot of readers (apparently, not including kindle,
but I've not tested that yet). The fact that R bookdown uses epub is good
enough to convince me that it's a useful format, kindle notwithstanding.

In building the book, I saw the output (I added back-slashes to indicate line continuation)
```
/usr/local/bin/pandoc \
+RTS -K512m -RTS \
m00n.utf8.md \
--to epub3 \
--from markdown+autolink_bare_uris+tex_math_single_backslash \
--output m00n.epub \
--number-sections \
--filter /usr/local/bin/pandoc-citeproc
```

Although I have not looked in detail at the `pandoc` documentation, I think
I can make some educated guesses as to what is going on:

* Line 1 just states the full pathname of `pandoc`.
* Line 2 is a trick to prevent some DOS attacks (according to `man pandoc`)
* Line 3 names the input Markdown file
* Line 4 says we want epub format (version 3 I guess)
* Line 5 seems to give some hints on formatting
* Line 6 names the desired output file
* Line 7 indicates that sections ought to be numbered
* Line 8 runs the input through `pandoc-citeproc`, for cross-references

So, let's try making our own epub file.  First, create a file named `a.md` containing
```
Hi kids.

1. This is a test.
2. Just a test.

Oh, isn’t $\pi$ a sweetie-pie.
```

Second, run `pandoc` with
```
pandoc a.md --o=epub3 --output=a.epub --metadata title=‘test’
```
where the `title` part is to prevent an error.  (The error suggested how to solve
the problem. There is also something called `pagetitle` that seems related.)

And that's it.  You'll have a file `a.epub` that you can read on a variety of
devices. And it ought to render well on all of them, adjusting to screen size
and geometry.  It has nice navigation features for going between pages, etc.
This will all be familiar to people who read books this way.

# References and resources

1. [epub wikipedia page](https://en.wikipedia.org/wiki/EPUB)

2. Jekyll source code for this blog entry: [2020-01-31-pandoc-epub.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2020-01-31-pandoc-epub.Rmd)


