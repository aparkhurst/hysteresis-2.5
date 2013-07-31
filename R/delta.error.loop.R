delta.error.loop <- function(g) {
  z <- g$fit[[1]]
  rss <- sum(z$residuals^2)
  p <- z$rank
  p1 <- 1L:p
  resvar1 <- rss/z$df.residual  
  R1 <- chol2inv(z$qr$qr[p1, p1, drop = FALSE])
  se1 <- sqrt(diag(R1) * resvar1)
  
  
  z2 <- g$fit[[2]]
  rss <- sum(z2$residuals^2)
  p <- z2$rank
  p1 <- 1L:p
  resvar2 <- rss/z2$df.residual  
  R2 <- chol2inv(z2$qr$qr[p1, p1, drop = FALSE])
  se2 <- sqrt(diag(R2) * resvar2)
  
  cov.Ta<- R1*resvar1
  cov.Tb<- R2*resvar2
  
  cov.matrix <- cbind(rbind(cov.Ta,matrix(0,3,3)),rbind(matrix(0,3,3),cov.Tb))
  
  b.xSE<-deltamethod(~sqrt(x2^2+x3^2),c(z$coefficients,z2$coefficients), cov.matrix)
  phase.angleSE<-deltamethod(~atan(x3/x2),c(z$coefficients,z2$coefficients), cov.matrix)

  if (g$values["n"]==1) splitSE <-   deltamethod(~atan(x6/sqrt(x2^2+x3^2)),c(z$coefficients,z2$coefficients), cov.matrix)*180/pi
else splitSE <- NA
  hysteresis.ySE <- deltamethod(~x5/x6,c(z$coefficients,z2$coefficients), cov.matrix)
  m <- g$values["m"]
  form <- sprintf("~1/sqrt(1+(x6/x5)^(2/%f))",m)
  hysteresis.xSE<-deltamethod(as.formula(form),c(z$coefficients,z2$coefficients), cov.matrix)
  
  coercionform <- sprintf("~sqrt(x2^2+x3^2)/sqrt(1+(x6/x5)^(2/%f))",m)
  coercionSE<-deltamethod(as.formula(coercionform),c(z$coefficients,z2$coefficients), cov.matrix)
  lagSE <- deltamethod(~atan(x5/x6),c(z$coefficients,z2$coefficients), cov.matrix)*g$period/(2*pi)
  leftpart <- (0.5/(beta((m + 3)/2, (m + 3)/2) * (m + 2)) + 1/beta((m + 
          1)/2, (m + 1)/2) - 1/beta((m + 3)/2, (m - 1)/2))/(2^m) * pi
  form <- sprintf("~%f * x5* atan(x3/x2)",leftpart)
  areaSE <-   deltamethod(as.formula(form),c(z$coefficients,z2$coefficients), cov.matrix)

  SEs<- list("n"=NA,"m"=NA,"b.x"=b.xSE,"b.y"=se2[3],"phase.angle"=phase.angleSE,
             "cx"=se1[1],"cy"=se2[1],"retention"=se2[2],"coercion"=coercionSE,"area"=areaSE,"lag"=lagSE, "split.angle"=splitSE,"hysteresis.x"=hysteresis.xSE,"hysteresis.y"=hysteresis.ySE)
  SEs
}
