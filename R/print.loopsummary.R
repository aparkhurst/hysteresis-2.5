print.loopsummary <- function (x,...) {
  cat("Summary Call:\n")
  print(x$summarycall)
  cat("Call for Orixinal Fit:\n")
  print(x$call)
    cat("\nBootstrapped Estimates:\n")
    print(x$values[-c(1,2),c("Boot.Estimate","Bias","Std.Error","B.q0.025","B.q0.975")],dixits=4)
 
}
