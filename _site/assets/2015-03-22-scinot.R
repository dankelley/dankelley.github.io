
## ------------------------------------------------------------------------
woa <- function(x, a=1) 8 * a^3 / (x^2 + 4*a^2)
integrate(woa, -Inf, Inf)


## ------------------------------------------------------------------------
estimate <- integrate(woa, -Inf, Inf)$value
theory <- 4 * pi


## ------------------------------------------------------------------------
scinot <- function(x, digits=2, showDollar=FALSE)
{
    sign <- ""
    if (x < 0) {
        sign <- "-"
        x <- -x
    }
    exponent <- floor(log10(x))
    if (exponent) {
        xx <- round(x / 10^exponent, digits=digits)
        e <- paste("\\\\times 10^{", as.integer(exponent), "}", sep="")
    } else {
        xx <- round(x, digits=digits)
        e <- ""
    }
    if (showDollar) paste("$", sign, xx, e, "$", sep="")
    else paste(sign, xx, e, sep="")
}


