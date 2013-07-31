\name{residuals.ellipsefit}
\alias{residuals.ellipsefit}
\alias{residuals.ellipsesummary}
\alias{residuals.fittedloop}
\alias{residuals.loopsummary}
\alias{residuals.ellipsefitlist}
\alias{residuals.ellipsesummarylist}
\alias{residuals.fittedlooplist}
\alias{residuals.loopsummarylist}
\alias{rstudent.ellipsefit}
\alias{rstudent.ellipsesummary}
\alias{rstudent.fittedloop}
\alias{rstudent.loopsummary}
\alias{rstudent.ellipsefitlist}
\alias{rstudent.ellipsesummarylist}
\alias{rstudent.fittedlooplist}
\alias{rstudent.loopsummarylist}
\alias{fitted.ellipsefit}
\alias{fitted.ellipsesummary}
\alias{fitted.fittedloop}
\alias{fitted.loopsummary}
\alias{fitted.ellipsefitlist}
\alias{fitted.ellipsesummarylist}
\alias{fitted.fittedlooplist}
\alias{fitted.loopsummarylist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Extract input, output, geometric and algebraic residuals and fitted values from fitted loops or ellipses. 
}
\usage{
##S3 methods for classes 'ellipsefit', 'ellipsesummary', 'fittedloop', 'loopsummary','ellipsefitlist', 'ellipsesummarylist', 'fittedlooplist' and 'loopsummarylist'.
residuals(g)
rstudent(g)
fitted(g)
}
\arguments{
  \item{g}{
an object created by \code{\link{fel}} or \code{\link{floop}}.
}
}
\details{
Geometric residuals are based on the straight line distance between predicted and true values along an x,y cartesian plane, and algebraic residuals are based on the method used to calculate the \code{ellipsefit} object. 
If method="harmonic2" (which is always the case if this is a \code{fittedloop} object) or if bootstrapping has occurred, then, there are no algebraic residuals and \code{residuals.ellipsefit} replaces these with the geometric residuals.

Studentization for the \code{rstudent} function is performed as if method="harmonic2" regardless of the method used for fitting the ellipse/loop. Therefore, unless method="harmonic2" and no bootstrapping is performed, these are pseudo-studentized residuals, not true studentized residuals. This is internal scaling studentization. Studentization for bootstrapping in the functions \code{\link{summary.ellipsefit}}/\code{\link{summary.fittedloop}} differs from the studentization performed by \code{rstudent} in that it only accounts for the influence matrix and does not divide by the standard deviation. 
}
\value{
  \item{input}{a numeric vector. Observed input - fitted input for residuals.}
  \item{output}{a numeric vector. Observed output - fitted output for residuals.}
  \item{geometric}{a numeric vector. Not available with rstudent. See details.}
  \item{algebraic}{a numeric vector. Not available with rstudent or when the 'harmonic2' method is used. See details.}
}
\references{
Yang, F. and A. Parkhurst, Estimating Elliptical Hysteresis: A Comparison of Analytic Methods. (submitted)
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{fel}}, \code{\link{floop}}, \code{\link{summary.ellipsefit}} and \code{\link{summary.fittedloop}}.
}
\examples{
##For multiple loops/ellipses
data(HysteresisData)
Mloopmodels.rep <- floop.repeated(HysteresisData$X, HysteresisData$Y, n=5,m=3, subjects = HysteresisData$subjects,subjects.in=c("A","C"),repeated=HysteresisData$repeated)
Mloopmodels.rep                #Gives estimates and delta standard errors
residuals(Mloopmodels.rep)  #$input $output $geometric 
fitted(Mloopmodels.rep)     #$input $output
scatterplotMatrix(cbind(residuals(Mloopmodels.rep)$input,residuals(Mloopmodels.rep)$output,residuals(Mloopmodels.rep)$geometric,fitted(Mloopmodels.rep)$input,fitted(Mloopmodels.rep)$output),
  main='Residuals for Multiple Hysteresis Loops',smooth=FALSE,var.labels=c("Input Resid","Output Resid","Geometric Resid", "Fitted Input", "Fitted Output"),groups=residuals(Mloopmodels.rep)$repeated)
rstudent(Mloopmodels.rep)  #$input $output
scatterplotMatrix(cbind(rstudent(Mloopmodels.rep)$input,rstudent(Mloopmodels.rep)$output,fitted(Mloopmodels.rep)$input,fitted(Mloopmodels.rep)$output),
                  main='Studentized Residuals for Multiple Hysteresis Loops',smooth=FALSE,var.labels=c("Input Resid","Output Resid", "Fitted Input", "Fitted Output"),groups=residuals(Mloopmodels.rep)$repeated)

##For single Ellipse
ellipse1 <- mel(sd.x=0.2,sd.y=0.04)
ellipse1.fit <- fel(ellipse1$x,ellipse1$y)
residuals(ellipse1.fit)
fitted(ellipse1.fit)
scatterplotMatrix(cbind(residuals(ellipse1.fit)$input,residuals(ellipse1.fit)$output,residuals(ellipse1.fit)$geometric,fitted(ellipse1.fit)$input,fitted(ellipse1.fit)$output),
                  main='Residuals for Simulated Ellipse',smooth=FALSE,var.labels=c("Input Resid","Output Resid","Geometric Resid", "Fitted Input", "Fitted Output"))

rstudent(ellipse1.fit) #for input and output variables
scatterplotMatrix(cbind(rstudent(ellipse1.fit)$input,rstudent(ellipse1.fit)$output,fitted(ellipse1.fit)$input,fitted(ellipse1.fit)$output),
                  main='Studentized Residuals for Simulated Ellipse',smooth=FALSE,var.labels=c("Input Resid","Output Resid","Fitted Input", "Fitted Output"))

plot(ellipse1.fit$pred.y,rstudent(ellipse1.fit)$output,xlab="Fitted Output",ylab="Output Studentized Residuals",main="Studentized Residuals:Simulated Ellipse")
abline(h = 0, lty = 2, col = "gray")
qqnorm(rstudent(ellipse1.fit)$output,sub='Output Studentized Residuals Simulated Ellipse')
qqline(rstudent(ellipse1.fit)$output,col="red") #q-q line
}
\keyword{ models }

