#Variogram and Kriging Surface for Lead Concentration 
 
#Gaussian Model 
library(gstat) 
 
library(sp) 
 
sample <-   read.table(     "data/pbcon.txt",     header = T   ) 
 
# and convert to sp object spat.samp <- sample coordinates(spat.samp) <- c('x', 'y') 
 
# construct a grid of locations to predict at grid <- expand.grid(x=seq(min(sample[,1], na.rm=T),max(sample[,1], na.rm=T), 0.001), y=seq(min(sample[,2], na.rm=T),max(sample[,2], na.rm=T), 0.001)) 
 
plot(grid) spat.grid <- grid 
 
# convert grid to a SpatialPoints object coordinates(spat.grid) <- c('x', 'y') 
 
# and tell sp that this is a grid gridded(spat.grid) <- T 
 
#variogram variog1<- variogram(Pb~1, locations=~x+y, data=sample) variog1 <- variogram(Pb~1, locations=~x+y, Cressie=TRUE,                       data=sample) variog2 <- variogram(Pb~1, locations=~x+y,                       boundaries=c(0,1,2,3,4,5,6,7,8,9), data=sample) 
 
model.variog <- vgm(psill=500, model="Gau", nugget=50, range=0.25) print(fit.variog <- fit.variogram(variog1, model.variog)) plot(variog1, model = fit.variog,pch=20,col="darkblue",main="Gaussian Model" ) 
 
LeadOKrig= krige(Pb~1, spat.samp, spat.grid, model=fit.variog) 
 
plot(LeadOKrig, main="Gaussian Surface by Kriging") 