geom_ellipse <- function(model,control) {
  pars <- c(model$period.time,model$values["rote.rad"],model$values["semi.major"],model$values["semi.minor"],model$values["cx"],model$values["cy"])
  x <- model$x
  y <- model$y
  n <- length(x)
  x_resid <- x-pars[n+4]-pars[n+2]*cos(pars[n+1])*cos(pars[1:length(x)])+pars[n+3]*sin(pars[n+1])*sin(pars[1:length(x)])
  y_resid <- y-pars[n+5]-pars[n+2]*sin(pars[n+1])*cos(pars[1:length(x)])-pars[n+3]*cos(pars[n+1])*sin(pars[1:length(x)])
  SSE <- crossprod(x_resid) + crossprod(y_resid)
  SSEratio <- 2
  i=0
  while (SSEratio > control | SSEratio < 1) {
    iter.step <- geom_step(pars,x_resid,y_resid,n)
    pars <- iter.step[[1]]
    x_resid <- x-pars[n+4]-pars[n+2]*cos(pars[n+1])*cos(pars[1:length(x)])+pars[n+3]*sin(pars[n+1])*sin(pars[1:length(x)])
    y_resid <- y-pars[n+5]-pars[n+2]*sin(pars[n+1])*cos(pars[1:length(x)])-pars[n+3]*cos(pars[n+1])*sin(pars[1:length(x)])
    SSEold <- SSE
    SSE <- crossprod(x_resid) + crossprod(y_resid)
    SSEratio <- SSEold/SSE
    i=i+1
  }
  list("period.time"=as.vector(pars)[1:n],"values"=as.vector(pars)[(n+1):(n+5)],x_resid,y_resid,SSE,"iterations"=i,"hessian"=iter.step[2])
}