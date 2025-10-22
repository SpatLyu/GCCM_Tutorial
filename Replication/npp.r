load("./data/npp.RData") 

pre = terra::rast(climateImages[[1]])
tem = terra::rast(climateImages[[2]])
npp = terra::rast(nppImage)
npp = c(pre,tem,npp)
names(npp) = c("pre","tem","npp")

terra::trans(npp) |> 
  terra::plot()

g1 = spEDM::gccm(npp, "pre", "npp", E = 4, k = 6, style = 0, stack = 1,
                 libsize = matrix(rep(300,2), ncol = 2),
                 pred = as.matrix(expand.grid(seq(10,480,10),seq(10,550,10))),
                 dist.metric = "L1", dist.average = F, detrend = T)
g1
g1$xmap

g2 = spEDM::gccm(npp, "tem", "npp", E = 4, k = 6, style = 0, stack = 1,
                 libsize = matrix(rep(300,2), ncol = 2),
                 pred = as.matrix(expand.grid(seq(10,480,10),seq(10,550,10))),
                 dist.metric = "L1", dist.average = F, detrend = T)
g2
g2$xmap