---
layout: post
title: Installing WebTide in OSX
tags: [oceanography, tides]
category: R
year: 2013
month: 12
day: 29
summary: Instructions are given for installing WebTide on Apple OSX computers.
description: Instructions are given for installing WebTide on Apple OSX computers.
---

This blog item explains how to install WebTide, a tidal prediction application, on an OSX machine. The work requires moderate expertise, being carried out in the console, and requiring that a C compiler be found on the host machine.

# Introduction

WebTide comes with a friendly graphical user interface that makes it easy to get tidal predictions at various locations around the world.  Anyone with an interest in oceanography is likely to find it a useful application.  Although the interface is slightly quirky (particularly for map navigation), it only takes a few minutes to learn.  (An upcoming blog entry will explain how to avoid the WebTide interface, using the ``oce`` R package to access the data that underly WebTide.)

# Installation


Step 1. Download the "linux without Java VM" version from the [Bedford Institute of Oceanography](http://www.bio.gc.ca/science/research-recherche/ocean/webtide/index-eng.php) website, and store the results in the ``~/Downloads`` directory.

Step 2. Open a terminal or console window, and type the following to enter the WebTide directory and start the process of installing WebTide.
{% highlight bash %}
cd ~/Downloads
sh WebTide_unix_0_7.sh
{% endhighlight %}
After a moment, a dialog box will pop up, asking where WebTide is to be installed. To install a version just for you, supply ``/Users/USERNAME/WebTide``, where ``USERNAME`` is your username. To install a version for all accounts on the computer, use the default, which is ``/usr/local/WebTide``. A second dialog box addresses the issue of symlinks. Click the box indicating that these are not to be used. After a few moments, a final dialog box will appear, stating that the work has been completed. Click the button named ``Finish``.

Step 3. Now for the OSX-specific part of the work. You will need the gcc compiler to do this. It is available for free on the Apple website, as the Xcode development tools. (If you have been using the computer for science, it is quite likely you have already installed a  compiler, so just try the steps below, before bothering with a re-install of Xcode.) In a console, type the following to enter the source directory (here assumed to be configured for a single user) and to compile two programs.
{% highlight bash %}
cd ~/WebTide/Tidecor_src
gcc -O2 -o tidecor webtidecor2.5.1.c -lm
gcc -O2 -o constituentinterpolator constituentinterpolator1.1.c -lm
{% endhighlight %}
In the two ``gcc`` lines shown above, it may be necessary to change the names of the ``".c"`` files, to match whatever you find in this ``tidecor_src`` directory. You may ignore the warning messages that are likely to appear, but if errors appear, you will need to interrupt this tutorial to find out what is wrong.  Possibly leaving a comment on this site would encourage another reader to offer a solution; possibly the scientists at the Bedford Institute of Oceanography (named on the website) could help.

Step 4. Move these newly-compiled programs from the source directory into the bin directory, by typing
{% highlight bash %}
mv tidecor ../bin
mv constituentinterpolator ../bin
{% endhighlight %}

# Using WebTide

If you installed WebTide to your home directory, launch WebTide by typing the following in a console window
{% highlight bash %}
~/WebTide/WebTide
{% endhighlight %}
and use the GUI from that point on. If you installed it to ``/usr/local/WebTide``, type the following instead
{% highlight bash %}
/usr/local/WebTide/WebTide
{% endhighlight %}

The main WebTide window looks like the following.

[![graph]({{ site.url }}/assets/webtideosx1-thumbnail.png)]({{ site.url }}/assets/webtideosx1.png)


There is little point in explaining the details of the menu and mouse actions here, since WebTide provides its own documentation.  In most cases, the action will be to click the mouse on spot on the map, to set a so-called "marker" for a location at which calculations are to be done.  The diagram shown here has a marker in the Bay of Fundy.  Once a marker has been set, the user may wish to click a menu item (see at the right-hand side) to get a tidal prediction, as shown in the screenshot below.


[![graph]({{ site.url }}/assets/webtideosx2-thumbnail.png)]({{ site.url }}/assets/webtideosx2.png)
