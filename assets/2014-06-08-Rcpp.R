
## ------------------------------------------------------------------------
library(Rcpp)
library(microbenchmark)
cppFunction('
            int firstZero(IntegerVector x) {
                int nx = x.size();
                for (int i = 0; i < nx; ++i) {
                    if (0 == x[i]) {
                        return i+1;
                    }
                }
                return 0; // means none found
            }'
            )
x <- rep(1, 10000)
x[seq.int(500, 10000)] <- 0
microbenchmark(firstZero(x), times=1000L)
microbenchmark(which(0==x)[1], times=1000L)


