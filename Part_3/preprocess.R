d1=read.table("student-mat.csv",sep=";",header=TRUE)
#d2=read.table("student-por.csv",sep=";",header=TRUE)

#d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu"
#,"Fedu","Mjob","Fjob","reason","nursery","internet"))
#print(nrow(d3)) # 382 students


str(d1)
summary(d1)

#install.packages("dplyr")
library(dplyr)
student_pre <- select(d1, -school,-address, -famsize, -Pstatus, -Medu, -Fedu, -Mjob, -Fjob, -reason,-guardian, -traveltime, -nursery, -higher)
