<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An Introduction to the hysteresis package}
-->

Hysteresis
========================================================
An R package for fitting rate-dependent hysteretic loops
-------------------------------------
Hysteresis loops occur when an output variable can have multiple possible values at one input value depending on the history of the system and the direction of change in the input. This package contains functions to simulate, fit, and obtain parameter values along with their standard errors (Yang and Parkhurst) from hysteresis loops of the form
$$x_{t}=b_{x}cos(2t\pi/T+\phi)+c_{x}+e_{x,t}$$
$$y_{t}=b_{y}*cos(2t\pi/T+\phi)^{n}+R*sin(2t\pi/T+\phi)^{m}+c_{y}+e_{y,t}$$

where e is a random error term. These generalized transcendental equations (Lapshin) form a hysteresis loop for a given frequency or period and set of time points t=1,2...n.

The plot below uses the function **mloop** which simulates hysteresis loops to show the effects of choosing various odd values for n and m.

```r
library(knitr)
library(hysteresis)
par(mfrow=c(3,3),mai=c(0,0.2,0.2,0),ann=FALSE,xaxt="n",yaxt="n",oma=c(0,0,3,0))

for (i in c(1,3,15)){
  for (j in c(1,3,15)){
    obj<-mloop(m=i,n=j,n.points=100,period=99)
    plot(floop(obj$x,obj$y,m=i,n=j,period=99),xlim=c(-0.8,0.8),ylim=c(-0.8,0.8))
    if (i==1) title(paste("n=",j,sep=""))
    if (j==1) title(ylab=paste("m=",i,sep=""),line=0,cex.sub=2)
  }
}
title("Hysteresis Loops for Odd Values of m and n",outer=TRUE)
```

![plot of chunk mandn](figure/mandn-1.png) 

It is also possible to use even values for n.


```r
par(mfrow=c(3,3),mai=c(0,0.2,0.2,0),ann=FALSE,xaxt="n",yaxt="n",oma=c(0,0,3,0))

for (i in c(1,3,15)){
  for (j in c(2,4,16)){
    obj<-mloop(m=i,n=j,n.points=100,period=99)
    plot(floop(obj$x,obj$y,m=i,n=j,period=99),xlim=c(-0.8,0.8),ylim=c(-0.8,0.8))
    if (i==1) title(paste("n=",j,sep=""))
    if (j==2) title(ylab=paste("m=",i,sep=""),line=0,cex.sub=2)
  }
}
title("Hysteresis Loops for Odd Values of m and Even Values of n",outer=TRUE)
```

![plot of chunk moremandn](figure/moremandn-1.png) 
A special case is when n=1 and m=1, this makes the hysteresis loop an ellipse. The centroid of the hysteresis loop is given by cx and cy as shown in the plot below of ellipses.

```r
obj<-mloop(cx=0,cy=0,n.points=100,period=99)
obj2<-mloop(cx=1.5,cy=0,n.points=100,period=99)
obj3<-mloop(cx=0,cy=1.5,n.points=100,period=99)
plot(obj$x,obj$y,type="l",xlim=c(-2,3),ylim=c(-2,3),xlab="x",ylab="y",col="#6600CC",main="Centroid Given by cx and cy")
points(0,0,pch=19,col="#6600CC")
text(x=0,y=0.15,"(cx=0,cy=0)",col="#6600CC")
lines(obj2$x,obj2$y,col="#00FF66")
points(1.5,0,pch=19,col="#00FF66")
text(x=1.5,y=0.15,"(cx=1.5,cy=0)",col="#00FF66")
lines(obj3$x,obj3$y,col="#FF6600")
points(0,1.5,pch=19,col="#FF6600")
text(x=0,y=1.65,"(cx=0,cy=1.5)",col="#FF6600")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) 
The saturation points describe where the direction of the input changes sign. The distances from the central point to the saturation points are given by b.x and b.y (saturation points at ($c_{x} \pm b_{x},c_{y} \pm b_{y}$))

```r
for (i in c(1,2,4)){
  obj<-mloop(b.x=i,n.points=100,period=99)
  plot(obj$x,obj$y,xlim=c(-5,10),ylim=c(-1.4,1.4),type="l",main=paste("b.x=",i,sep=""),xlab="x",ylab="y")
  points(i,0.8,pch=19)
  legend(i,1,legend=c("Saturation Point","x=cx+b.x","y=cy+b.y"),bty="n")
}
```

![plot of chunk bx](figure/bx-1.png) ![plot of chunk bx](figure/bx-2.png) ![plot of chunk bx](figure/bx-3.png) 

```r
for (i in c(0.8,2,4)){
  obj<-mloop(b.y=i,n.points=100,period=99)
  plot(obj$x,obj$y,xlim=c(-1,2),ylim=c(-5,5),type="l",main=paste("b.y=",i,sep=""),xlab="x",ylab="y")
  points(0.6,i,pch=19)
  legend(0.6,i,legend=c("Saturation Point","x=cx+b.x","y=cy+b.y"),bty="n")
}
```

![plot of chunk by](figure/by-1.png) ![plot of chunk by](figure/by-2.png) ![plot of chunk by](figure/by-3.png) 
Retention, or the output split point R, is the vertical distance from center to upper loop trajectory.

```r
for (i in c(1,2,4)){
  obj<-mloop(retention=i,n.points=100,period=99)
  plot(obj$x,obj$y,xlim=c(-1,1),ylim=c(-5,5),type="l",main=paste("retention=",i,sep=""),xlab="x",ylab="y")
  segments(0,0,0,i)
  text(0.3,0.5,"Retention")
}
```

![plot of chunk retention](figure/retention-1.png) ![plot of chunk retention](figure/retention-2.png) ![plot of chunk retention](figure/retention-3.png) 
Finally the phase.angle, $\phi$, changes the location of points along the loop, but does not change the form of the loop itself. When phase.angle is zero, the loop starting point is also the saturation point.

```r
obj<-mloop(retention=0.5,n.points=100,period=99)
  plot(obj$x,obj$y,type="l",xlab="x",ylab="y",main="Starting Points for Different Values of phase.angle",xlim=c(-0.6,0.8))
