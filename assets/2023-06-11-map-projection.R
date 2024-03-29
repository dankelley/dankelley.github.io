## ----eval=FALSE---------------------------------------------------------------
## proj -l       # list names of all projections


## ----eval=FALSE---------------------------------------------------------------
## proj -l=ccon  # list info on ccon


## ----echo=FALSE---------------------------------------------------------------
# Oce projections tested in previous blog postings.
oceTest <- c(
"aea +lat_1=10 +lat_2=60 +lon_0=-40",
"aeqd +lon_0=-45",
"aitoff +lon_0=-45",
"bipc",
"bonne +lat_1=45",
"cass +lon_0=-45",
"cass +lon_0=-45",
"cc",
"cea",
"collg",
"crast",
"eck1",
"eck2",
"eck3",
"eck4",
"eck5",
"eck6",
"eqc",
"eqearth",
"euler +lat_1=45 +lat_2=50 +lon_0=-40",
"etmerc +ellps=WGS84 +lon_0=-40",
"etmerc +ellps=WGS84 +lon_0=-40",
"fahey",
"fouc",
"fouc_s",
"gall",
"geos +h=1e8",
"gn_sinu +n=6 +m=3",
"gnom +lon_0=-40",
"goode",
"hatano",
#"healpix +a=1",
#"rhealpix +south_square=0 +north_square=1",
"igh",
"kav5",
"kav7",
"laea +lon_0=-40",
"longlat",
"latlong",
"lcc +lat_1=30 +lat_2=70 +lon_0=-40",
"leac +lon_0=-40",
"loxim",
"mbt_s",
"mbt_fps",
"mbtfpp",
"mbtfpq",
"mbtfps",
"merc",
"mil_os",
"mill",
"moll",
"murd1 +lat_1=30 +lat_2=60 +lon_0=-40",
"murd2 +lat_1=30 +lat_2=60 +lon_0=-40",
"murd3 +lat_1=30 +lat_2=60 +lon_0=-40",
"natearth",
"nell",
"nell_h",
"nsper +h=90000000",
#ob_tran", # fails so badly that try() cannot get us past the failure
"ocea",
"omerc +lat_1=30 +lon_1=-40 +lat_2=60",
"ortho",
"pconic +lat_1=20 +lat_2=60 +lon_0=-40",
"poly +lon_0=-40",
"putp1",
"putp2",
"putp3",
"putp5",
"putp6",
"putp3p",
"putp5p",
"putp6p",
"qua_aut",
"qsc +lon_0=-100",
"robin",
"rouss +lon_0=-40",
"sinu",
"stere +lat_0=90",
"sterea +lat_0=90",
"tcea +lon_0=-40",
"tissot +lat_1=20 +lat_2=60 +lon_0=-40",
"tmerc +lon_0=-40 +lat_1=30 +lat_2=60",
"tpeqd +lat_1=30 +lon_1=-80",
"tpers +h=1e8",
"ups +ellps=WGS84",
"urmfps +n=0.9",
"utm +zone=25 +ellps=WGS84 +lon_0=-40",
"vandg",
"vitk1 +lat_1=20 +lat_2=60 +lon_0=-40",
"wag1",
"wag2",
"wag3",
"wag4",
"wag5",
"wag6",
"weren",
"wink1",
"wintri")
oceTest <- paste0("+proj=", oceTest)


