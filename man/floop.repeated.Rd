\name{floop.repeated}
\alias{floop.repeated}
\alias{summary.fittedlooplist}
\alias{floop2r.repeated}
\alias{summary.fittedlooplist2r}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Methods for easily fitting multiple loops from repeated measures designs.
}  
\description{
Fit a sinusoidal hysteretic process between an input and an output variable across multiple loops separated by subjects and repeated.
}
\usage{
floop.repeated(x,y=NULL,m=1,n=1,subjects=NULL,repeated=NULL,
subjects.in="all",repeated.in="all",...)
floop2r.repeated(x,y=NULL,m=1,n=1,subjects=NULL,repeated=NULL,
subjects.in="all",repeated.in="all",...)
\method{summary}{fittedlooplist}(object,N=1000,boot=TRUE,seed=NULL,...)
\method{summary}{fittedlooplist2r}(object,N=1000,boot=TRUE,seed=NULL,...)
}
\arguments{
  \item{x}{
numeric input vector.
}
  \item{y}{
numeric output vector.
}
  \item{n}{
positive integer. Loop shape parameter, see \code{\link{loop.parameters}}.
}
  \item{m}{
positive odd integer. Loop bulging parameter, see \code{\link{loop.parameters}}.
} 
 \item{subjects}{
factor of the same length as x that represents experimental units.
}
  \item{repeated}{
factor of the same length as x that represents the repeated measure.
}
  \item{subjects.in}{
a vector of characters, the levels of \code{subjects} to be included. Default is "all".
}
   \item{repeated.in}{
a vector of characters, the levels of \code{repeated} to be included. Default is "all".
}
   \item{object}{
an \code{fittedlooplist} object.
}
   \item{N}{
number of bootstrap replicates. See \code{\link{summary.fittedloop}}.
}
   \item{boot}{
whether or not bootstrapping should be performed. See \code{\link{summary.fittedloop}}.
}
   \item{seed}{
for generating random numbers. See \code{\link{summary.fittedloop}}.
}
  \item{...}{
extra arguments to either  \code{\link{floop}} or \code{\link{summary.fittedloop}}.
}
}
\details{
Fits multiple loops with one call, separated by the factors \code{subjects} and \code{repeated}. The arguments \code{subjects.in} and \code{repeated.in} are used to select subsets of the factors \code{subjects} and \code{repeated}.
}
\value{

 \code{floop.repeated} returns an object of class \code{fittedlooplist}.
    \item{models}{Separate model fits for each loop, see \code{\link{floop}}.}
    \item{Estimates}{Parameter estimates for all loops in matrix form.}
    \item{Std.Errors}{Delta standard errors for all loops in matrix form.}
    When \code{boot=TRUE} \code{\link{floop.repeated}} returns an object of class \code{loopsummarylist} which consists of
    \item{models}{Separate model summaries for each ellipse, see \code{\link{summary.fittedloop}}.}
    \item{values}{Bootstrapped parameter estimates, standard errors, quantiles, and more for each loop.}
    \item{Boot.Estimates}{Bootstrapped parameter estimates with reduced bias.}
    \item{Boot.Std.Errors}{Standard errors provided by bootstrapping.}
}
\references{
Yang, F. and A. Parkhurst, Efficient Estimation of Elliptical Hysteresis (submitted)
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{floop}} and \code{\link{summary.fittedloop}}, also  \code{\link{fel.repeated}} and \code{\link{summary.ellipsefitlist}}. Also \code{\link{residuals.fittedlooplist}}.
}
\examples{
data(HysteresisData)
loopmodels.rep <- floop.repeated(HysteresisData$X, HysteresisData$Y,
n=5,m=3, subjects = HysteresisData$subjects,subjects.in=c("A","C"),
repeated=HysteresisData$repeated)
loopmodels.rep                #Gives estimates and delta standard errors
loopmodels.rep$Estimates      #List estimates only
loopmodels.rep$Std.Errors     #List delta standard errors

par(mfrow=c(2,2))
plot(loopmodels.rep,main='Simulated Rep Loops',values="hysteresis")
par(mfrow=c(1,1))

loopmodels.rep$models["A",1]       #Select one subject, one replication

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
boot.rep.loop=floop.repeated(HysteresisData$X, HysteresisData$Y,
n=5,m=3, subjects = HysteresisData$subjects,subjects.in=c("A","C"),
repeated=HysteresisData$repeated,boot=TRUE,seed=123)
boot.rep.loop                 #Gives boot estimates, boot bias, boot SE and boot quartiles
boot.rep.loop$Boot.Estimates  #Lists boot estimates
boot.rep.loop$Boot.Std.Errors #Gives boot standard errors 

par(mfrow=c(2,2))
plot(boot.rep.loop, main='Simulated Rep Boot Loops', values="hysteresis")
par(mfrow=c(1,1))

##Can write results to a file. First set your directory from the file tab.
## Change file path in command below to coincide with where you want to store data files
##setwd("C:/Users/..........................")
##write.table(boot.rep.loop$Boot.Estimates,"Hys.eg.repbootvalues.txt")
##test.floop=read.table("Hys.eg.repbootvalues.txt",header=TRUE)
##head(test.floop)
}
\keyword{ models }