for (i in c(0,90,180,260)){
  obj2<-mloop(phase.angle=i,retention=0.5,n.points=1,period=99)
  points(obj2$x,obj2$y,pch=19,col="gold",cex=2)
  points(obj2$x,obj2$y,col="gold",cex=4)
  text(obj2$x+.08,obj2$y,round(i,2))
}
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

Fitting Ellipses
----------------------
### The Process

**Hysteresis** contains one method for fitting hysteresis loops given any n and m in the function **floop**. 
In the special case of an ellipse where n=1 and m=1, four methods are available in the function **fel**. 
The two-step simple harmonic regression (harmonic2) method, the default, generally produces estimates that are less 
biased and have lower variances than those produced by the other methods. Since the focus is on rate-dependent hysteresis, 
knowledge of time for the observations is required (or if unknown, times may be assumed to be equally spaced). On the 
other hand, if the objective is solely to fit an ellipse, observation times are not needed for the other three methods.

```r
set.seed(24)
ellipse1 <- mel(method=2,retention=0.4,b.x=0.6,b.y=0.8,cx=0,cy=0,sd.x=0.1,sd.y=0.1,phase.angle=0,period=24,n.points=24)
#The function **mel** can be used as an alternative to **mloop** for simulating ellipses, and it is useful because it offers four different ellipse parameterizations.
model <- fel(ellipse1$x,ellipse1$y,method="harmonic2",period=24,times="equal")
#period=24 and times="equal" are used to say that 24 equally spaced points make up an ellipse.
model
```

```
## Call:
## fel(x = ellipse1$x, y = ellipse1$y, method = "harmonic2", period = 24, 
##     times = "equal")
## 
## Delta Method Standard Errors and 95% C.I.'s:
##             Estimates    S.E.      low     high
## b.x          0.611746 0.02348  0.56242  0.66108
## b.y          0.829397 0.03389  0.75819  0.90061
## phase.angle  0.009077 0.03838 -0.07156  0.08971
## cx          -0.013770 0.01660 -0.04865  0.02111
## cy          -0.027886 0.02397 -0.07824  0.02247
## retention    0.423527 0.03389  0.35232  0.49474
## coercion     0.278211 0.02252  0.23090  0.32553
## area         0.813959 0.07224  0.66218  0.96574
## lag          1.803394 0.13902  1.51132  2.09546
## split.angle 53.588291 0.02678 53.53202 53.64456
## ampx         0.611746 0.02348  0.56242  0.66108
## ampy         0.931276 0.03389  0.86007  1.00248
## rote.deg    57.956870 1.53618 54.72947 61.18427
```
In addition to the fundamental values of the model, **fel** also calculates a wide variety of derived parameters. Definitions for these parameters can be found using **help(loop.parameters)**.

```r
model$Estimates
```

```
##          b.x          b.y  phase.angle           cx           cy 
##  0.611745822  0.829396933  0.009076523 -0.013769807 -0.027886124 
##    retention     coercion         area          lag  split.angle 
##  0.423527491  0.278210971  0.813958926  1.803393783 53.588291060 
## hysteresis.x hysteresis.y         ampx         ampy     rote.deg 
##  0.454781971  0.510645114  0.611745822  0.931275904 57.956870279 
##   semi.major   semi.minor      focus.x      focus.y eccentricity 
##  1.088509257  0.238023858  0.563540232  0.900344074  0.975798963
```
A wide variety of functions have S3 methods for objects of class **ellipsefit** produced by **fel**. 
The most important of these is **summary.ellipsefit** which can be used to bootstrap and summarize models 
produced by **fel**.

