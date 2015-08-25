## ------------------------------------------------------------------------
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
space <- 0.2 # adjust as necessary
plot(t, 1:n, type='n', xlab="", ylab="Email", xlim=c(min(t), max(t)+space*timeSpan), ylim=c(0, n+1))
tl <- max(t) + 0.5 * space * timeSpan
for (i in 1:n) {
    text(tl + 0.05 * space * timeSpan, i, paste(from[i], "-", to[i], sep=""), pos=4)
    lines(c(tl, t[i]), rep(i, 2))
    lines(c(t[i], t[i]), c(i, 0))
}


