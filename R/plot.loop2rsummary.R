plot.loop2rsummary <- function (x,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,main=NULL,...) {
  a <- x
  ti <- (1:101)*pi/50
  ti <- ti + a$values["phase.angle","Boot.Estimate"]
  Ind <- (ti < pi) & (ti > 0)
  if (a$method=="harmonic2") {
  Input <- a$values["b.x","Boot.Estimate"]*cos(ti)+a$values["cx","Boot.Estimate"]
  if (a$extended.classical==FALSE) Output <- a$values["b.y","Boot.Estimate"]*cos(ti)^a$values["n","Boot.Estimate"]+Ind*a$values["retention.above","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+(1-Ind)*a$values["retention.below","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  else Output <- sign(cos(ti))*a$values["b.y","Boot.Estimate"]*abs(cos(ti))^a$values["n","Boot.Estimate"]+Ind*a$values["retention.above","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+(1-Ind)*a$values["retention.below","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  }
  else {
    costp <- cos(ti) 
    sintp <- sin(ti) 
    direc <- sign(costp)
    direcsin <- sign(sintp)
    Input <- a$values["cx","Boot.Estimate"]+a$values["b.x","Boot.Estimate"]*costp 
    Output <- a$values["cy","Boot.Estimate"]+(direcsin < 0)*direcsin*a$values["retention.below","Boot.Estimate"]*abs(sintp)^a$values["m","Boot.Estimate"]+(direcsin > 0)*direcsin*a$values["retention.above","Boot.Estimate"]*abs(sintp)^a$values["m","Boot.Estimate"]+direc*a$values["b.y","Boot.Estimate"]*abs(costp)^a$values["n","Boot.Estimate"]
    
  }
  
  if (is.null(xlim)) xlim <-c(min(c(a$x,Input)),max(c(a$x,Input)))
  if (is.null(ylim)) ylim <- c(min(c(a$y,Output)),max(c(a$y,Output)))                           
plot(Output~Input,type="l",ylim=ylim,xlim=xlim,main=main,...)
  
  points(a$y~a$x,pch=1,cex=0.85)
  if (split.line==TRUE) {
  if (a$extended.classical==FALSE & a$method=="harmonic2") split.line <- a$values["b.y","Boot.Estimate"]*cos(ti)^a$values["n","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  else  split.line <- sign(cos(ti))*a$values["b.y","Boot.Estimate"]*abs(cos(ti))^a$values["n","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  lines(Input,split.line,lty=2)}
  if(putNumber==TRUE) text(a$x,a$y,as.character(format(1:length(a$y),digits=4)))
}
