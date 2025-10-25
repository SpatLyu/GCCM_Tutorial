load("./data/npp.RData") 

pre = terra::rast(climateImages[[1]])
tem = terra::rast(climateImages[[2]])
npp = terra::rast(nppImage)
npp = c(pre,tem,npp)
names(npp) = c("pre","tem","npp")

terra::trans(npp) |> 
  terra::plot()

# terra::writeRaster(npp,'./data/npp.tif',overwrite = TRUE)
npp = terra::rast('./data/npp.tif')

g1 = spEDM::gccm(npp, "pre", "npp", libsizes = matrix(rep(seq(20,550,40),2), ncol = 2), E = 3, k = 5, style = 0, stack = T, 
                 pred = as.matrix(expand.grid(seq(10,480,10),seq(10,550,10))),
                 dist.metric = "L1", dist.average = F, win.ratio = 0.2, detrend = T, grid.coord = F)
g1
g1$xmap
plot(g1)

g2 = spEDM::gccm(npp, "tem", "npp", libsizes = matrix(rep(seq(20,550,40),2), ncol = 2), E = 4, k = 6, style = 0, stack = T,
                 pred = as.matrix(expand.grid(seq(10,480,10),seq(10,550,10))), 
                 dist.metric = "L1", dist.average = F, win.ratio = 0.2, detrend = T, grid.coord = F)
g2
g2$xmap
plot(g2)