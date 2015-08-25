---
layout: post
title: email graphs
tags: [R]
category: R
year: 2015
month: 8
day: 25
summary: R code is provided to create graphs of email timing. Such graphs can be helpful in documenting progress in group projects for which email frequency is of interest.
---

Communication between individuals working on a group project is commonly
carried over email, and in-person meetings tend to be preceded by an emailed
agenda, and followed by emailed minutes.  Projects organized around GitHub or
similar systems tend also to have email updates for issue reports, etc.  All of
this means that a graph of email timing can be helpful in indicating activity.
Such graphs are easier to interpret than a printed list of dates, and I have
found them to be quite helpful in organizing group work.

I make the graphs in R, and the point of this exercise is to illustrate how to
do that.  Below is an example, in which I've substituted colour names for
person names. In this case, I have put the data into the format (time, sender,
recipient); obviously, it is also simple to put instead a subject line, lines
of text, etc; it all depends on the purpose.


{% highlight r linenos=table %}
data <- "
2015-08-24 16:14:17,red,blue
2015-08-19 09:18:00,blue,red
2015-07-31 14:23:31,blue,purple
2015-07-31 13:48:56,beige,blue
2015-07-31 12:17:00,brown,beige
2015-07-31 11:15:00,purple,beige
2015-07-30 19:59:00,green,yellow
2015-07-30 08:09:00,orange,blue
2015-07-30 08:09:00,blue,orange
2015-07-30 07:59:00,orange,green
2015-07-30 07:56:00,orange,blue
2015-07-30 07:59:00,green,yellow
2015-07-29 21:04:00,yellow,green
2015-07-29 11:07:00,green,yellow
2015-07-28 15:22:00,yellow,green
2015-04-11 10:19:00,blue,pink
2015-04-11 10:13:00,pink,blue
2015-04-11 09:43:00,blue,pink
2015-04-01 08:40:00,blue,blue
"
d <- read.csv(text=data, header=FALSE)
t <- as.POSIXct(d$V1, tz="UTC")
o <- order(t, decreasing=TRUE) # just in case
t <- t[o]
from <- d$V2[o]
to <- d$V3[o]
n <- length(from)
day <- 86400
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
timeSpan <- as.numeric(max(t)) - as.numeric(min(t))
space <- 0.15 * timeSpan # adjust as necessary
plot(t, 1:n, type='n', xlab="", ylab="Email", xlim=c(min(t), max(t)+space*timeSpan), ylim=c(0, n+1))
tl <- max(t) + space
for (i in 1:n) {
    text(tl + 0.01 * space, i, paste(from[i], "-", to[i], sep=""), pos=4)
    lines(c(tl, t[i]), rep(i, 2))
    lines(c(t[i], t[i]), c(i, 0))
}
{% endhighlight %}

![center](http://dankelley.github.io/figs/2015-08-25-email-graphs/unnamed-chunk-1-1.png) 

This shows that there was a fair bit of activity in the Spring, and then much
more intense work near the end of July.  The labels show sender and recipient;
in some cases it would make sense to put in keywords or subjectlines. It all
depends on the purpose, of course.

The code has some hard-wired constants for spacing, and this will likely need
adjustment for other time spans also for other string sizes.  No pretence at
elegance is being made in the code; the idea is just to present a rough
framework that readers can modify to suite their needs.

Readers will almost certainly want to display other things in the text lines;
the method should be completely obvious to anyone with introductory R skills.

I suppose I could clean this up and put it in my [plan
package](https://github.com/dankelley/plan).

# Resources

1. Source code: [2015-08-25-email-graphs.R]({{ site.url }}/assets/2015-08-25-email-graphs.R)
2. Jekyll source code for this blog entry: [2015-08-25-email-graphs.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2015-08-25-email-graphs.Rmd)
