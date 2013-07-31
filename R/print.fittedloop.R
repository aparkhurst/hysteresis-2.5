print.fittedloop <- function (g) {
  cat("Call:\n")
  print(g$call)
  cat("Estimates and Delta Method Standard Errors:\n")
  print(cbind("Estimates"=g$values,"Std.Errors"=g$Std.Errors))
}
