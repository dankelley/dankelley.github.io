# http://www.r-bloggers.com/creating-jekyll-blog-posts-from-r/

mysite <- "http://dankelley.github.io/"
knitPost <- function(input, base.url=mysite, ...)
{
    require(knitr)
    opts_knit$set(base.url = base.url)
    fig.path <- paste0("figs/", sub(".Rmd$", "", basename(input)), "_")
    opts_chunk$set(fig.path = fig.path)
    opts_chunk$set(fig.cap = "center")
    render_jekyll(extra="linenos=table")
    knit(input, envir = parent.frame())
    purl(input, ...)
}
