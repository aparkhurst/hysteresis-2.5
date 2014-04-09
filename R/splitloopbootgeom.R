splitloopbootgeom <-
  function(j=NULL,pred.x,pred.y,xresid,yresid,ti,obs,n,m,extended.classical,cbb,joint,period){
    if (is.numeric(cbb)==TRUE) {
      index <- sample(1:(obs+3),3,replace=FALSE)
      index2 <- sample(1:(obs+3),5,replace=FALSE)
      xresid2 <- c(xresid,xresid)
      yresid2 <- c(yresid,yresid)
      k <- round(obs/cbb)
      k2 <- round((obs-2)/cbb) #Round so not exact if obs/cbb and obs-2/cbb aren't integers.
      xblocks <- sample(1:(obs+3),k,replace=TRUE)
      if (joint==FALSE) yblocks <- sample(1:(obs+3),k2,replace=TRUE)
      else yblocks <- xblocks[1:k2]
      xressamp <- c(t(outer(xblocks,0:(cbb-1),FUN="+")))
      yressamp <- c(t(outer(yblocks,0:(cbb-1),FUN="+")))
      y<-yresid2[yressamp]+pred.y[-index]
      x<-xresid2[xressamp]+pred.x[-index2]
    }
    else {  
      index <- sample(1:(obs+3),3,replace=FALSE)
      if (joint==FALSE) {
    y<-sample(yresid,obs,replace=T)+pred.y[-index]
    x<-sample(xresid,obs,replace=T)+pred.x[-index]
      }
      else {
        resid.sampler <- sample(1:(obs+3),obs,replace=TRUE)
        y<-yresid[resid.sampler]+pred.y[-index]
        x<-xresid[resid.sampler]+pred.x[-index]
      }
    }
    
    midspread <- 2*pi/length(x)
    mod <- optim(par=c("t"=rep(2*pi/length(x),length(x)),"cx"=0,"cy"=0,"b.x"=diff(range(x))/2,"b.y"=diff(range(y))/2,"logm"=0,
                       "logn"=0,"retention.above"=0,"retention.below"=0),fn=floopCauchyLoss2r,x=x,y=y,
                 midspread=midspread,method="BFGS",hessian=TRUE)
    par <- mod$par
    times <- par[1:length(x)]
    cx <- par[length(x)+1]
    cy <- par[length(x)+2]
    b.x <- par[length(x)+3]
    b.y <- par[length(x)+4]
    logm <- par[length(x)+5]
    logn <- par[length(x)+6]
    retention.above <- par[length(x)+7]
    retention.below <- par[length(x)+8]
    phase.angle=times[1]
    m <- exp(logm)
    n <- exp(logn)
    if (n==1) beta.split.angle<-atan2(b.y,b.x)*180/pi 
    else if (n >= 2) beta.split.angle <- 0
    else beta.split.angle<-NA
    hysteresis.x.above <- 1/sqrt(1+(b.y/retention.above)^(2/m))
    hysteresis.x.below <- 1/sqrt(1+(b.y/retention.below)^(2/m))
    coercion.above <- hysteresis.x.above*b.x
    coercion.below <- hysteresis.x.below*b.x
    hysteresis.y.above <- retention.above/b.y
    hysteresis.y.below <- retention.below/b.y
    area <- (0.5/(beta((m+3)/2,(m+3)/2)*(m+2))+1/beta((m+1)/2,(m+1)/2)-1/beta((m+3)/2,(m-1)/2))/(2^m)*pi*abs((retention.above+retention.below)*b.x)/2
    lag.above<-abs(atan2(retention.above,b.y))*period/(pi*2)
    lag.below<-abs(atan2(retention.below,b.y))*period/(pi*2)
    z <- c("n"=n, "m"=m,"b.x"=b.x,"b.y"=b.y,"phase.angle"=as.vector(phase.angle),"cx"=cx,"cy"=cy,"retention.above"=retention.above,
                           "retention.below"=retention.below, "coercion.above"=coercion.above,"coercion.below"=coercion.below,"area"=area, "lag.above"=lag.above,"lag.below"=lag.below,"beta.split.angle"=beta.split.angle,
                           "hysteresis.x.above"=hysteresis.x.above,"hysteresis.x.below"=hysteresis.x.below, "hysteresis.y.above"=hysteresis.y.above,"hysteresis.y.below"=hysteresis.y.below)
    z
  }
