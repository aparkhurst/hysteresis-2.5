print.loopsummarylist <-
  function(g,...) {
    cat("Summary Call:\n")
    print(g$summarycall)
    cat("Call for Original Fit:\n")
    print(g$models[1][[1]]$call)
    if (g$models[1][[1]]$boot==TRUE) {
      cat("\nBootstrapped Value Estimates:\n")
      subjectlen <- length(colnames(g$values))-12
      print(g$values[,c(subjectlen+1, 1:subjectlen,subjectlen+12,subjectlen+11,subjectlen+8,subjectlen+3,subjectlen+7)],digits=4)
       }
    else {
      Td <- qt(0.975,sapply(g$models,function (x) x$fit.statistics["d.f."])) 
      error <- g$Std.Error
      thevalues <- c(g$values)[names(error)]
      low2 <- thevalues-t(t(error)*Td)
      high2 <- thevalues+t(t(error)*Td)
      cat("\nEstimates:\n")
      print(thevalues)
      cat("\nDelta Method Standard Errors:\n")
      print(error)
      cat("\nDelta Method 2.5% Quantiles:\n")
      print(low2)
      cat("\nDelta Method 97.5% Quantiles:\n")
      print(high2)
    }
    ## cat("\nFit Statistics:\n")
    ## print(g$fit.statistics,digits=4)
    invisible(g)}
