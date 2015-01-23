\name{plot.fittedloop}
\alias{plot.ellipsefit}
\alias{plot.ellipsesummary}
 \alias{plot.ellipsefitlist}
 \alias{plot.ellipsesummarylist}
 \alias{plot.fittedloop}
 \alias{plot.fittedlooplist}
  \alias{plot.fittedlooplist2r}
 \alias{plot.loopsummary}
 \alias{plot.loopsummarylist}
  \alias{plot.loopsummarylist2r}
  \alias{plot.loop2r}
 \alias{plot.loop2rsummary}
\title{
Plot a fitted ellipse or hysteresis loop.
}
\description{
A scatterplot of x and y fitted with an ellipse or hysteresis loop. Uses objects created by \code{\link{fel}}, \code{\link{summary.ellipsefit}} and \code{\link{floop}}. Can also plot an \code{ellipsefitlist} or \code{ellipsesummarylist} object that contains multiple ellipses.
}
\usage{
\method{plot}{ellipsefit}(x,putNumber=FALSE,values=NULL,
xlim=NULL,ylim=NULL,main=NULL,newPred=TRUE,show=NULL,split.line=FALSE,...)
\method{plot}{ellipsesummary}(x,putNumber=FALSE,values=NULL,
xlim=NULL,ylim=NULL,main=NULL,newPred=TRUE,split.line=FALSE,...)

\method{plot}{ellipsefitlist}(x,main=NULL, values=NULL, ...) 
\method{plot}{ellipsesummarylist}(x,main=NULL, values=NULL, ...) 

\method{plot}{fittedloop}(x,split.line=TRUE,xlim=NULL,
ylim=NULL,putNumber=FALSE,values=NULL,main=NULL,show=NULL,...)
\method{plot}{loopsummary}(x,split.line=TRUE,xlim=NULL,
ylim=NULL,putNumber=FALSE,values=NULL,main=NULL,...)

\method{plot}{fittedlooplist}(x,main=NULL,values=NULL,...)
\method{plot}{loopsummarylist}(x,main=NULL,values=NULL,...)
\method{plot}{fittedlooplist2r}(x,main=NULL,values=NULL,...)
\method{plot}{loopsummarylist2r}(x,main=NULL,values=NULL,...)

\method{plot}{loop2r}(x,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,main=NULL,values=NULL,...)
\method{plot}{loop2rsummary}(x,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,main=NULL,values=NULL,...)

}
\arguments{
  \item{x}{
a fitted ellipse or hysteresis loop created by either \code{\link{fel}}, \code{\link{summary.ellipsefit}} or \code{\link{floop}}.
}
  \item{putNumber}{
optional logical that numbers points from first to last. 
}
  \item{values}{
one of NULL, "hysteresis", "inherent", "derived", "hysteresis.all", "ellipse", or "ellipse.all". Parameter values printed in title. Default is NULL in which case none are printed. See \code{\link{loop.parameters}} or \code{\link{ellipse.parameters}}
}
  \item{xlim}{
limits for x axis.
}
  \item{ylim}{
limits for y axis.
}
  \item{main}{
an overall title for the plot.
}
  \item{newPred}{
draw an ellipse with 100 points. If \code{FALSE} use predicted ellipse from \code{ellipsefit} object which will result in a rougher shape.
}
  \item{show}{
a character vector of parameters to be shown in the plot. 
Possible values are "retention", "coercion", "b.x", "b.y", "semi.major","semi.minor","rote.deg","focus.x",and "focus.y". 
\code{show} is not available for bootstrapped results. 
}
  \item{split.line}{
logical. Whether to include the split line, which is the input output relationship when hysteresis is removed.
}
  \item{\dots}{
Arguments to be passed to \code{\link{plot}}.
}
}

\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}

\seealso{
\code{\link{fel}} for fitting points that form an ellipse and \code{\link{summary.ellipsefit}} for bootstrapping and summarizing an ellipsefit object. Also \code{\link{floop}} and \code{\link{summary.fittedloop}} for fitting and summarizing hysteresis loops more generally.
}
\examples{
##Fit and plot an ellipse
  ellipse1 <- mel(sd.x=0.2,sd.y=0.04)
  ellipse1.fit <- fel(ellipse1$x,ellipse1$y)
plot(ellipse1.fit,main="Simulated Ellipse",xlab="X Input",
ylab="Y Output",show=c("semi.major", "semi.minor"),values="ellipse.all")
### Bootstrapping
  booted.ellipse <- fel(ellipse1$x,ellipse1$y,boot=TRUE, seed=123)
plot(booted.ellipse,xlab="X Input",ylab="Y Output",
main="Simulated Bootstrap Ellipse",values="ellipse")

##Fit and plot a hysteresis loop
  loop1 <- mloop(sd.x=0.05,sd.y=0.05,n=5,m=3)
  loopmodel <- floop(loop1$x,loop1$y,n=5,m=3)
plot(loopmodel,main="Simulated Hysteresis Loop n=5 m=3",
xlab="Input",ylab="Output", values="hysteresis.all")
  booted.loop <- floop(loop1$x,loop1$y,,n=5,m=3,boot=TRUE, seed=1523)
plot(booted.loop,xlab="Input",ylab="Output",
main="Simulated Bootstrapped Loop n=5, m=3",putNumber=TRUE)
plot(booted.loop,main="Simulated Bootstrapped Loop n=5, m=3",
xlab="Input",ylab="Output",values="hysteresis.all")

}
\keyword{ hplot }