```r
summary(model,N=10000,studentize=TRUE)
```

```
## Summary Call:
## summary.ellipsefit(object = model, N = 10000, studentize = TRUE)
## Call for Original Fit:
## fel(x = ellipse1$x, y = ellipse1$y, method = "harmonic2", period = 24, 
##     times = "equal")
## Ellipse Fitting Method:
## [1] "harmonic2"
## [1] "Two step simple harmonic least squares"
## 
## Bootstrapped Estimates:
##              Boot.Estimate       Bias Std.Error B.q0.025 B.q0.975
## b.x               0.611257  4.890e-04  0.025729  0.56050  0.66074
## b.y               0.829578 -1.814e-04  0.040574  0.74947  0.90953
## phase.angle       0.009612 -5.353e-04  0.041290 -0.07215  0.09057
## cx               -0.013768 -2.264e-06  0.017885 -0.04918  0.02197
## cy               -0.027827 -5.919e-05  0.025935 -0.07389  0.02745
## retention         0.423893 -3.658e-04  0.050428  0.32541  0.52296
## coercion          0.278577 -3.659e-04  0.033464  0.21345  0.34457
## area              0.813970 -1.098e-05  0.103135  0.61505  1.01538
## lag               1.804363 -9.691e-04  0.219718  1.37714  2.24002
## split.angle      53.641591 -5.330e-02  1.768993 50.08617 57.09629
## hysteresis.x      0.455761 -9.793e-04  0.051108  0.35426  0.55493
## hysteresis.y      0.508806  1.839e-03  0.073168  0.37276  0.66000
## ampx              0.611257  4.890e-04  0.025729  0.56050  0.66074
## ampy              0.930063  1.213e-03  0.036292  0.85788  1.00195
## rote.deg         57.940378  1.649e-02  1.656099 54.71641 61.18337
## rote.rad          1.011250  2.878e-04  0.028904  0.95498  1.06785
## semi.major        1.087134  1.375e-03  0.033710  1.02035  1.15463
## semi.minor        0.238329 -3.051e-04  0.029181  0.18182  0.29592
## focus.x           0.563723 -1.826e-04  0.027569  0.50798  0.61641
## focus.y           0.899537  8.067e-04  0.037667  0.82449  0.97335
## eccentricity      0.976133 -3.341e-04  0.006264  0.96234  0.98691
```
Another important S3 method is for the function **plot**.

```r
plot(model,main="2-step Simple Harmonic Regression Ellipse Example")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 
In addition, S3 methods exist for **fitted**, **print**, and **residuals**.

### Comparison of Ellipse Estimation Methods

The two most useful ellipse estimation methods implemented by **fel** are the 'harmonic2' and 'direct' methods. The 'direct' method (Flusser and Halir) fits an ellipse without requiring time information and is more stable than the other two methods in **fel**, 'lm' and 'nls', which are based on linear least squares and ellipse-specific nonlinear regression respectively. The 'direct' method does not yet have delta method standard errors available.

```r
modeldirect <- fel(ellipse1$x,ellipse1$y,method="direct",period=24,times="equal")
summodel<-summary(modeldirect,N=10000,studentize=TRUE)
summodel
```

```
## Summary Call:
## summary.ellipsefit(object = modeldirect, N = 10000, studentize = TRUE)
## Call for Original Fit:
## fel(x = ellipse1$x, y = ellipse1$y, method = "direct", period = 24, 
##     times = "equal")
## Ellipse Fitting Method:
## [1] "direct"
## [1] "Direct specific least squares"
## 
## Bootstrapped Estimates:
##              Boot.Estimate      Bias Std.Error B.q0.025 B.q0.975
## b.x                 0.6453 -0.013049  0.027419   0.5938  0.70141
## b.y                 0.8142 -0.044763  0.046575   0.7235  0.90573
## cx                 -0.1001  0.008285  0.026764  -0.1507 -0.04593
## cy                 -0.1531  0.012602  0.032522  -0.2216 -0.09368
## retention           0.4441  0.037435  0.034189   0.3797  0.51347
## coercion            0.3108  0.024614  0.025031   0.2639  0.36206
## area                0.9042  0.052129  0.066896   0.7771  1.04005
## lag                 1.8946  0.241225  0.199886   1.5227  2.30861
## split.angle        51.7340 -1.142141  1.848919  47.8950 55.19121
## hysteresis.x        0.4788  0.051640  0.042314   0.3979  0.56411
## hysteresis.y        0.5311  0.094669  0.080586   0.3898  0.70684
## ampx                0.6453 -0.013049  0.027419   0.5938  0.70141
## ampy                0.9228 -0.015138  0.034047   0.8614  0.99595
## rote.deg           56.1949  0.583768  1.704864  52.9543 59.59864
## rote.rad            0.9808  0.010189  0.029755   0.9242  1.04019
## semi.major          1.0962 -0.027294  0.037634   1.0285  1.17661
## semi.minor          0.2611  0.023675  0.021696   0.2205  0.30587
## focus.x             0.5928 -0.028371  0.033590   0.5290  0.66022
## focus.y             0.8867 -0.024809  0.039220   0.8135  0.96847
## eccentricity        0.9732 -0.009324  0.008429   0.9543  0.98744
```

```r
plot(modeldirect,main="Direct Ellipse Example")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 
The 'direct' method uses different fundamental parameters than the 'harmonic2' method. However summary results for b.x, b.y, and retention are still available from the matrix of  values produced by summary.ellipsefit.

