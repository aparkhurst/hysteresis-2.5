\name{mloop}
\alias{mloop}
\alias{mloop2r}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Simulate (Make) a Hysteresis Loop
}
\description{
Simulate a hysteresis loop with a variety of possible parameters.
}
\usage{
mloop(cx = 0, cy = 0, retention = 0.2, b.x = 0.6, b.y = 0.8,n = 1, m = 1, 
     sd.x = 0, sd.y = 0, phase.angle = 0, n.points = 24, 
    period = 24,extended.classical=FALSE,seed=NULL)  
mloop2r(cx=0,cy=0,retention.above=0.2,retention.below=0.15,b.x=0.6,b.y=0.8,n=1,m=1,sd.x=0,sd.y=0,phase.angle=0,n.points=24,period=24,extended.classical=FALSE,seed=NULL)
}

\arguments{
  \item{n}{
Positive integer for the split line parameter. If n=1, split line is linear; If n is even, split line has a u shape; If n is odd and higher than 1, split line has a chair or classical shape.
}
  \item{m}{
Positive odd integer for the bulging parameter, indicates degree of outward curving (1=highest level of bulging). 
}
  \item{b.x}{
number. Saturation point x coordinate. Horizontal distance from the center to the maximum value of the input challenge.
}
  \item{b.y}{
number. Saturation point y coordinate. Vertical distance from the center to the point where the input is at its maximum. 
}
  \item{phase.angle}{
number in degrees. Defines the starting point of the loop. The initial angle of the input function at its origin. 
}  
  \item{cx}{
number. Center of input x.
}
  \item{cy}{
number. Center of output y.
}
  \item{retention}{
number. Split point, represents vertical distance from center to upper loop trajectory. 
It is the intersection of the loop and the output axis characterizing the distortion in 
the response at the average input challenge. Assumes symmetrical curve above and below split line.
}
  \item{retention.above}{
number. Retention above the split line. \code{mloop2r} creates a loop where retention above and below the split line may be different.
}
  \item{retention.below}{
number. Retention below the split line.
}
  \item{sd.x}{
number. Standard deviation of the normally distributed variation in the input vector x. }
  \item{sd.y}{
number. Standard deviation of the normally distributed variation in the output vector y. }

  \item{n.points}{
number of points on loop.
} 
  \item{period}{
number of equally spaced points required to make a full loop.
}
  \item{extended.classical}{
logical. If true, fit a classical hysteresis loop regardless of n. Uses \deqn{y_t=sign(cos(2*pi*t/period))*b.y*abs(cos(2*pi*t/period))^n + retention*sin(2*pi*t/period)^m+cy+e_{y,t}} instead of 
\deqn{y_t=b.y*cos(2*pi*t/period)^n+retention*sin(2*pi*t/period)^m+cy+e_{y,t}}
Allows the user to fit classical loops with any n>1 instead of just odd numbered n. Default is false.
}
  \item{seed}{
integer. Starting seed.
}
}
\details{
Simulates input and output variables x and y that form a hysteresis loop of the form \deqn{x_t=b.x*cos(2pi*t/period+phase.angle)+cx+e_{x,t}} \deqn{y_t=b.y*cos(2pi*t/period+phase.angle)^n+retention*sin(2pi*t/period+phase.angle)^m+cy+e_{y,t}}  where \deqn{t=0,...,n.points-1 if times='equal'} and the error terms e are normally distributed. Also produces a vector of derived values.}
\value{
mloop returns an object of class \code{hysteresisloop}.
  \item{values}{estimated values of various coefficients and derived parameters of the hysteresis loop. See \code{\link{loop.parameters}}}
  \item{x}{the input x.}
  \item{y}{the output y.}
}
\references{
Lapshin, R. (1995) Analytical model for the approximation of hysteresis loop and its application to the scanning tunneling microscope.
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
Fit a hysteresis loop with the function \code{\link{floop}}.
}
\examples{
#Simulate a loop with n=3, m=1, retention=0.9
loop1 <- mloop(cx=5,cy=8,retention=0.9,sd.x=0.01,sd.y=0.05,n=3,m=1)
loopmodel <- floop(loop1$x,loop1$y,n=3,m=1)
loopmodel 
##Plot hysteresis loop.
plot(loopmodel,main="Simulated Hysteresis Loop n=3 m=1",xlab="Input",
ylab="Output",values="hysteresis.all")

}
\keyword{ models }

