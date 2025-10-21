c(climateImages,list(nppImage)) -> a
pre = terra::rast(climateImages[[1]])
tem = terra::rast(climateImages[[2]])
npp2 = terra::rast(nppImage)

npp_gccm = c(pre,tem,npp2)
names(npp_gccm) = c("pre","tem","npp")
terra::writeRaster(npp_gccm,"./npp.tif")
terra::ext(npp_gccm) = c(-0.5,552.5,-0.5,484.5)

terra::trans(npp_gccm) |> 
  terra::plot()


a = terra::as.data.frame(npp_gccm,xy = TRUE,na.rm = T)