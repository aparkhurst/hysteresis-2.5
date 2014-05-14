plot.loopsummary <- function (x,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,values=NULL,main=NULL,show=NULL,...) {
  a <- x
  ti <- (1:101)*pi/50
  
  if (a$method=="harmonic2") {
  Input <- a$values["b.x","Boot.Estimate"]*cos(ti)+a$values["cx","Boot.Estimate"]
  if (a$extended.classical==FALSE) Output <- a$values["b.y","Boot.Estimate"]*cos(ti)^a$values["n","Boot.Estimate"]+a$values["retention","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  else Output <- sign(cos(ti))*a$values["b.y","Boot.Estimate"]*abs(cos(ti))^a$values["n","Boot.Estimate"]+a$values["retention","Boot.Estimate"]*sin(ti)^a$values["m","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  }
  else {
    costp <- cos(ti) 
    sintp <- sin(ti) 
    direc <- sign(costp)
    direcsin <- sign(sintp)
    Input <- a$values["cx","Boot.Estimate"]+a$values["b.x","Boot.Estimate"]*costp 
    Output <- a$values["cy","Boot.Estimate"]+direcsin*a$values["retention","Boot.Estimate"]*abs(sintp)^a$values["m","Boot.Estimate"]+direc*a$values["b.y","Boot.Estimate"]*abs(costp)^a$values["n","Boot.Estimate"]
    
  }
    if (a$extended.classical==FALSE & a$method=="harmonic2") split.line <- a$values["b.y","Boot.Estimate"]*cos(ti)^a$values["n","Boot.Estimate"]+a$values["cy","Boot.Estimate"]
  else  split.line <- sign(cos(ti))*a$values["b.y","Boot.Estimate"]*abs(cos(ti))^a$values["n","Boot.Estimate"]+a$values["cy","Boot.Estimate"]

  if (is.null(xlim)) xlim <-c(min(c(a$x,Input)),max(c(a$x,Input)))
  if (is.null(ylim)) ylim <- c(min(c(a$y,Output,split.line)),max(c(a$y,Output,split.line)))                           
  if (is.null(values)) plot(Output~Input,type="l",ylim=ylim,xlim=xlim,main=main,...)
  else {
    if (values=="inherent") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Boot.Estimate"],digits=3)," b.y=",format(a$values["b.y","Boot.Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cx=",format(a$values["cx","Boot.Estimate"],digits=3)," cy=",format(a$values["cy","Boot.Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention","Boot.Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Boot.Estimate"],digits=3)," b.y=",format(a$values["b.y","Boot.Estimate"],digits=3)," cx=",format(a$values["cx","Boot.Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cy=",format(a$values["cy","Boot.Estimate"],digits=3)," Area=",format(a$values["area","Boot.Estimate"],digits=3)," Lag=",format(a$values["lag","Boot.Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention","Boot.Estimate"],digits=3)," Coercion=",format(a$values["coercion","Boot.Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis.all") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Boot.Estimate"],digits=3)," b.y=",format(a$values["b.y","Boot.Estimate"],digits=3)," cx=",format(a$values["cx","Boot.Estimate"],digits=3)," cy=",format(a$values["cy","Boot.Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("Area=",format(a$values["area","Boot.Estimate"],digits=3)," Lag=",format(a$values["lag","Boot.Estimate"],digits=3)," Retention=",format(a$values["retention","Boot.Estimate"],digits=3)," Split Angle=",format(a$values["split.angle","Boot.Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Coercion=",format(a$values["coercion","Boot.Estimate"],digits=3)," Hysteresis x=",format(a$values["hysteresis.x","Boot.Estimate"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y","Boot.Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
  
  if (values=="derived") {
    plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
    title(line=3, paste(main),cex=1.2)
    mtext(paste(
      "Coercion=",format(a$values["coercion","Boot.Estimate"],digits=3)," Area=",format(a$values["area","Boot.Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
    mtext(paste("Lag=",format(a$values["lag","Boot.Estimate"],digits=3)," Split Angle=",format(a$values["split.angle","Boot.Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
    mtext(paste("Hysteresis x=",format(a$values["hysteresis.x","Boot.Estimate"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y","Boot.Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
  }
  }
  
  if (any(show %in% c("b.x","b.y"))) segments(a$values["cx","Boot.Estimate"],a$values["cy","Boot.Estimate"],a$values["cx","Boot.Estimate"]+a$values["b.x","Boot.Estimate"],a$values["cy","Boot.Estimate"]+a$values["b.y","Boot.Estimate"],col="blue")
  if (any(show=="retention")) segments(a$values["cx","Boot.Estimate"],a$values["cy","Boot.Estimate"],a$values["cx","Boot.Estimate"],a$values["cy","Boot.Estimate"]+a$values["retention","Boot.Estimate"],col="purple")
  if (any(show=="coercion")) segments(a$values["cx","Boot.Estimate"],a$values["cy","Boot.Estimate"],a$values["cx","Boot.Estimate"]+a$values["coercion","Boot.Estimate"],a$values["cy","Boot.Estimate"],col="green")
  
  
  points(a$y~a$x,pch=1,cex=0.85)
  if (split.line==TRUE) {

  lines(Input,split.line,lty=2)}
  if(putNumber==TRUE) text(a$x,a$y,as.character(format(1:length(a$y),digits=4)))
}
