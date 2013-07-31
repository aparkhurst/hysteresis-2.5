print.ellipsesummarylist <-
  function(g,...) {
    cat("Summary Call:\n")
    print(g$summarycall)
    cat("Call for Original Fit:\n")
    print(g$models[1][[1]]$call)
    cat("Ellipse Fitting Method:\n")
    print(g$models[1][[1]]$method)
    if (g$models[1][[1]]$method=="harmonic2") print("Two step simple harmonic least squares")
    else if (g$models[1][[1]]$method=="nls") print("Non-linear least squares")
    else if (g$models[1][[1]]$method=="direct") print("Direct specific least squares")
    else print("Linear Least Squares")
    if (g$models[1][[1]]$boot==TRUE) {
      cat("\nBootstrapped Value Estimates:\n")
      subjectlen <- length(colnames(g$values))-11
      print(g$values[g$values[,"Parameter"] %in% c("b.x","b.y",
                                                   "cx","cy","retention","coercion","area",
                                                   "lag","split.angle","hysteresis.x","hysteresis.y","ampx","ampy","rote.deg",
                                                   "semi.major","semi.minor","focus.x","focus.y","eccentricity"),c(subjectlen+1, 1:subjectlen,subjectlen+11,subjectlen+10,subjectlen+8,subjectlen+3,subjectlen+7)],digits=4)
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
