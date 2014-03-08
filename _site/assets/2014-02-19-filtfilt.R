
## ------------------------------------------------------------------------
ab <- signal::butter(3, 0.1)
t <- seq(0, 1, 0.01)
x <- scan("x.dat")
## below could be extracted to a function when working
a <- ab$a
b <- ab$b
na <- length(a)
nb <- length(b)
kdc <- sum(b) / sum(a)
if (!is.nan(kdc)) {
  si <- rev(cumsum(rev(b - kdc * a)))
} else {
  si <- rep(0, length(a))
}
lx <- length(x)
si <- si[-1]
nx <- length(x)
n <- max(na, nb)
lrefl <- 3 * (n - 1)
if (na < n)
    a <- c(a, rep(0, length.out=n-na))
if (nb < n)
    b <- c(b, rep(0, length.out=n-nb))
v <- c(2*x[1]-x[seq.int(lrefl+1,2,-1)],
           x,
           2*x[nx]-x[seq.int(nx-1,nx-lrefl,-1)])
v_before_first_filter <- v[1:4]

#v <- signal::filter(b, a, v, init.x=si*v[1])    # forward filter (WRONG OUTPUT)
si_v1 <- si * v[1]
#v <- signal::filter(b, a, v, init=si*v[1])    # forward filter (WRONG OUTPUT)
#v <- signal::filter(b, a, v, init.x=si*v[1])    # forward filter (WRONG OUTPUT)
#v <- signal::filter(b, a, v, init.y=si*v[1])    # forward filter (WRONG OUTPUT)
#v <- signal::filter(b, a, v, init.x=si*v[1])    # forward filter (WRONG OUTPUT)
v <- stats::filter(b, a, v, init=si*v[1])    # forward filter (WRONG OUTPUT)
v_after_first_filter <- v[1:4]

si_vend <- si*v[length(v)]
v <- rev(signal::filter(b,a,rev(v),init.x=si*v[length(v)]))  # reverse filter
v_after_first_filter <- v[1:4]
y <- v[seq.int(lrefl+1, lx+lrefl)]
plot(t, x, type='l')
lines(t, y, col='red')



