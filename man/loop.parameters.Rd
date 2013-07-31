\name{loop.parameters}
\alias{loop.parameters}
\alias{ellipse.parameters}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Inherent and Derived Parameter Definitions for Hysteresis Loops/Ellipses
}
\description{
\code{\link{floop}} returns a \code{fittedloop} object and calculates a variety of hysteresis loop parameters. This is a list of definitions for these parameters, as well as some only available for ellipses through \code{\link{fel}}. The generalized transcendental equations used to fit these loops are \deqn{x_t=b.x*cos(2pi*t/period+phase.angle)+cx+e_{x,t}} \deqn{y_t=b.y*cos(2pi*t/period+phase.angle)^n+retention*sin(2pi*t/period+phase.angle)^m+cy+e_{y,t}}  where \deqn{t=0,...,n.points-1 if times='equal'}
}

\value{
Specified loop parameters.
  \item{n}{
Positive integer for the split line parameter. If n=1, split line is linear; If n is even, split line has a u shape; If n is odd and higher than 1, split line has a chair or classical shape.
}
  \item{m}{
Positive odd integer for the bulging parameter, indicates degree of outward curving (1=highest level of bulging).
}
Inherent Parameters
  \item{b.x}{
saturation point x coordinate. Horizontal distance from the center to the maximum value of the input.
}
  \item{b.y}{
saturation point y coordinate. Vertical distance from the center to the point where the input is at its maximum.
}
  \item{phase.angle}{
defines the starting point of the loop. The initial angle of the input function at its origin.
}
  \item{cx}{
center of input x.
}
  \item{cy}{
center of output y.
}
  \item{retention}{
split point, representing vertical distance from center to upper loop trajectory. It is the intersection of the loop and the output axis characterizing the distortion in the response at the average input challenge.
}
Derived Hysteresis Parameters
  \item{coercion}{
  the horizontal distance of the input from the center. It indicates the strain the forcing function places on the output. It is the positive root of intersection between the loop and input axis.
  }
  \item{area}{
  the area of the hysteresis loop. Can indicate the work done during one cycle or period.
  }
  \item{lag}{
  lag indicates the delay between attributes of the output and the input (such as peak to peak for the ellipse when m=1, n=1).
  }
  \item{split.angle}{
  beta, the angle between the tangent to the un-split curve at the center and the input axis.
  }
  \item{hysteresis.x}{
  hysteresis along the input axis. The proportion of coercion due to input saturation b.x.
  }
  \item{hysteresis.y}{
  hysteresis along the output axis. The proportion of retention due to b.y.
  }
Ellipse Parameters
 \item{ampx}{
 Amplitude of the input, equal to b.x.
 }
 \item{ampy}{
 Amplitude of the output.
 }
  \item{rote.deg and rote.rad}{
  theta, counter clockwise angle of rotation between the input axis and the semi-major axis of the loop.In degrees and radians respectively.
  }
  \item{semi.major}{
  half major axis of ellipse, maximum distance from center to perimeter of ellipse.
  }
  \item{semi.minor}{
  half minor axis of ellipse, shortest distance from center to perimeter of ellipse. 
  }
  \item{focus.x, focus.y}{
input x and output y distances of focus points from center.
  }
   \item{eccentricity}{
Measure of deviation from circle. Zero indicate no deviation from circle.
\deqn{\sqrt{\frac{semi.major^2-semi.minor^2}/{semi.major^2}}}
  }
}
\references{
Lapshin, R. (1995) Analytical model for the approximation of hysteresis loop and its application to the scanning tunneling microscope.
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}
\seealso{
\code{\link{mloop}} for simulating a hysteresis loop and \code{\link{floop}} for fitting a hysteresis loop.   
}
\examples{
theloop<-mloop(sd.x=0.05,sd.y=0.05,n=2,m=3)
loopmodel<-floop(theloop$x,theloop$y,n=2,m=3)
loopmodel
plot(loopmodel,main="Hysteresis Loop n=2 m=3",values="hysteresis")

#Ellipse Parameters
ellipse.eig <- mel(semi.major=7,semi.minor=4,rote.deg=30)
ellip.eigen.fit <- fel(ellipse.eig$x,ellipse.eig$y)
ellip.eigen.fit$Estimates
plot(ellip.eigen.fit,main="Ellipse from Eigenvalue Parameters",show=c("semi.major","semi.minor","rote.deg"),values="ellipse")
}
\keyword{ models }
