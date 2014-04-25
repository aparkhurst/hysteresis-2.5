print.loop2r <- function (x,...) {
  cat("Call:\n")
  print(x$call)
  cat("Estimates:\n")
  print(cbind("Estimates"=x$values))
}
