## ------------------------------------------------------------------------
par(mar=rep(0, 4))
plot(0:5, 0:5, xlab="", ylab="", axes=FALSE, type='n')

## Simple method
text(1, 1, expression("A ["*m/s^2*"]"))

## Unit stored in an expression: naive approach.
u <- expression(m/s^2)
text(1, 2, bquote("B ["*.(u)*"]"))

## Unit stored in an expression: note the [[1]] selection!
text(1, 3, bquote("C ["*.(u[[1]])*"]"))

## Unit stored in an oce-formatted list
U <- list(unit=expression(m/s^2), scale="")
text(1, 4, bquote("D ["*.(U[[1]][[1]])*"]"))

