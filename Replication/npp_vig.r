library(spEDM)

npp = terra::rast(system.file("case/npp.tif", package = "spEDM"))
npp

# Inspect NA values
terra::global(npp,"isNA")
terra::ncell(npp)
nnamat = terra::as.matrix(npp[[1]], wide = TRUE)
nnaindice = which(!is.na(nnamat), arr.ind = TRUE)
dim(nnaindice)

# Select 1500 non-NA pixels to predict:
set.seed(2025)
indices = sample(nrow(nnaindice), size = 1500, replace = FALSE)
libindice = nnaindice[-indices,]
predindice = nnaindice[indices,]

s1 = simplex(npp, "pre", "pre", E = 2:5, k = 3:8, style = 0, tau = 1, stack = TRUE, 
             lib = nnaindice, pred = predindice, dist.metric = "L1", dist.average = FALSE)
s2 = simplex(npp, "npp", "npp", E = 2:10, k = 3:8, style = 0, tau = 1, stack = TRUE, 
             lib = nnaindice, pred = predindice, dist.metric = "L1", dist.average = FALSE)