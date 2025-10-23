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

startTime = Sys.time()
npp_res = gccm(data = npp,
               cause = "pre",
               effect = "npp",
               libsizes = matrix(rep(seq(20,400,40),2),ncol = 2),
               E = 3,
               k = 8,
               style = 0,
               tau = 1,
               stack = TRUE,
               lib = nnaindice,
               pred = predindice,
               dist.metric = "L1", 
               dist.average = FALSE,
               win.ratio = 0.2,
               progressbar = FALSE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))
npp_res
npp_res$xmap
readr::write_rds(npp_res,'./npp_res.rds')
plot(npp_res)

s1 = simplex(npp, "pre", "pre", E = 3:5, k = 4:8, style = 0, tau = 1, stack = TRUE, 
             lib = nnaindice, pred = predindice, dist.metric = "L1", dist.average = FALSE)
s1$xmap
s1

s2 = simplex(npp, "npp", "npp", E = 3:5, k = 4:8, style = 0, tau = 1, stack = TRUE, 
             lib = nnaindice, pred = predindice, dist.metric = "L1", dist.average = FALSE)
s2$xmap
s2