silent.require <- function(x) suppressMessages(require(package=x, character.only=TRUE, quietly=TRUE))

# Load packages that are already installed
packages <- c("rstan",
              "zeallot", #src/clean-gadm.R (and because Will likes it)
              "raster", "sp", "lubridate", "rgeos", "RColorBrewer", "abind", # worldclim and gadm cleaning
              "devtools", # to install GitHub packages (like Lorenzo's)
              "matrixStats","data.table","gdata","dplyr","tidyr","EnvStats","scales","tidyverse","dplyr","abind","ggplot2","gridExtra","ggpubr","bayesplot","cowplot","optparse", "lubridate", "zoo", "ggstance", "geofacet", "denstrip", "svglite", "forecast", # Imperial models
              "ape", "caper", "phytools" # Phylogenetics
              )

ready <- sapply(packages, silent.require)


# Install missing packages
for(i in seq_along(ready))
    if(!ready[i])
        install.packages(packages[i], quietly=TRUE, dependencies=TRUE)

# Error out if not all packages installed
ready <- sapply(packages, silent.require)
if(any(!ready))
    stop("Cannot install packages", ready[!ready])

# GitHub packages
if(!silent.require("DENVfoiMap")){
    install_github("lorecatta/DENVfoiMap", upgrade=FALSE)
    if(!silent.require("DENVfoiMap"))
        stop("Cannot install DENVfoiMap")
}
if(!silent.require("velox")){ # src/clean-gadm.R and src/worldclim.R
    install_github("hunzikp/velox", upgrade=FALSE)
    if(!silent.require("velox"))
        stop("Cannot install velox")
}