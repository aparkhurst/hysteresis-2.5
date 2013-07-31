print.loopsummary <- function (g) {
  cat("Summary Call:\n")
  print(g$summarycall)
  cat("Call for Original Fit:\n")
  print(g$call)
    cat("\nBootstrapped Estimates:\n")
    print(g$values[-c(1,2),c("Boot.Estimate","Bias","Std.Error","B.q0.025","B.q0.975")],digits=4)
 
}
