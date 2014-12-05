\name{floopReflect}
\alias{floopReflect}
\alias{felReflect}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fitting hysteresis loops for reflected data
}
\description{
Fits hysteresis loops and ellipses where x and y are flipped and reversed}
\usage{
floopReflect(x,y,...)
felReflect(x,y,...)
}
\arguments{
  \item{x}{
the numeric input vector. To fit the loop x is reversed and treated as y.
}
  \item{y}{
the numeric output vector. To fit the loop y is reversed and treated as x.
}
  \item{...}{
other arguments to either \code{\link{floop}} or \code{\link{fel}}.
}
}
\details{
A reflected hysteresis loop is one where the output and input are flipped and placed in reverse order.

}
\value{
See \code{\link{floop}} or \code{\link{fel}}.
}
\references{
Yang, F. and A. Parkhurst, Estimating Elliptical Hysteresis: A Comparison of Analytic Methods. (submitted)
}
\author{
Spencer Maynes, Fan Yang, and Anne Parkhurst.
}

\keyword{ models }

