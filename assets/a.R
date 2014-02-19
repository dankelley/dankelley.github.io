set.seed(123)
ab <- signal::butter(3, 0.1)
t <- seq(0, 1, 0.01)
x <- sin(2*pi*t*2.3)+0.25*rnorm(length(t))
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
cat("si:", si, "\n")
cat("lrefl:", lrefl, "\n")
if (na < n)
    a <- c(a, rep(0, length.out=n-na))
if (nb < n)
    b <- c(b, rep(0, length.out=n-nb))
v <- c(2*x[1]-x[seq.int(lrefl+1,2,-1)],
           x,
           2*x[nx]-x[seq.int(nx-1,nx-lrefl,-1)])
cat("si*v[1]:15]:", si*v[1], "\n")
cat("v[1:15] before first filter:", v[1:15], "\n")

#v <- signal::filter(filt=b, a=a, x=v, init=si*v[1])    # forward filter (WRONG OUTPUT)
v <- signal::filter(ab, x=v, init.x=si*v[1])    # forward filter (WRONG OUTPUT)
#v <- signal::filter(b,a,v,init=si*v[1])     # forward filter (WRONG OUTPUT)
#v <- signal::filter(b,a,v, init.x=si*v[1])     # forward filter (WRONG OUTPUT)
#v <- signal::filter(b,a,v, init.y=si*v[1])     # forward filter (WRONG OUTPUT)
cat("v[1:15] after first filter:", v[1:15], "\n")

stop()
v <- rev(signal::filter(b,a,rev(v),si*v[nx]))  # reverse filter
y <- v[seq.int(lrefl+1, lx+lrefl)]
plot(t, x, type='l')
lines(t, y, col='red')

