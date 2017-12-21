## ------------------------------------------------------------------------
## below shows that spectrum() does some tricky things
par(mfrow=c(2, 1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
set.seed(123)
x <- 12:200
## fast=TRUE is the default
speclenT <- unlist(lapply(x, function(n) length(spec.pgram(rnorm(n),plot=FALSE,fast=TRUE)$freq)))
plot(x, speclenT, type="s", xlab="x length", ylab="spectrum length")
legend("topleft", lwd=par("lwd"), col=1:2, legend=c("spectrum() with fast=TRUE", "2:1 line"))
abline(0, 1/2, col=2)
speclenF <- unlist(lapply(x, function(n) length(spec.pgram(rnorm(n),plot=FALSE,fast=FALSE)$freq)))
plot(x, speclenF, type="s", xlab="x length", ylab="spectrum length")
legend("topleft", lwd=par("lwd"), col=1:2, legend=c("spectrum() with fast=FALSE", "2:1 line"))
abline(0, 1/2, col=2)
print(head(speclenT))
print(head(speclenF))
all.equal(speclenF, floor(x/2))

