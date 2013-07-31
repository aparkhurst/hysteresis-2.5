print.ellipsefit <- function(g,...) {
  cat("Call:\n")
  print(g$call)
  Td <- qt(0.975,g$fit.statistics["d.f."]) 
  if (g$method!="direct") {
  cat("\nDelta Method Standard Errors and 95% C.I.'s:\n")
  error <- g$Std.Errors
  theEstimates <- g$values[names(error)]
  low2 <- theEstimates-error*Td
  high2 <- theEstimates+error*Td
  print(cbind("Estimates"=theEstimates,
              "S.E."=error,"low"=low2,"high"=high2),digits=4) }
  else {
    cat("\nEstimates:\n")
    print(g$values)
  }
invisible(g)}