```r
summodel$values
```

```
##              Orig.Estimate   B.q0.025    B.q0.25     B.q0.5     B.q0.75
## b.x             0.63222737  0.5937835  0.6263409  0.6444749  0.66322683
## b.y             0.76946317  0.7235026  0.7823742  0.8134764  0.84463111
## cx             -0.09181282 -0.1506788 -0.1182959 -0.1007428 -0.08255179
## cy             -0.14053096 -0.2215992 -0.1733436 -0.1517862 -0.13099520
## retention       0.48150576  0.3796786  0.4205622  0.4427582  0.46649500
## coercion        0.33537594  0.2639397  0.2935078  0.3094668  0.32728957
## area            0.95636716  0.7770994  0.8575260  0.9035680  0.94886353
## lag             2.13580220  1.5227358  1.7579848  1.8883123  2.02281955
## split.angle    50.59185554 47.8949739 50.5386081 51.8235704 52.99893538
## hysteresis.x    0.53046729  0.3978947  0.4502058  0.4782950  0.50657475
## hysteresis.y    0.62576844  0.3898243  0.4752249  0.5255745  0.58018354
## ampx            0.63222737  0.5937835  0.6263409  0.6444749  0.66322683
## ampy            0.90770114  0.8613889  0.8995291  0.9211626  0.94394689
## rote.deg       56.77867835 52.9542710 55.0285455 56.1821048 57.33335801
## rote.rad        0.99097488  0.9242264  0.9604293  0.9805627  1.00065587
## semi.major      1.06888762  1.0284855  1.0701500  1.0939515  1.11988352
## semi.minor      0.28480180  0.2204928  0.2459934  0.2601057  0.27563165
## focus.x         0.56444608  0.5290062  0.5699708  0.5924452  0.61497923
## focus.y         0.86186385  0.8135371  0.8602422  0.8850733  0.91171223
## eccentricity    0.96384960  0.9542850  0.9680317  0.9739962  0.97916221
##                 B.q0.975  Std.Error   Boot.Mean         Bias Boot.Estimate
## b.x           0.70141246 0.02741876  0.61917828 -0.013049091     0.6452765
## b.y           0.90572851 0.04657549  0.72470030 -0.044762866     0.8142260
## cx           -0.04592816 0.02676395 -0.08352819  0.008284630    -0.1000975
## cy           -0.09367776 0.03252187 -0.12792926  0.012601697    -0.1531327
## retention     0.51346957 0.03418945  0.51894093  0.037435170     0.4440706
## coercion      0.36206244 0.02503055  0.35998971  0.024613772     0.3107622
## area          1.04005016 0.06689596  1.00849584  0.052128682     0.9042385
## lag           2.30860608 0.19988617  2.37702710  0.241224908     1.8945773
## split.angle  55.19121431 1.84891871 49.44971459 -1.142140952    51.7339965
## hysteresis.x  0.56410811 0.04231431  0.58210756  0.051640273     0.4788270
## hysteresis.y  0.70683549 0.08058550  0.72043720  0.094668767     0.5310997
## ampx          0.70141246 0.02741876  0.61917828 -0.013049091     0.6452765
## ampy          0.99595316 0.03404713  0.89256316 -0.015137986     0.9228391
## rote.deg     59.59863675 1.70486429 57.36244664  0.583768282    56.1949101
## rote.rad      1.04019244 0.02975550  1.00116356  0.010188679     0.9807862
## semi.major    1.17661487 0.03763394  1.04159324 -0.027294381     1.0961820
## semi.minor    0.30587110 0.02169621  0.30847724  0.023675439     0.2611264
## focus.x       0.66022321 0.03358955  0.53607501 -0.028371067     0.5928171
## focus.y       0.96847375 0.03922048  0.83705502 -0.024808834     0.8866727
## eccentricity  0.98743861 0.00842916  0.95452601 -0.009323589     0.9731732
```
The four plots below illustrate a comparison of the four methods for fitting an ellipse to simulated data. The data 
points are based on the simulated red ellipse; the fitted ellipse is in black.

