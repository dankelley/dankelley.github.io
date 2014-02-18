
## ------------------------------------------------------------------------
x <- rnorm(100) + sin((1:100)*2*pi/20)
ab <- signal::butter(2, 0.1)
a <- ab$a
b <- ab$b
kdc <- sum(b) / sum(a);
if (!is.nan(kdc)) {
  si <- rev(cumsum(rev(b - kdc * a)))
} else {
  si <- rep(0, length(a))
}
lx <- length(x)
si <- si[-1]
nx <- length(x)
n <- max(length(a), length(b))
lrefl <- 3 * (n - 1)
v <- cbind(c(2*x[1]-x[seq(lrefl+1,2,-1)]),
           x,
           c(2*x[nx]-x[seq(nx-1,nx-lrefl,-1)]))
v <- signal::filter(b,a,v,si*v[1])     # forward filter
v <- rev(signal::filter(b,a,rev(v),si*v[nx]))  # reverse filter
y <- v[seq.int(lrefl+1, lx+lrefl)]
t <- seq_along(x)
plot(t, x, type='l')
lines(t, y, col='red')
#
#  v = [2*x(1)-x((lrefl+1):-1:2); x(:);
#       2*x(end)-x((end-1):-1:end-lrefl)]; # a column vector
#
#  ## Do forward and reverse filtering
#  v = filter(b,a,v,si*v(1));                   # forward filter
#  v = flipud(filter(b,a,flipud(v),si*v(end))); # reverse filter
#  y(:) = v((lrefl+1):(lx+lrefl));


