
## ------------------------------------------------------------------------
period <- 10
fc <- 1 / period
fs <- 1
n <- 200
t <- 1:n
AMP <- 1 + sin(0.5 * fc * t)
PH  <- 50 * t / max(t)
noise <- rnorm(n, sd=0.5)
signal <- AMP * sin(2 * pi * fc * t + PH*pi/180)
x <- signal + noise


## ----demodulation-signal, fig.height=4, dpi=100--------------------------
xc <- x * cos(2 * pi * fc * t)
xs <- x * sin(2 * pi * fc * t)
par(mar=c(1.75,3,1/2,1), mgp=c(2, 0.7, 0), mfcol=c(3,1))
plot(t, x, type='l')
plot(t, cos(2 * pi * fc * t), type='l')
plot(t, xc, type='l')


## ------------------------------------------------------------------------
w <- 2 * fc / fs
## Here, we use more smoothing
w <- w / 5
filter <- signal::butter(5, w)    # FIXME: why extras on w?
xcs <- signal::filtfilt(filter, xc)
xss <- signal::filtfilt(filter, xs)
amp <- 2 * sqrt(xcs^2 + xss^2)
phase <- 180 / pi * atan2(xcs, xss)


## ----demodulation-results, fig.height=4, dpi=100-------------------------
par(mar=c(1.75,3,1/2,1), mgp=c(2, 0.7, 0), mfcol=c(3,1))
plot(t, AMP, type='l')
lines(t, amp, col='red')

plot(t, phase, type='l')
lines(t, PH, col='red')
plot(t, x, type='l', pch=20)
lines(t, amp * sin(2 * pi * fc * t + phase*pi/180), col='red')