```r
set.seed(13)
par(mfrow=c(2,2))
halfellipse <- mel(method=2,cx=20,cy=25,retention=1.2,b.x=14,b.y=0.8,sd.x=1,sd.y=0.2,period=24,n.points=16,phase.angle=pi/2)
halftrueellipse <- mel(method=2,cx=20,cy=25,retention=1.2,b.x=14,b.y=0.8,phase.angle=0,period=99,n.points=100)
harmodel<-fel(halfellipse$x,halfellipse$y,method="harmonic2",period=24,times="equal")
dirmodel<-fel(halfellipse$x,halfellipse$y,method="direct",period=24,times="equal")
lmmodel<-fel(halfellipse$x,halfellipse$y,method="lm",period=24,times="equal")
nlsmodel<-fel(halfellipse$x,halfellipse$y,method="nls",period=24,times="equal",control=c(n.iter=500))
plot(harmodel,main="Harmonic2 Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(dirmodel,main="Direct Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(lmmodel,main="Linear Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(nlsmodel,main="Non-Linear Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
```

![plot of chunk tests](figure/tests-1.png) 

Geometric Method
------------------

The geometric ellipse method used here is based on the work of Gander, Golub and Strebel, and the code used is an
R translation of the Matlab code they provided. This method directly minimizes the Euclidean distances from the
ellipse through Gauss-Newton minimization. Standard errors are obtainable through either the Delta Method
and bootstrapping, however the use of bootstrapping through summary.ellipsefit is discouraged on these ellipses
as the geometric method is extremely computationally expensive. The "geometric" method works best when sd.x=sd.y,
and it is important to check for false convergence. One way to check for false convergence is to examine the plot 
after fitting the data.
 

```r
set.seed(101)
ellip <- mel(rote.deg=45,semi.major=5,semi.minor=3,n.points=13,sd.x=0.4,sd.y=0.4)
true.ellip <- mel(rote.deg=45,semi.major=5,semi.minor=3,n.points=100,period=100)
ellip.geometric <- fel(ellip$x,ellip$y,method="geometric")
ellip.geometric$values
```

```
##           cx           cy     rote.rad   semi.major   semi.minor 
##   31.6319099   39.0219604    0.8018498    4.9802104    2.4089135 
##     rote.deg  phase.angle         area          lag     coercion 
##   45.9426122    5.9882690   37.6893605    1.8648117    3.0359536 
##          b.x          b.y    retention  split.angle hysteresis.x 
##    3.8717128    2.4523187    3.0986017   32.3499135    0.7841371 
## hysteresis.y         ampx         ampy      focus.x      focus.y 
##    1.2635396    3.8717128    3.9516072    3.0310553    3.1324647 
## eccentricity            n 
##    0.8752354   13.0000000
```

```r
plot(ellip.geometric,main="Geometric Model")
lines(true.ellip$x,true.ellip$y,col="red")
```

![plot of chunk geometric](figure/geometric-1.png) 

Bootstrapping Fitted Ellipses
----------------------------------

The function **summary.ellipsefit** bootstraps the x and y residuals of a fitted ellipse separately to produce 
standard errors and less biased estimates of ellipse parameters. These residuals are easy to obtain using the 
'harmonic2' model which gives fitted points when fitting the ellipse, but somewhat more difficult to obtain from the 
other methods which do not use time as a variable in fitting the model and therefore cannot place observations on the 
ellipse. The function **fel**, therefore, gives two methods for producing x and y residuals using these methods. If 
times="unknown", fitted values are taken to be the points on the ellipse closest to their realized values. If 
times="equal" or a numeric vector and the period of the ellipse is known, then the distances between points on the 
ellipse are taken as given and only the starting point of the ellipse is chosen to minimize the sum of squared distances 
between fitted and realized values. If times are available, it is always better to give them, as the residuals given 
by times='unknown' will lead to standard errors for ellipse parameters that are biased downwards. If times really are 
unknown, a good alternative is to use the delta standard errors from the function **delta.error** which is currently 
available for every method except the direct.

In addition, residuals can be studentized within the **summary.ellipsefit** function by keeping studentize=TRUE, which is the default. Simulations suggest that studentization improves 95% bootstrap coverage intervals for all four methods.

