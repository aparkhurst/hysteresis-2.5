\name{fel.repeated}
\alias{fel.repeated}
\alias{summary.ellipsefitlist}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Methods for easily fitting multiple ellipses from repeated measures designs.
}  
\description{
Fit a sinusoidal hysteretic process between an input and an output variable across multiple loops separated by subjects and repeated.
}
\usage{
fel.repeated(x,y=NULL,subjects=NULL,repeated=NULL,subjects.in="all",repeated.in="all",...)
\method{summary}{ellipsefitlist}(object,N=1000,boot=TRUE,seed=NULL,...)


}
\arguments{
  \item{x}{
numeric input vector.
}
  \item{y}{
numeric output vector.
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
an \code{ellipsefitlist} object.
}
   \item{N}{
Number of bootstrap replicates.
}
   \item{boot}{
whether to use bootstrapping to obtain standard errors and less biased parameter estimates.
}
   \item{seed}{
for generating random numbers. See \code{\link{summary.fittedloop}}.
}
  \item{...}{
extra arguments to either \code{\link{fel}} or \code{\link{summary.ellipsefitlist}.}
}
}
\details{
Fits multiple ellipses with one call, separated by the factors \code{subjects} and \code{repeated}. The arguments \code{subjects.in} and \code{repeated.in} are used to select subsets of the factors \code{subjects} and \code{repeated}.
}
\value{
\code{fel.repeated} returns an object of class \code{ellipsefitlist}.
    \item{models}{Separate model fits for each ellipse, see \code{\link{fel}}.}
    \item{Estimates}{Parameter estimates for all ellipses in matrix form.}
    \item{Std.Errors}{Delta standard errors for all ellipses in matrix form.}
    When \code{boot=TRUE} \code{\link{fel.repeated}} returns an object of class \code{ellipsesummarylist} which consists of
    \item{models}{ a vector of separate model summaries for each ellipse, see \code{\link{summary.ellipsefit}}.}
    \item{values}{Bootstrapped parameter estimates, standard errors, quantiles, and more for each ellipse.}
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
\code{\link{fel}} for a more general way to fit multiple ellipses, or for fitting just one ellipse. \code{\link{plot.ellipsefit}} for plotting and \code{\link{summary.ellipsefit}} for summarizing and bootstrapping an \code{ellipsefitlist} object. Also \code{\link{residuals.ellipsefitlist}}.
}
\examples{
## Select 2 subjects with 2 replications and fit 4 ellipses
data(EllipseData) 
emodels.rep <- fel.repeated(EllipseData$X, EllipseData$Y, method = "harmonic2", 
subjects = EllipseData$subjects,subjects.in=c("A","C"),
repeated=EllipseData$repeated)
emodels.rep                #Gives estimates and delta standard errors 
emodels.rep$Estimates      #List estimates only
emodels.rep$Std.Errors     #List delta standard errors 
par(mfrow=c(2,2))
plot(emodels.rep, main="Repeated Ellipses",xlab="X",ylab="Y")
par(mfrow=c(1,1))

### Bootstrap estimates and standard errors (Seed is necessary if want to reproduce results)
boot.rep.ellipse<-fel.repeated(EllipseData$X,EllipseData$Y,method = "harmonic2",
subjects = EllipseData$subjects,subjects.in=c("A","C"),
repeated=EllipseData$repeated,boot=TRUE,seed=123)
boot.rep.ellipse  #Gives boot estimates, boot bias, boot SE and boot quartiles
par(mfrow=c(2,2))
plot(boot.rep.ellipse, main="Repeated Ellipses",xlab="X",ylab="Y",values="ellipse")
par(mfrow=c(1,1))

##Can write results to a file. First set your directory from the file tab.
#Change file path in command below to coincide with where you want to store data files
#setwd("C:/Users................")
#write.table(boot.rep.ellipse$Boot.Estimates,"Ellipes.eg.repbootvalues.txt")
#test.fel=read.table("Ellipes.eg.repbootvalues.txt",header=TRUE)
#head(test.fel)
}
\keyword{ models }

