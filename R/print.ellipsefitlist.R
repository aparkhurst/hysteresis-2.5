print.ellipsefitlist <- function(g,...) {
  cat("Call:\n")
  print(attr(g,"call"))
  cat("\nParameter Estimates:\n")
print(g$Estimates,digits=4)
  
cat("\nDelta Method Standard Errors:\n")
print(g$Std.Errors,digits=4)
invisible(g)}
