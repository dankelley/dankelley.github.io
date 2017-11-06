library(oce)
datasets <-  c("adv", "adp", "cm", "ctd", "argo", "lisst", "lobo", "sealevel", "section")
languages <- c("en", "es", "de", "fr", "zh")
for (d in datasets) {
    data(list=d)
    if (d == "section")
        section <- sectionGrid(section)
    for (l in languages) {
        pdf(paste(d, "-", l, ".pdf", sep=""), family=if (l=="zh") "GB1" else "Helvetica")
        Sys.setenv(LANGUAGE=l)
        plot(get(d))
        dev.off()
    }
}

