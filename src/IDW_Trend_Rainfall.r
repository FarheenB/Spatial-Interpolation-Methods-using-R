#IDW and Trend Surface for Rainfall Intensity 
 
library(gstat) 
 
library(sp) 
 
sample <-   read.table(     "data/rain.txt",     header = T   ) 
 
# and convert to sp object spat.samp <- sample coordinates(spat.samp) <- c('x', 'y') 
 
# construct a grid of locations to predict at grid <- expand.grid(x = seq(-160000, 120000, 1000), y = seq(-160000, 120000, 1000)) plot(grid) spat.grid <- grid 
 
# convert grid to a SpatialPoints object coordinates(spat.grid) <- c('x', 'y') 
 
# and tell sp that this is a grid gridded(spat.grid) <- T library(gstat) sampinterp.idw <-   gstat::idw(formula = z ~ 1,              locations = spat.samp,              newdata = spat.grid) 
 
# first argument is a formula. #   left hand side is the response variable #   right hand side specifies the trend model variables #   for idw, r.h.s. MUST be ~1, i.e. constant mean # second is the spatial data set from which to get the obs. # third is the set of locations at which to predict 
 
# result is an spatial object with coordinates and two data columns: #  var1.pred: the predictions for variable 1 (z here) #  var1.var: the prediction variance.  Not computed for idw 
 
sampinterp.idw@data$var1.pred # or, if predicting on a grid, can use bubble or spplot to plot the gridded values spplot(sampinterp.idw, 'var1.pred') # default power is 2, can change by specifying idp in call to idw #power 1 sampinterp1.idw1 <-   gstat::idw(     formula = z ~ 1,     locations = spat.samp,     newdata = spat.grid,     idp = 1   ) 
 
spplot(sampinterp1.idw1, 'var1.pred') 
 
 
# power 2-- default same as sampinterp.idw,  sampinterp1.idw2 <-   gstat::idw(     formula = z ~ 1,     locations = spat.samp, 
    newdata = spat.grid,     idp = 2   ) 
 
spplot(sampinterp1.idw2, 'var1.pred') 
 
# power 5,  sampinterp1.idw5 <-   gstat::idw(     formula = z ~ 1,     locations = spat.samp,     newdata = spat.grid,     idp = 5   ) 
 
spplot(sampinterp1.idw5, 'var1.pred') 
 
# power 10,  sampinterp1.idw10 <-   gstat::idw(     formula = z ~ 1,     locations = spat.samp,     newdata = spat.grid,     idp = 10   ) 
 
spplot(sampinterp1.idw10, 'var1.pred') 
 
# compare to previous spplot plot 
 
# Trend surface sample.lm <- lm(formula=z ~ x + y, data=spat.samp) sample.lmq <- lm(formula= z ~ x + y + I(x^2) + I(y^2) + I(x*y), data=spat.samp) sample.ts <- predict(sample.lm, newdata=spat.grid) sample.tsq <- predict(sample.lmq, newdata=spat.grid) spat.grid<- SpatialPixelsDataFrame(spat.grid, data.frame(ts=sample.ts, tsq=sample.tsq) ) spplot(spat.grid, 'ts') spplot(spat.grid, 'tsq') 
 
 