The value N gives the number of bootstrap replicates, its default is 1000 which may be  low in some situations (Efron 1979).
In each replication, residuals are resampled with replacement and added to the original fitted values produced by **fel**. The simulated ellipse is then refit using the original method and parameter estimates are obtained. The standard deviations of these estimates are then used to give parameter standard errors, and less biased parameter estimates are obtained by subtracting the estimated bias produced by the method, mean(bootstrap estimates) - (original estimate), from the original estimate.
Note, if reproducible results are desired use set.seed() command.
### Comparison of Bootstrapped Ellipses

The fitted black ellipses from above are then bootstrapped to reduce bias.

```r
par(mfrow=c(2,2))
harsummodel<-summary(harmodel,N=1000,studentize=TRUE)
dirsummodel<-summary(dirmodel,N=1000,studentize=TRUE)
lmsummodel<-summary(lmmodel,N=1000,studentize=TRUE)
nlssummodel<-summary(nlsmodel,N=1000,studentize=TRUE)
```

```
## Warning in nlssummary(object, N = N, studentize = studentize, center =
## center, : The function nls failed to converge 122 times.
```

```r
plot(harsummodel,main="Bootstrapped Harmonic2 Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(dirsummodel,main="Bootstrapped Direct Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(lmsummodel,main="Bootstrapped Lm Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
plot(nlssummodel,main="Bootstrapped Nls Model",xlim=c(5,34),ylim=c(23.4,26.9))
lines(halftrueellipse$x,halftrueellipse$y,col="red")
```

![plot of chunk boottest](figure/boottest-1.png) 

Fitting Multiple Ellipses Simultaneously
------------------------------------------

The argument subjects in the function **fel** can be used to fit multiple ellipses, which share the same period, 
at one time. In this case **fel** produces an object of class **ellipsefitlist** instead of **ellipsefit**, and methods for 
objects of class **ellipsefitlist** exist for the functions **summary**, **plot**, and **print**. Ellipses are separated 
by levels given by the argument subjects, which can be either a vector or a list of vectors treated as factors. Below 
is an example of fitting multiple ellipses using the subjects option.


```r
data(EllipseData)
models <- fel(EllipseData$X,EllipseData$Y,method="harmonic2",subjects=EllipseData$subjects,subset=EllipseData$repeated==1)
models
```

```
## Call:
## fel(x = EllipseData$X, y = EllipseData$Y, method = "harmonic2", 
##     subjects = EllipseData$subjects, subset = EllipseData$repeated == 
##         1)
## 
## Parameter Estimates:
##             cx           cy       b.x       b.y phase.angle retention
## A -0.020697918 -0.019671309 0.5736708 0.7912104   -4.695827 0.3762420
## B  0.018284077 -0.007561673 0.5502696 0.8478535    1.522854 0.8171985
## C -0.004129446 -0.015904305 0.9989673 0.8180595   -4.676999 0.4144164
##        area      lag  coercion  rote.rad rote.deg semi.major semi.minor
## A 0.6780785 1.695490 0.2463602 1.0103811 57.89057   1.025867  0.2103967
## B 1.4127098 2.929684 0.3818710 1.2154049 69.63757   1.248931  0.3600515
## C 1.3005830 1.791072 0.4514399 0.7375241 42.25702   1.319251  0.3138056
##   split.angle hysteresis.x hysteresis.y      ampx      ampy   focus.x
## A    54.05583    0.4294452    0.4755272 0.5736708 0.8761118 0.5336960
## B    57.01583    0.6939708    0.9638440 0.5502696 1.1775691 0.4161244
## C    39.31422    0.4519066    0.5065847 0.9989673 0.9170399 0.9483996
##     focus.y eccentricity
## A 0.8504735    0.9787428
## B 1.1211743    0.9575438
## C 0.8616776    0.9712979
## 
## Delta Method Standard Errors:
##       b.x     b.y phase.angle      cx      cy retention coercion    area
## A 0.03591 0.03035     0.06259 0.02539 0.02146   0.03035  0.02366 0.06923
## B 0.02605 0.02935     0.04733 0.01842 0.02075   0.02935  0.02060 0.08394
## C 0.02949 0.02961     0.02952 0.02085 0.02093   0.02961  0.03171 0.10053
##       lag split.angle    ampx    ampy rote.deg
## A 0.13231     0.03489 0.03591 0.03035    3.291
## B 0.09519     0.02678 0.02605 0.02935    1.440
## C 0.12331     0.02289 0.02949 0.02961    2.554
```

```r
summodels<-summary(models)
summodels
```

