---
layout: post
title: Assessing mapdata world coastline
tags: [R, oce, coastline]
category: R
year: 2015
month: 1
day: 28
summary: Test of potential new coastline for ocedata package
latex: true
---

# Introduction

The ``mapdata`` R package contains a coastline called ``worldHires`` which is contained within a text file with a bit over 2 million lines.  Since the ``coastlineWorldFine`` dataset in the ``ocedata`` package contains about 0.5 million points, I thought I would explore how much better the ``mapdata`` coastline might be.

# Methods

First, I wrote the following C file to translate the data to something that R can read.

{% highlight r linenos=table %}
#include <stdio.h>
char *file = "/Users/kelley/mapdata/src/worldHires.line";
int main()
{
    char tok1[100], tok2[100]; // needn't be anywhere near that long
    FILE *in = fopen(file, "r");
    int ok;
    int count = 0;
    int skip = 1;
    while (1) { //count++ < n) {
        if (skip) {
            fscanf(in, "%s", tok1);
            if (feof(in))
                return(0);
            fscanf(in, "%s", tok2);
            printf("NA NA\n");
            skip = 0;
        } else {
            fscanf(in, "%s", tok1);
            if (tok1[0] == 'E') {
                skip = 1;
            } else {
                fscanf(in, "%s", tok2);
                printf("  %s %s\n", tok1, tok2);
            }
        }
    }
}
{% endhighlight %}

Then, I created a datafile for plotting. It turns out that ``mapdata`` numbers are in radians, so a conversion was required.

I plotted this "new" dataset and the "old" one (containined in ``ocedata``) and the results are shown below. 

# Results

![center](http://dankelley.github.io/figs/2015-01-28-coastline/coastline.png) 

# Conclusions

There are some differences between the two, but nothing dramatic (e.g. no Northwest Arm of Halifax Harbour). Certainly it would be difficult to argue for exapanding the memory footprint of ``ocedata`` by a factor of 4.


