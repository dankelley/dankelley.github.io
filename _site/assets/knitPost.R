# http://www.r-bloggers.com/creating-jekyll-blog-posts-from-r/
knitPost <- function(input, base.url = "http://dankelley.github.io/", ...) {
    require(knitr)
    opts_knit$set(base.url = base.url)
    fig.path <- paste0("assets/figs/", sub(".Rmd$", "", basename(input)), "/")
    opts_chunk$set(fig.path = fig.path)
    opts_chunk$set(fig.cap = "center")
    render_jekyll(extra="linenos=table")
    knit(input, envir = parent.frame())
    purl(input, ...)
}
