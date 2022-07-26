rm(list=ls())
install.packages("openxlsx")
library(openxlsx)
a<-read.xlsx("D:\\tian\\Desktop\\PAAD\\13268\\6\\i.xlsx",sheet=1)
library(survival)
library(survminer)
install.packages("ggplot2")
install.packages("ggpubr")
library(ggplot2)
library(ggpubr)

Lung <- a  
head(Lung)
Lungsurv <- Surv(time = a$time, event = a$state)
Lungfit <- survfit(Lungsurv~Lung$Group)
survdiff(Lungsurv~Lung$group,rho=1)

plot(Lungfit, conf.int = "none",
     col =c('red', 'blue'), lwd = 2, mark.time=F,
     main="DEPDC1",xlab='Time(days)', ylab='Survival Probability',font.lab=2) 
legend('topright', c('High Group
','Low Group'),
       col=c('red', 'blue'), lwd=2)
text(500, 0.1, 'p=0.0041',cex = 2)    

