## ----eval=FALSE---------------------------------------------------------------
## library(ggplot2)
## d <- data.frame(x=rnorm(1e8))
## system.time(hist(x))


## ----echo=FALSE---------------------------------------------------------------
system.time({p<-ggplot(d) + aes(x=x) + geom_histogram();print(p)})

