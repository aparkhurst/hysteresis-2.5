\name{hysteresis-package}
\alias{hysteresis-package}
\alias{hysteresis}
\docType{package}
\title{
Modeling Rate-Dependent Hysteretic Processes
}
\description{
Fit, summarize and plot sinusoidal hysteretic processes using two step harmonic least squares. If the process is elliptical, other methods such as a geometric method, Halir and Flusser's direct specific least squares, ordinary least squares,
and ellipse-specific non-linear least squares are also available.
}
\details{
\tabular{ll}{
Package: \tab hysteresis\cr
Type: \tab Package\cr
Version: \tab 2.0\cr
Date: \tab 2013-11-14\cr
License: \tab gpl (>= 2)\cr
}
Fits input and output variables x and y that form a hysteresis loop based on the generalized transcendental equation \deqn{x_t=b.x*cos(2pi*t/period+phase.angle)+cx+e_{x,t}} \deqn{y_t=b.y*cos(2pi*t/period+phase.angle)^n+retention*sin(2pi*t/period+phase.angle)^m+cy+e_{y,t}}  where \deqn{t=0,...,n.points-1 if times='equal'} 
The functions \code{\link{mloop}}, \code{\link{floop}} and the function method \code{\link{summary.fittedloop}} can be used to simulate, fit, obtain derived parameter estimates (see \code{\link{loop.parameters}} or \code{\link{ellipse.parameters}} ), and delta method standard errors for hysteresis loops with independent and normally distributed errors. 
If m=1 and n=1 then the hysteresis loop will form an ellipse which can be simulated with \code{\link{mel}}, fitted using 5 different available methods with \code{\link{fel}}, and bootstrapped using the function method \code{\link{summary.ellipsefit}}. Derived ellipse parameters (see \code{\link{ellipse.parameters}}) can therefore be obtained along with
standard errors from models under any type of error structure that can be handled by bootstrapping. Studentized residuals are also available ((see \code{\link{residuals.ellipsesummary}}).
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.

Maintainer: Spencer Maynes <smaynes89@gmail.com>
}
\references{
Yang, F. and A. Parkhurst, Efficient Estimation of Elliptical Hysteresis. (submitted)
}
\keyword{ package }
\seealso{
Check out the vignette browseURL(system.file('doc/index.html',package='hysteresis')) \cr
For simulating hysteresis loops, \code{\link{mloop}} and \code{\link{mel}}. \cr
For fitting hysteresis loops, \code{\link{floop}} and \code{\link{fel}}. \cr
For summarizing hysteresis loops, \code{\link{summary.fittedloop}} and \code{\link{summary.ellipsefit}}. \cr
For bootstrapping ellipses, \code{\link{summary.ellipsefit}}.
For fitting multiple hysteresis loops at once, can use \code{\link{fel}} and \code{\link{floop}} or \code{\link{fel.repeated}} and \code{\link{floop.repeated}} which can be easier to use for studies involving repeated measures. \cr
Miscellaneous \code{\link{plot.ellipsefit}}, \code{\link{plot.ellipsefitlist}}, \code{\link{plot.ellipsesummary}}, \code{\link{residuals.ellipsesummary}}.
}
\examples{
###Take a look at the vignette.
#browseURL(system.file('doc/index.html',package='hysteresis'))

### Simulate and fit a hysteresis loop with m=3 and n=5.
 loop1 <- mloop(sd.x=0.05,sd.y=0.05,n=5,m=3)
 model <- floop(loop1$x,loop1$y,n=5,m=3)
 model                #Gives estimate with delta standard errors
 model$Estimates      #Gives estimates  
 model$Std.Errors     #Lists delta standard errors  
 
### Plot hysteresis loop.
 plot(model,main="Simulated Hysteresis Loop n=5 m=3")

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
 booted.loop <- floop(loop1$x,loop1$y,,n=5,m=3,boot=TRUE, seed=1523)
 booted.loop                   #Gives boot estimates, boot bias, boot SE and boot quartiles
 booted.loop$Boot.Estimates    #Gives boot estimates 
 booted.loop$Boot.Std.Errors   #Gives boot standard errors 
plot(booted.loop,main="Simulated Bootstrapped Loop n=5, m=3",putNumber=TRUE)


### Simulate and fit an ellipse.
ellipse1 <- mel(sd.x=0.2,sd.y=0.04)
ellipse1.fit <- fel(ellipse1$x,ellipse1$y)
ellipse1.fit             #Gives estimates with delta standard errors and 95%CI
ellipse1.fit$Estimates      #Gives all estimates 
ellipse1.fit$Std.Errors     #Lists delta standard errors  

### Plot ellipse
plot(ellipse1.fit,xlab="Input",ylab="Output",main="Simulated Ellipse")

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
booted.ellipse <- fel(ellipse1$x,ellipse1$y,boot=TRUE, seed=123)
booted.ellipse                 #Gives boot estimates, boot bias, boot SE and boot quartiles
booted.ellipse$Boot.Estimates  #Gives boot estimates   
booted.ellipse$Boot.Std.Errors #Gives boot standard errors

}
