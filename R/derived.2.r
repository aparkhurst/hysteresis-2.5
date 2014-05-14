derived.2 <- function(b.x,b.y,retention,period) {
area<-abs(pi*b.x*retention)
coercion <- b.x/(sqrt(1+(b.y/retention)^2))
lag<-abs(atan2(retention,b.y))*period/(pi*2)
z <- c(area,lag,coercion)
z
}
