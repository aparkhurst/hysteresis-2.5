\name{summary.fittedloop}
\alias{summary.ellipsefit}
\alias{summary.fittedloop}
\alias{summary.loop2r}

\title{
Summarizing and Bootstrapping Fitted Ellipses or Loops
}
\description{
summary methods for classes \code{ellipsefit} and \code{fittedloop} created by the functions \code{\link{fel}} and \code{\link{floop}}. Can bootstrap results to produce parameter estimates with reduced bias and standard errors.
}
\usage{
\method{summary}{ellipsefit}(object,boot=TRUE, N = 1000, 
studentize=TRUE, center=FALSE, cbb=NULL, joint=FALSE,seed=NULL,...)
\method{summary}{fittedloop}(object,boot=TRUE,N=1000,
cbb=NULL,joint=FALSE,seed=NULL,...)
\method{summary}{loop2r}(object,boot=TRUE,N=1000,
cbb=NULL,joint=FALSE,seed=NULL,...)
}
\arguments{
  \item{object}{
an object of class \code{ellipsefit} or \code{fittedloop}, a result of a call to \code{\link{fel}} or \code{\link{floop}}.
}
\item{boot}{
logical. Whether to perform bootstrapping to get standard errors, which is the default TRUE, or to get standard errors through the delta method if FALSE.
}
  \item{N}{
optional number of bootstrap replicates. Default of 1000.
}
  \item{studentize}{
studentize the residuals to improve performance. Default is true.
}
  \item{center}{
center x and y residuals around zero. Default is false. Irrelevant for "harmonic2" method.
}
  \item{cbb}{
allows for circular block bootstrapping. The default is NULL in which case circular block bootstrapping is not performed. If cbb is an integer greater than 1 which is a divisor of either the number of observations for methods "nls", "lm", "geometric" or the number of observations minus 3 for \code{method="harmonic2"} then it is used as the block size for circular block bootstrapping.  
}
  \item{joint}{
logical that defaults to false. Resample input and output residuals paired by observation, instead of separately.  
}
  \item{seed}{
either NULL or a positive integer. Set the random number seed.
}
  \item{\dots}{
further arguments passed to or from other methods.
}
}
\details{
Bootstrap objects created by fitting hysteretic data with one of the functions \code{\link{fel}} or \code{\link{floop}} and produce statistical summaries. Bootstrapping reduces the bias on estimates and also gives standard errors. Bootstrap estimates are created by subtracting original estimates from bootstrap means to get a bias estimate, and then subtracting this bias from the original estimate.

Residuals are studentized as if they were produced using the harmonic2 method, regardless of which method was actually used to produce them. However, unpublished simulation studies show that these studentized residuals provide better 95 percent coverages for all methods despite this. This studentization is not true studentization as in \code{\link{rstudent.ellipsefit}} as it only accounts for the influence matrix and does not divide by the standard deviation.

If residuals are serially correlated than the argument cbb may be used to sample blocks of length cbb instead of individual residuals. Circular block bootstrapping is used, which means that all residuals are equally likely to be included and blocks can be made up of the last points on the ellipse together with the first.

When using the 'nls', 'geometric' or 'lm' methods individual bootstrap replications may occasionally fail to converge, when this occurs an extra replication will take the place of the one that failed to converge and a warning message will be produced.
}
\value{

\item{call}{function call for original fit.}
   \item{method}{fitting method used. Only for \code{summary.ellipsefit}. See \code{\link{fel}}.}
  \item{x }{the input x.}
  \item{y}{the output y.}
\item{pred.x }{the bootstrap fitted values for x.}
  \item{pred.y }{the bootstrap fitted values for y.}

   \item{values }{matrix containing parameter and standard error estimates, bootstrap quantiles, and bootstrapped parameter estimates for a wide variety of parameters. See \code{\link{loop.parameters}}.}
  \item{Delta.Std.Errors}{the delta method standard errors.}
     \item{fit.statistics}{rudimentary measures, based on the "harmonic2" method, include the Multivariate Final Prediction Error (MFPE) and the AIC for both the output alone and the two variables in combination. 
Although degree of freedom adjustments are made for other methods, measures of fit require further study}

For bootstrapping
 \item{summarycall}{the function call.}
 \item{boot.data}{parameter estimates from individual bootstrap replications.}
    \item{Boot.Estimates}{bootstrapped estimates.}
  \item{Boot.Std.Errors}{bootstrap standard errors.}
}
\references{
Yang, F. and A. Parkhurst, Efficient Estimation of Elliptical Hysteresis (submitted)

Correa, Solange, Extended Bootstrap Bias Correction with Application to Multilevel Modelling of Survey Data under Informative Sampling.
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{fel}} for fitting points that form an ellipse and creating an ellipsefit object and \code{\link{plot.ellipsesummary}} for plotting an ellipsesummary object.  
}
\examples{
#Loop example with circular block bootstrapping
loop1 <- mloop(n=1,m=2,sd.x=0.05,sd.y=0.05)
loop1.fit <- floop(loop1$x,loop1$y,m=2,n=1)
boot.loop1 <- summary(loop1.fit,cbb=3)
boot.loop1
plot(boot.loop1)

#Ellipse example.
ellipse1 <- mel(sd.x=0.2,sd.y=0.04)
ellipse1.fit <- fel(ellipse1$x,ellipse1$y)
boot.ellipse1.fit <- summary(ellipse1.fit)
boot.ellipse1.fit
plot(boot.ellipse1.fit,xlab="Input",ylab="Output",
main="Bootstrapped Ellipse",putNumber=TRUE)

}
\keyword{ models }

