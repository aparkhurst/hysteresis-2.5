plot.splitloop <- function (x,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,main=NULL,...) {
  a <- x
  ti <- (1:101)*pi/50
  ti2 <- ti + a$values["phase.angle"]
  if (method="harmonic2") {
  Ind <- (ti2 < pi) & (ti2 > 0)
  Input <- a$values["b.x"]*cos(ti2)+a$values["cx"]
  if (a$extended.classical==FALSE) Output <- a$values["b.y"]*cos(ti2)^a$values["n"]+Ind*a$values["retention.above"]*sin(ti2)^a$values["m"]+(1-Ind)*a$values["retention.below"]*sin(ti2)^a$values["m"]+a$values["cy"]
  else Output <- sign(cos(ti2))*a$values["b.y"]*abs(cos(ti2))^a$values["n"]+Ind*a$values["retention.above"]*sin(ti2)^a$values["m"]+(1-Ind)*a$values["retention.below"]*sin(ti2)^a$values["m"]+a$values["cy"]
  }
  else {
    costp <- cos(ti) 
    sintp <- sin(ti) 
    direc <- sign(costp)
    direcsin <- sign(sintp)
    Input <- a$values["cx"]+a$values["b.x"]*costp 
    Output <- a$values["cy"]+(direcsin < 0)*direcsin*a$values["retention.below"]*abs(sintp)^a$values["m"]+(direcsin > 0)*direcsin*a$values["retention.above"]*abs(sintp)^a$values["m"]+direc*a$values["b.y"]*abs(costp)^a$values["n"]
    
  }
  if (is.null(xlim)) xlim <-c(min(c(a$x,Input)),max(c(a$x,Input)))
  if (is.null(ylim)) ylim <- c(min(c(a$y,Output)),max(c(a$y,Output)))                           
 plot(Output~Input,type="l",ylim=ylim,xlim=xlim,main=main,...)
 
  points(a$y~a$x,pch=1,cex=0.85)
  if (split.line==TRUE) {
  if (a$extended.classical==FALSE & method=="harmonic2") split.line <- a$values["b.y"]*cos(ti2)^a$values["n"]+a$values["cy"]
  else split.line <- sign(cos(ti))*a$values["b.y"]*abs(cos(ti2))^a$values["n"]+a$values["cy"]
  lines(Input,split.line,lty=2)}
  if(putNumber==TRUE) text(a$x,a$y,as.character(format(1:length(a$y),digits=4)))
}
