#Variogram and Kriging Surface for Rainfall Intensity 
 
#Spherical Model 
library(gstat) 
 
library(sp) 
 
sample <-   read.table(     "data/rain.txt",     header = T   ) 
 
# and convert to sp object spat.samp <- sample coordinates(spat.samp) <- c('x', 'y') 
 
# construct a grid of locations to predict at grid <- expand.grid(x = seq(-160000, 120000, 1000), y = seq(-160000, 120000, 1000)) plot(grid) spat.grid <- grid 
 
# convert grid to a SpatialPoints object coordinates(spat.grid) <- c('x', 'y') 
 
# and tell sp that this is a grid gridded(spat.grid) <- T 
 
#variogram variog1<- variogram(z~1, locations=~x+y, data=sample) variog1 <- variogram(z~1, locations=~x+y, Cressie=TRUE,                       data=sample) variog2 <- variogram(z~1, locations=~x+y,                       boundaries=c(0,1,2,3,4,5,6,7,8,9), data=sample) 
 
model.variog <- vgm(psill=NA, model="Sph", nugget=NA, range=NA) print(fit.variog <- fit.variogram(variog1, model.variog)) plot(variog1, model = fit.variog,pch=20,col="red" ) 
 
 
RainOKrig= krige(z~1, spat.samp, spat.grid, model=fit.variog) 
 
plot(RainOKrig) 
 
 