```
## Summary Call:
## summary.ellipsefitlist(object = models)
## Call for Original Fit:
## FUN(x = data[x, , drop = FALSE], method = ..1, period = ..2, 
##     times = ..3, na.action = ..4, control = ..5)
## Ellipse Fitting Method:
## [1] "harmonic2"
## [1] "Two step simple harmonic least squares"
## 
## Bootstrapped Value Estimates:
##       Parameter Subject Boot.Estimate       Bias Std.Error B.q0.025
## 1           b.x       A      0.571808  1.862e-03  0.038741  0.49822
## 2           b.y       A      0.792857 -1.647e-03  0.040717  0.71049
## 4            cx       A     -0.022056  1.358e-03  0.026827 -0.07562
## 5            cy       A     -0.020552  8.810e-04  0.023515 -0.06664
## 6     retention       A      0.376536 -2.943e-04  0.064579  0.24968
## 7      coercion       A      0.246141  2.193e-04  0.044121  0.16043
## 8          area       A      0.676535  1.543e-03  0.124611  0.43904
## 9           lag       A      1.693983  1.507e-03  0.302193  1.11996
## 11 hysteresis.x       A      0.430434 -9.884e-04  0.071163  0.29175
## 12 hysteresis.y       A      0.471307  4.220e-03  0.098555  0.29433
## 13         ampx       A      0.571808  1.862e-03  0.038741  0.49822
## 14         ampy       A      0.874982  1.130e-03  0.031902  0.80871
## 15     rote.deg       A     57.895919 -5.345e-03  2.255722 53.31187
## 17   semi.major       A      1.023878  1.990e-03  0.032981  0.95691
## 18   semi.minor       A      0.210330  6.664e-05  0.037928  0.13664
## 19      focus.x       A      0.533197  4.995e-04  0.040530  0.45582
## 20      focus.y       A      0.850230  2.431e-04  0.033475  0.78186
## 21 eccentricity       A      0.979467 -7.239e-04  0.008016  0.96186
## 22          b.x       B      0.548026  2.243e-03  0.027021  0.49607
## 23          b.y       B      0.849977 -2.123e-03  0.051766  0.74776
## 25           cx       B      0.016717  1.567e-03  0.020326 -0.02208
## 26           cy       B     -0.006713 -8.486e-04  0.022103 -0.05079
## 27    retention       B      0.816929  2.692e-04  0.053187  0.71388
## 28     coercion       B      0.380391  1.480e-03  0.028766  0.32381
## 29         area       B      1.406569  6.141e-03  0.114251  1.18574
## 30          lag       B      2.924333  5.351e-03  0.215000  2.49041
## 32 hysteresis.x       B      0.694061 -9.060e-05  0.040463  0.60917
## 33 hysteresis.y       B      0.955148  8.696e-03  0.110229  0.75040
## 34         ampx       B      0.548026  2.243e-03  0.027021  0.49607
## 35         ampy       B      1.177049  5.204e-04  0.033507  1.10977
## 36     rote.deg       B     69.681508 -4.394e-02  1.487801 66.70678
## 38   semi.major       B      1.247795  1.136e-03  0.032816  1.18474
## 39   semi.minor       B      0.358824  1.228e-03  0.027412  0.30408
## 40      focus.x       B      0.415346  7.786e-04  0.030323  0.35616
## 41      focus.y       B      1.121428 -2.539e-04  0.035803  1.05038
## 42 eccentricity       B      0.958124 -5.800e-04  0.007021  0.94294
## 43          b.x       C      0.998415  5.521e-04  0.031417  0.93561
## 44          b.y       C      0.818827 -7.678e-04  0.035314  0.75055
## 46           cx       C     -0.004027 -1.021e-04  0.022256 -0.04835
## 47           cy       C     -0.014560 -1.344e-03  0.022872 -0.05799
## 48    retention       C      0.414519 -1.024e-04  0.041753  0.33080
## 49     coercion       C      0.451405  3.494e-05  0.045420  0.36020
## 50         area       C      1.300146  4.374e-04  0.137567  1.03759
## 51          lag       C      1.789891  1.180e-03  0.183790  1.42171
## 53 hysteresis.x       C      0.452153 -2.465e-04  0.042892  0.36474
## 54 hysteresis.y       C      0.504716  1.869e-03  0.060709  0.38738
## 55         ampx       C      0.998415  5.521e-04  0.031417  0.93561
## 56         ampy       C      0.916712  3.278e-04  0.032352  0.85341
## 57     rote.deg       C     42.268708 -1.169e-02  1.543386 39.05616
## 59   semi.major       C      1.318592  6.588e-04  0.031301  1.26059
## 60   semi.minor       C      0.313851 -4.522e-05  0.032377  0.24943
## 61      focus.x       C      0.948417 -1.731e-05  0.033234  0.88573
## 62      focus.y       C      0.862004 -3.265e-04  0.034522  0.79391
## 63 eccentricity       C      0.971642 -3.446e-04  0.006211  0.95861
##    B.q0.975
## 1   0.64889
## 2   0.86702
## 4   0.02916
## 5   0.02544
## 6   0.50214
## 7   0.33310
## 8   0.92228
## 9   2.26611
## 11  0.56170
## 12  0.66700
## 13  0.64889
## 14  0.93666
## 15 62.24675
## 17  1.08603
## 18  0.28427
## 19  0.61682
## 20  0.91355
## 21  0.99251
## 22  0.60209
## 23  0.94624
## 25  0.05636
## 26  0.03656
## 27  0.91870
## 28  0.43800
## 29  1.63141
## 30  3.34162
## 32  0.76941
## 33  1.18646
## 34  0.60209
## 35  1.24514
## 36 72.66902
## 38  1.31423
## 39  0.41234
## 40  0.47478
## 41  1.19276
## 42  0.97018
## 43  1.05683
## 44  0.88454
## 46  0.03768
## 47  0.02932
## 48  0.49327
## 49  0.53507
## 50  1.55634
## 51  2.14445
## 53  0.53340
## 54  0.62605
## 55  1.05683
## 56  0.98033
## 57 45.17643
## 59  1.38081
## 60  0.37415
## 61  1.01277
## 62  0.92854
## 63  0.98289
```

