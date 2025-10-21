setwd("E:\\Study\\R\\spatial-causality")


library(rgdal)
library(raster)



HMs<-c("Cd","Cu","Mg","Pb")
Envs<-c("nlights03","dTRI")


for(h in 1:length(HMs))
{
  for(e in 1:length(Envs))
  {
    xImage<-readGDAL(paste(HMs[h],".tif",sep = ""))
    yImage<-readGDAL(paste(Envs[e],".tif",sep = ""))
    
    xMatrix<-as.matrix(xImage)
    yMatrix<-as.matrix(yImage)
    
    
    lib_sizes<-seq(10,120,20)
    E<-3
    lib<-NULL
    # pred<-
    
    imageSize<-dim(xMatrix)
    totalRow<-imageSize[1]
    totalCol<-imageSize[2]
    predRows<-seq(5,totalRow,5)
    predCols<-seq(5,totalCol,5)
    
    pred<-merge(predRows,predCols)
    
    pred_indices <- rep.int(FALSE, times = totalRow*totalCol)
    lib_indices<- rep.int(FALSE, times = totalRow*totalCol)
    
    pred_indices[locate(pred[,1],pred[,2],totalRow,totalCol) ]<-TRUE
    
    yUsed<- as.array(t(yMatrix))[pred_indices]
    
    xUsed<- as.array(t(xMatrix))[pred_indices]
    
    print(c(HMs[h],Envs[e]))
    
    print(cor.test(yUsed,xUsed))
  }
}







