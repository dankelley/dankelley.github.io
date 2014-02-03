## Data digitized from Fig 1b of smith1990gwcc.  The aspline() method
## apparently derives from akima1970anmo.

distance <- c(23.17400, 25.09559, 31.15092, 40.75568,
              46.42938, 124.68628, 132.20556, 136.81277,
              141.37564, 145.08263, 149.38977)
topography <- c(-98.99976, -97.44730, -100.15198, -98.66016,
                -98.66016, -193.94266, -296.89045, -392.63991,
                -493.85330, -591.21586, -692.82951)
if (!interactive()) png("splines.png", width=7, height=4, unit="in", res=150, pointsize=8)
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(distance, topography, ylim=c(-700, 0), pch=16)
grid()
d <- seq(min(distance), max(distance), length.out=100)
s <- smooth.spline(topography ~ distance)
ps <- predict(s, d)
lines(ps$x, ps$y)

d2 <- seq(min(distance), max(distance), median(diff(distance)))
approx <- approx(distance, topography, d2)

library(akima)
akima <- aspline(distance, topography, d)
lines(akima$x, akima$y, col='red')
legend("bottomleft", lwd=par('lwd'), bg='white',
       col=c("black", "red"),
       legend=c("smooth.spline", "aspline"))

if (!interactive()) dev.off()

## Citations
##
## @article{smith1990gwcc,
## 	Author = {W. H. F. Smith and P. Wessel},
## 	Journal = {Geophysics},
## 	Number = {3},
## 	Pages = {293-305},
## 	Title = {Gridding with continuous curvature splines in tension},
## 	Volume = {55},
## 	Year = {1990}}
##
## @article{akima19870anmo,
## 	Author = {Hiroshi Akima},
## 	Journal = {Journal of the Association for Computing Machinery},
## 	Number = {4},
## 	Pages = {589-602},
## 	Title = {A new meethod of interpolation and smooth curve fitting based on local procedures},
## 	Volume = {17},
## 	Year = {1970}}
## 

