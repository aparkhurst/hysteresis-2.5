\name{fel}
\alias{fel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fitting Ellipses
}
\description{
Fit a sinusoidal hysteretic (elliptical) process between an input and an output.
}
\usage{
fel(x, y=NULL, method = "harmonic2", period = NULL, subjects = NULL,
  times="unknown",subset = NULL,na.action= getOption("na.action"),
  control=nls.control(), boot=FALSE,...)
}
\arguments{
  \item{x}{
input
}
  \item{y}{
output
}
  \item{method}{
the method to be used for fitting; one of either the default \code{method="harmonic2"}, \code{method="nls"}, \code{method="direct"}, \code{method="lm"} or \code{method="geometric"}.
}
  \item{period}{
an optional number that defines the length of the \code{period}.
}
  \item{subjects}{
an optional factor or list of factors, each of the same length as x. Use to identify several different ellipses to fit at once, in which case \code{fel} returns an object of class \code{ellipsefitlist} instead of \code{ellipsefit}. If \code{subjects} is a list of factors each combination of the factors must be present in the data or an error will be produced.
}
  \item{times}{
either a numeric vector of length \code{nrow(x)} or one of the two options "equal" or the default "unknown". If the times at which ellipse observations are taken are known, a numeric vector
can be used to give those times. If not, predicted values are found by minimizing geometric distances from the fitted ellipse to the observations. If "equal", time points are assumed to be equally spaced in a counterclockwise fashion. Do not use the "harmonic2" method unless times are either known or are known to be equal. Bootstrapping results are also more accurate if correct times are used.}
  \item{subset}{
an optional vector specifying a subset of observations to be used in the fitting process.
}
  \item{control}{
optional and only used if \code{method="nls"} or \code{"geometric"}. See \code{\link{nls.control}} for \code{method="nls"}.
}
  \item{na.action}{
a function which indicates what should happen when the data contain NAs. The default is set by the \code{na.action} setting of \code{\link{options}}, the factory-fresh default 
is \code{\link{na.omit}}. Value \code{\link{na.exclude}} can be useful.
}
  \item{boot}{
logical, if \code{TRUE} results will be bootstrapped by \code{\link{summary.ellipsefit}}.
}
  \item{...}{
other othrt optional arguments passed to \code{\link{summary.ellipsefit}} if \code{boot=TRUE}.
}
}
\details{
Where the response y is a sinusoidal process with an element of randomness that lags the controlling input x, which is also a stochastic sinusoidal process, an ellipse can be used to fit the relationship between
x and y.

The values of parameters such as area, lag, retention, coercion, split angle and hysteresis.y are estimated from this ellipse. See \code{\link{loop.parameters}}.

The harmonic2 method is a two step harmonic least squares model using generalized transcendental equations presented by Lapshin (1995).  Yang and Parkhurst provide the efficient estimates 
for parameters and as such "harmonic2" is used as the default. Direct specific least squares (\code{method="direct"}) based on the work of Radim Halir and Jan Flusser is also available although work on delta method standard errors is still in progress. The geometric method is based on the work of Gander, Golub and Strebel and uses the results of an initial direct method to produce an ellipse that minimizes the sum of the squared geometric distances. Finally \code{method="lm"} and 
ellipse specific non-linear least squares (\code{method="nls"}) are included as well.

If x and y contain more than 1 ellipse that needs to be fit, the argument \code{subjects} can be used to identify a period of data to fit separate ellipses.

Bootstrapped estimates for parameter values are provided with \code{\link{summary.ellipsefit}}.  These bootstrapped estimates are generally less biased than those provided by \code{fel} in isolation.
}
\value{
\code{fel} returns an object of class \code{ellipsefit} or \code{ellipsefitlist}.
  \item{call}{the function call.}
  \item{fit}{information dependent on the fitting method used.}
  \item{method}{the \code{method} used.}
  \item{x}{the input x used.}
  \item{y}{the output y used.}
  \item{pred.x}{the fitted values for x.}
  \item{pred.y}{the fitted values for y.}
  \item{period.time}{a vector that contains times converted to radians for observations, either estimated after the ellipse has been fitted or given beforehand by \code{times}.}
\item{fit.statistics}{rudimentary measures, based on the "harmonic2" method, include the Multivariate Final Prediction Error (MFPE) and the AIC for both the output alone and the two variables in combination. 
Although degree of freedom adjustments are made for other methods, measures of fit require further study.}

\item{values}{a named vector of parameter estimates. See \code{\link{loop.parameters}}, same as Estimates here.}
 \item{Estimates}{a named vector of parameter estimates. See \code{\link{loop.parameters}}, same as values.}
    \item{Std.Errors}{Delta standard errors produced by the delta method.}
  \item{residuals}{algebraic residuals from the model. The function \code{\link{residuals.ellipsefit}} can produce other types of residuals from an \code{ellipsefit} object.}

if \code{boot==TRUE} \code{\link{fel}} returns an object of class \code{ellipsesummary} by making a call to \code{\link{summary.ellipsefit}}. See \code{\link{summary.ellipsefit}}.

For bootstrapping
    \item{Boot.Estimates}{bootstrapped estimates.}
  \item{Boot.Std.Errors}{bootstrap standard errors.}

    If multiple ellipses are fit simultaneously there will be three arguments to the response, models which will contain the separate model fits for each ellipse, Estimates which will have all of the parameter estimates in matrix form, and Std.Errors which will have all of the delta method standard errors in matrix form. See \code{\link{fel.repeated}}.
}
\references{
Yang, F. and A. Parkhurst, Efficient Estimation of Elliptical Hysteresis. (submitted)
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{plot.ellipsefit}} for plotting and \code{\link{summary.ellipsefit}} for summarizing and bootstrapping an \code{ellipsefit} object. Also \code{\link{residuals.ellipsefit}}.
}
\examples{
### Simulate and fit a Single ellipse.
Sellipse <- mel(method=2,sd.x=0.2,sd.y=0.04)
Sellipse.fit <- fel(Sellipse$x,Sellipse$y)
Sellipse.fit  #Gives estimates, delta standard errors and 95% CI
Sellipse.fit$Estimates  

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
booted.Sellipse <- fel(Sellipse$x,Sellipse$y,boot=TRUE, seed=123)
booted.Sellipse   #Gives boot estimates, boot bias, boot SE and boot quartiles
plot(booted.Sellipse,main="Simulated Bootstrap Ellipse Loop",xlab="X Input",
ylab="Y Output",values="ellipse.all")

}
\keyword{ models }