```r
plot(summodels,main="Fitting Multiple Ellipses Simultaneously")
```

![plot of chunk multiple](figure/multiple-1.png) ![plot of chunk multiple](figure/multiple-2.png) ![plot of chunk multiple](figure/multiple-3.png) 

To output summary results to excel readable file at current directory
----------------------------------------------------------------------


```r
## write.table(models$Estimates,"file_name.txt") and 
## write.table(summodels$Boot.Estimates,"file_name.txt")
```

Fitting Hysteresis Loops
--------------------------

The function **floop** can be used to fit hysteresis loops with specific values of n and m as arguments to **floop**. Below is an example of a 
hysteresis loop with n=5, m=3. 

```r
loop <- mloop(n=5, m=3,sd.x=0.02,sd.y=0.02)
fitloop <- floop(loop$x,loop$y,n=5, m=3,period=24,times="equal")
```

```
## Warning in floop(loop$x, loop$y, n = 5, m = 3, period = 24, times =
## "equal"): hysteresis.x and coercion only available if m=n
```

```r
fitloop$Estimates
```

```
##                n                m              b.x              b.y 
##      5.000000000      3.000000000      0.609974097      0.797297620 
##      phase.angle               cx               cy        retention 
##     -0.012899598     -0.003234653     -0.001433085      0.198209517 
##         coercion             area              lag beta.split.angle 
##               NA      0.284870208      0.930720862      0.000000000 
##     hysteresis.x     hysteresis.y 
##               NA      0.248601666
```

```r
plot(fitloop,main="Fitted Hysteresis Loop")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png) 

```r
summary(fitloop)
```

```
## Summary Call:
## summary.fittedloop(object = fitloop)
## Call for Original Fit:
## floop(x = loop$x, y = loop$y, n = 5, m = 3, times = "equal", 
##     period = 24)
## 
## Bootstrapped Estimates:
##                  Boot.Estimate       Bias Std.Error  B.q0.025  B.q0.975
## n                     5.000000  0.000e+00  0.000000  5.000000  5.000000
## m                     3.000000  0.000e+00  0.000000  3.000000  3.000000
## b.x                   0.610017 -4.301e-05  0.003549  0.603288  0.617060
## b.y                   0.797376 -7.876e-05  0.007621  0.782977  0.812776
## phase.angle          -0.025725  1.283e-02  0.006019 -0.037573 -0.013901
## cx                   -0.003184 -5.078e-05  0.002644 -0.008492  0.001719
## cy                   -0.001226 -2.073e-04  0.003730 -0.008998  0.005879
## retention             0.198355 -1.456e-04  0.006739  0.184992  0.211902
## coercion                    NA         NA        NA        NA        NA
## area                  0.285099 -2.289e-04  0.009838  0.265076  0.305437
## lag                   0.931271 -5.498e-04  0.031658  0.867552  0.994353
## beta.split.angle      0.000000  0.000e+00  0.000000  0.000000  0.000000
## hysteresis.x                NA         NA        NA        NA        NA
## hysteresis.y          0.248736 -1.347e-04  0.008801  0.231079  0.266327
```

Acknowledgments
-----------------

NIFA MRF 25-008/W-2173 Impacts of Stress Factors on Performance, Health, and Well Being of Farm Animals
