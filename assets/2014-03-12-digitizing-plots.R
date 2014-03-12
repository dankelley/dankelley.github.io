
## ------------------------------------------------------------------------
xaxis <- function(values)
{
    n <- length(values)
    message("click on the x axis at places where x=", paste(values, collapse=","), "\n")
    xy <- locator(n)
    m <- lm(values ~ xy$x)
    C <- as.numeric(coef(m))
    xa <<- C[1]
    xb <<- C[2]
}
yaxis <- function(values)
{
    n <- length(values)
    message("click on the y axis at places where x=", paste(values, collapse=","), "\n")
    xy <- locator(n)
    m <- lm(values ~ xy$y)
    C <- as.numeric(coef(m))
    ya <<- C[1]
    yb <<- C[2]
}
topright <- function()
{
    message("click the top-right corner of plot box\n")
    xy <- locator(1)
    xout <<- xy$x
    yout <<- xy$y
}
data <- function(n=100)
{
    message("escape by clicking to right of or above top-right corner of box\n")
    x <- y <- NULL
    i <- 1
    while (TRUE) {
        xy <- locator(1)
        xx <- xa + xb * xy$x 
        yy <- ya + yb * xy$y 
        cat("i=", i, "xy:", xy$x, xy$y, "->", xx, yy, "\n")
        if (xy$x > xout || xy$y > yout) {
            return(list(x=x, y=y))
        }
        x <- c(x, xx)
        y <- c(y, yy)
        i <- i + 1
        if (i > n)
            return(list(x=x, y=y))
    }
}
digitize <- function(image, xaxis, yaxis)
{
    library(png)
    png <- readPNG(image)
    par(mar=rep(0, 4))
    plot(0:1, 0:1, type='n')
    rasterImage(png[,,1], 0, 0, 1, 1)
    xaxis(xaxis)
    yaxis(yaxis)
    topright()
    data()
}


## ----make-data, fig.path='2014-03-12-', fig.height=4, dpi=100------------
set.seed(123)
x <- 1:10
y <- 1 + x + rnorm(10)
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(x, y, type='o')


## ----, eval=FALSE--------------------------------------------------------
## xy <- digitize("sample.png", c(2, 10), c(2, 10))


