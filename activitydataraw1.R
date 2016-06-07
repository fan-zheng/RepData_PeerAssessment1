library(ggplot2)
stepdata<-read.csv("activity.csv", head=TRUE,na.strings="NA")
totalperday<-tapply(stepdata$steps,stepdata$date,sum,na.rm=TRUE)
hist(totalperday,col="green")
meanperday<-mean(totalperday)
medianperday<-median(totalperday)
intervalperday<-tapply(stepdata$steps,stepdata$interval,mean,na.rm=TRUE)
plot(rownames(intervalperday),intervalperday)
maxinterval<-which.max(intervalperday)
sum(is.na(stepdata$steps))
a<-which(is.na(stepdata$steps))
b<-stepdata$interval[which(is.na(stepdata$steps))]
b<-as.character(b)
c<-intervalperday[b]
stepdata1<-stepdata
stepdata1$steps[a]<-c
totalperday1<-tapply(stepdata1$steps,stepdata1$date,sum,na.rm=TRUE)
meanperday1<-mean(totalperday1)
medianperday1<-median(totalperday1)
hist(totalperday1,col="orange")
stepdata1$date<-as.Date(stepdata1$date)
stepdata1$weekdays<-weekdays(stepdata1$date)
weekday <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
weekend <- c('Saturday', 'Sunday')
stepdata1$level<-stepdata1$weekdays
stepdata1[(stepdata1$weekdays) %in% weekday,]$level<-"Weekday"
stepdata1[(stepdata1$weekdays) %in% weekend,]$level<-"Weekend"
stepdata1_intervalperday<-aggregate(steps~level+interval,data=stepdata1,mean)
g<-ggplot(stepdata1_intervalperday,aes(interval,steps))
g<-g+geom_line()+facet_wrap(~level,ncol=1)+theme(strip.text.x=element_text(size=10,angle=0),strip.background=element_rect(fill="wheat2"))+
  xlab("Interval")+ylab("Number of steps")
print(g)