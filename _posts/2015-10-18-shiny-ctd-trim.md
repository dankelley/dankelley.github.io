---
layout: post
title: trimming CTD files with shiny
tags: [oce,R]
category: R
year: 2015
month: 10
day: 18
summary: The shiny R library is demonstrated with an application to trim CTD data.
---

# Introduction

The shiny library [1] provides a graphical user interface (GUI) for the R
language that may open up new possibilities for human judgement in data
filtering, as well as for the use of R by those who choose not to learn its
syntax. The first category is the intended audience here, in this first of a
series of blog postings about using shiny for Oceanography.

Consider the task of finding the downcast portion of a CTD cast. This must be
done because raw CTD data typically include measurements that are of limited
value. At the start of a dataset, it is typical to have measurements made
during a sensor-equilibration phase, during which the instrument is held just
below the water surface for a minute or so. This is followed by a descent
through the water column, ideally at almost uniform speed, and, after that, by
an ascent phase. In most cases, only the descent phase is of direct interest,
so a first step in processing is usually to isolate this phase.

The ``ctdTrim()`` function in the oce library [2] often does a good job of
locating the descent phase, and trimming data recovered before and after.
However, this function is somewhat limited, employing an ad-hoc algorithm that
has parameters that were calibrated on a limited dataset, guided by the eye of
a single analyst. Since deep-sea CTD casts take an hour or two to acquire (i.e.
cost several thousand dollars of ship time), it is entirely reasonable to pay a
technician for a minute or two, to check the results, or to supplant them,
based on visual inspection of the data.

This suggests that CTD trimming might be good demonstration of shiny. As I'm
just learning the system, the methodology is crude. I wanted to learn how to use
slider bars, so I use ``sliderInput()`` to select the downcast. I wanted to
learn how to use a file-choice dialog, so I used ``file.choose()`` for that.

I am not going to explain the code in any detail. Readers unfamiliar with R
will understand very little, I fear, but my purpose is not to replace the
dozens of textbooks and online materials that teach R. Readers unfamiliar with
shiny should start by doing. Just copy the code into two files as named below.
Then, in rstudio, load one of the files, and click the "runApp" button that you
should see. If that button does not appear, or if you're using something other
than rstudio, type following into the R console.


{% highlight r linenos=table %}
library(shiny)
runApp() # exit by striking ESC on the keyboard
{% endhighlight %}

Below is the contents of the ``ui.R`` file

{% highlight r linenos=table %}
library(shiny)
shinyUI(fluidPage(verticalLayout(
                                 plotOutput("ctdTrimPlot"),
                                 wellPanel(
                                           sliderInput("top", "top fraction percent:",
                                                       min=0, max=100, value=0, step=0.1),
                                           sliderInput("bottom", "bottom fraction percent:",
                                                       min=0, max=100, value=100, step=0.1))
                                 )))
{% endhighlight %}
This will look a bit mysterious, but anyone who spends 20 minutes with the
[shiny documentation](http://shiny.rstudio.com) will get the gist: two sliders
will be shown below a plot that is create with a user-created function named
``ctdTrimPlot()``.

Below is the contents of the ``server.R`` file

{% highlight r linenos=table %}
library(oce)
file <- file.choose()
ctdRaw <- read.oce(file)
## data(ctdRaw) # try this if you have no .CNV files to test
shinyServer(function(input, output) {
            top <- reactive({as.numeric(input$top)})
            bottom <- reactive({as.numeric(input$bottom)})
            trimmed <- ctdRaw
            output$ctdTrimPlot <- renderPlot({
                nf <- layout(matrix(c(1, 2, 3, 4, 4, 4), nrow=2, byrow=TRUE))
                index <- seq_along(ctdRaw[["pressure"]])
                indexStart <- index[1] + 0.01*top() * diff(range(index))
                indexEnd <- index[1] + 0.01*bottom() * diff(range(index))
                trimmed <- ctdTrim(ctdRaw, method="index", parameters=c(indexStart, indexEnd))
                save(trimmed, file="trimmed.rda")
                plotProfile(trimmed, xtype="temperature",
                            mar=c(0.2, 2.2, 2.5, 0.8), mgp=c(1.2, 0.3, 0))
                plotProfile(trimmed, xtype="salinity",
                            mar=c(0.2, 2.2, 2.5, 0.8), mgp=c(1.2, 0.3, 0))
                plotTS(trimmed,
                       mar=c(2.2, 2.2, 1.0, 0.8), mgp=c(1.2, 0.3, 0))
                plotScan(ctdRaw,
                         mar=c(2.5, 2.5, 0.8, 0.8), mgp=c(1.2, 0.3, 0))
                suggested <- range(ctdTrim(ctdRaw)[["scan"]])
                abline(v=suggested, lty=2, col=c('red', 'blue'))
                abline(v=c(indexStart, indexEnd), col=c('red', 'blue'))
                legend("topright", c(suggested[1], indexStart,
                                     suggested[2], indexEnd),
                       col=c("red", "red", "blue", "blue"), 
                       lty=c(2, 1, 2, 1),
                       legend=c("Start (suggested)",
                                sprintf("Start (user): %.0f", indexStart),
                                "End (suggested)",
                                sprintf("End (user): %.0f", indexEnd)))
            }, pointsize=20)
})
{% endhighlight %}

Here, notice the use of ``shinyServer()``. Again, this will seem mysterious at
first, but a quick glance shows that a major task here is the creation of the
``ctdTrimPlot()`` function.  (Readers familiar with oce [2] will note that the
margins are made very tight here, mainly to devote more space to the data.)

Interested users should simply copy these files, and try them. If there are no
``.CNV`` files handy, comment out the ``file.choose()`` line and uncomment the
``data(ctdRaw)`` line.

Note that the code saves the trimmed data as an ``rda`` file in the local
directory. A more sophisticated application would use a tailored file name.
Another useful addition might be to use mouse drags on the scan-pressure plot,
instead of a slider. But these things are for another day.  For now, the goal
has been met: the reader can see that shiny permits user interaction in a way
that is practical, if not elegant. Those who try this in action will find that
it is a bit slow, but this is not so much an issue with shiny as it is with
plotting. Also, bear in mind the calculation of the cost of acquiring the data
... is a 1/4 second lag in an interface an issue for a dataset that cost an
hour to acquire that that might yield great benefits to science?

Below is a screenshot of the initial view of the application.  Anyone who has
looked at CTD data will note the wildly unphysical salinity and temperature
characteristics. The dotted lines in the scan-pressure plot show the trimming
that ``ctdTrim()`` would do, and the solid lines are the values as set at the
moment (which are 0 and 100 percent, at the start). The user should adjust
those sliders to narrow in on the profile.

![ctd_trim_fig_1.png]({{ site.url }}/assets/ctd_trim_fig_1.png)

Below is a screenshot of a view after the downcast has been selected.  It
should be noted that I selected a different range than was selected
automatically by ``ctdTrim()``, because I thought the automatic cutoff at the
bottom of the profile came too late, i.e. during a time when the instrument was
not moving through the water column.

![ctd_trim_fig_2.png]({{ site.url }}/assets/ctd_trim_fig_2.png)

# References and resources

1. Shiny website: [http://shiny.rstudio.com](http://shiny.rstudio.com)

2. Oce website: [https://dankelley.github.io/oce/](https://dankelley.github.io/oce/)   

2. Jekyll source code for this blog entry: [2015-10-18-shiny-ctd-trim.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2015-10-18-shiny-ctd-trim.Rmd)