## ----echo=FALSE---------------------------------------------------------------
# proj projections from 'proj -l', after omitting things that are not projections, e.g. shift operators.
projTest <- c(
"aea +lat_1=10 +lat_2=60 +lon_0=-40",
"aeqd",
"affine",
"airy",
"aitoff",
"alsk",
"apian",
"august",
#"axisswap",                           # not a projection
"bacon",
"bertin1953",
"bipc",
"boggs",
"bonne +lat_1=45",
"calcofi",
"cart",
"cass",
"cc",
"ccon +lat_1=45",
"cea",
"chamb +lat_1=10 +lon_1=30 +lon_2=40", # https://proj.org/operations/projections/chamb.html
"collg",
"comill",
"crast",
#"deformation",                        # not a projection
"denoy",
"eck1",
"eck2",
"eck3",
"eck4",
"eck5",
"eck6",
## fails 2020-08-02 ## "eqearth",
"eqc",
"eqdc +lat_1=55 +lat_2=60",            # https://proj.org/operations/projections/eqdc.html
"eqearth",
"euler +lat_1=67 +lat_2=75",           # https://proj.org/operations/projections/euler.html
"etmerc",
"fahey",
"fouc",
"fouc_s",
"gall",
## fails 2020-08-02 ## "geoc",
"geogoffset",
"geos +h=1e8",
"gins8",
"gn_sinu +n=6 +m=3",
"gnom",
"goode",
"gs48",
"gs50",
"hammer",
"hatano",
## fails 2020-08-02 ## "healpix",
## fails 2020-08-02 ## "rhealpix",
## fails 2020-08-02 ## "helmert",
#"hgridshift",                         # not a projection
#"horner",                             # not a projection
"igh",
"imw_p +lat_1=30 +lat_2=-40",
"isea",
"kav5",
"kav7",
"krovak",
"labrd +lon_0=40 +lat_0=-10",
"laea",
"lagrng",
"larr",
"lask",
"lonlat",
"latlon",
"lcc +lat_1=30 +lat_2=70 +lon_0=-40",
"lcca +lat_0=35",
"leac",
"lee_os",
"loxim",
"lsat +lat_1=-60 +lat_2=60 +lsat=2 +path=2",
"mbt_s",
"mbt_fps",
"mbtfpp",
"mbtfpq",
"mbtfps",
"merc",
"mil_os",
"mill",
"misrsom +path=1",                     # https://proj.org/operations/projections/misrsom.html
"moll",
#"molobadekas",                        # not a projection
#"molodensky",                         # not a projection
"murd1 +lat_1=30 +lat_2=60 +lon_0=-40",
"murd2 +lat_1=30 +lat_2=60 +lon_0=-40",
"murd3 +lat_1=30 +lat_2=60 +lon_0=-40",
"natearth",
"natearth2",
"nell",
"nell_h",
"nicol",
"nsper +h=90000000",
"nzmg",
"noop",
#"ob_tran",                            # fails so badly that even try() will not let us get past it
"ocea",
#"oea +m=1 +n=2",                      # https://proj.org/operations/projections/oea.html
"omerc +lat_1=30 +lon_1=-40 +lat_2=60",
"ortel",
"ortho",
"pconic +lat_1=20 +lat_2=60 +lon_0=-40",
"patterson",
#"pipeline",                           # not a projection
"poly +lon_0=-40",
"pop",
"push",
"putp1",
"putp2",
"putp3",
"putp3p",
"putp4p",
"putp5",
"putp5p",
"putp6",
"putp6p",
"qua_aut",
"qsc",
"robin",
"rouss",
"rpoly",
#"sch",                                # not a projection
"sinu",
"somerc",
"stere",
"sterea",
"gstmerc",
"tcc",
"tcea",
"times",
"tissot +lat_1=20 +lat_2=60 +lon_0=-40",
"tmerc +lon_0=-40 +lat_1=30 +lat_2=60",
"tobmerc",
"tpeqd +lat_1=60 +lat_2=65",
"tpers +h=1e8",
# "unitconvert",                        # not a projection
"ups +ellps=WGS84",
"urmfps +n=0.9",
"utm",
"vandg",
"vandg2",
"vandg3",
"vandg4",
"vitk1 +lat_1=20 +lat_2=60 +lon_0=-40",
#"vgridshift",                         # not a projection
"wag1",
"wag2",
"wag3",
"wag4",
"wag5",
"wag6",
"wag7",
"webmerc",
"weren",
"wink1",
"wink2",
"wintri")
projTest <- paste0("+proj=", projTest)


## ----echo=FALSE---------------------------------------------------------------
oceName <- gsub("^\\+proj=([a-z_+]*).*$", "\\1", oceTest)
projName <- gsub("^\\+proj=([a-z_+]*).*$", "\\1", projTest)
oceNotInProj <- oceName[!(oceName %in% projName)]
projNotInOce <- projName[!(projName %in% oceName)]


## -----------------------------------------------------------------------------
#options(warn=-1)
zero <- cbind(0, 0)
ll <- sf::st_crs("+proj=longlat")$proj4string
for (projOld in oceTest) {
    cat("projOld '", projOld, "'\n", sep="")
    xy <- try(rgdal::project(zero, projOld), silent=TRUE)
    if (inherits(xy, "try-error")) {
        cat("gdal::project(...,'", projOld, "') failed\n", sep="")
    } else {
        cat("gdal with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
    }
    projNew <- try(sf::st_crs(projOld)$proj4string, silent=TRUE)
    if (inherits(projNew, "try-error")) {
        cat("sf::st_crs(projOld)$proj4string failed\n")
    } else {
        cat("projNew '", projNew, "'\n", sep="")
        cat('  is projNew bad?', inherits(projNew, "try-error"), "\n")
        if (!is.na(projNew)) {
            cat("new:", projNew, "\n")
            xy <- sf::sf_project(ll, projOld, zero)
            if (inherits(xy, "try-error")) {
                cat("sf::sf_project failed with projOld='", projOld, "'\n", sep="")
            } else {
                cat("sf    with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
                xy <- sf::sf_project(ll, projNew, zero)
                if (inherits(xy, "try-error")) {
                    cat("cannot transform projNew='", projNew, "'\n", sep="")
                } else {
                    cat("sf    with new: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
                    xy <- rgdal::project(zero, projNew)
                }
            }
        } else {
            cat("sf::st_crs() cannot handle this string\n")
        }
    }
    cat("\n")
}


## -----------------------------------------------------------------------------
#options(warn=-1)
zero <- cbind(0, 0)
ll <- sf::st_crs("+proj=longlat")$proj4string
for (projOld in projTest) {
    cat("old:", projOld, "\n")
    xy <- try(rgdal::project(zero, projOld), silent=TRUE)
    if (inherits(xy, "try-error")) {
        cat("gdal::project(...,'", projOld, "') failed\n", sep="")
    } else {
        cat("gdal with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
    }
    projNew <- try(sf::st_crs(projOld)$proj4string, silent=TRUE)
    if (!is.na(projNew)) {
        cat("new:", projNew, "\n")
        xy <- sf::sf_project(ll, projOld, zero)
        cat("sf    with old: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- sf::sf_project(ll, projNew, zero)
        cat("sf    with new: (0,0) -> (", xy[1], ",", xy[2], ")\n", sep="")
        xy <- rgdal::project(zero, projNew)
    } else {
        cat("sf::st_crs() cannot handle this string\n")
    }
    cat("\n")
}

