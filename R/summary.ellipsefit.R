summary.ellipsefit <-
function(g,boot=TRUE,N=1000,studentize=TRUE,center=FALSE,cbb=NULL,joint=FALSE,seed=NULL,...) {
if (!is.null(seed)) set.seed(seed)
thecall <- match.call()
if (boot==TRUE) {
  if (g$method=="harmonic2")
  {res <- harmonic2summary(g,N=N,studentize=studentize,cbb=cbb,joint=joint)}
else if (g$method=="lm")
{res <- lmsummary(g,N=N,studentize=studentize,center=center,cbb=cbb,joint=joint)}
else if (g$method=="direct")
{res <- directsummary(g,N=N,studentize=studentize,center=center,cbb=cbb,joint=joint)}
  else {res <- nlssummary(g,N=N,studentize=studentize,center=center,cbb=cbb,joint=joint,...)}
  res$boot <- TRUE
res$residuals <- sqrt((res$x-res$pred.x)^2+(res$y-res$pred.y)^2)
  res$period.time <- g$period.time
}
else res <- g
res$summarycall <- thecall
  class(res) <- "ellipsesummary"
  res
  }
