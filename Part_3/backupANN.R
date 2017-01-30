#Backup
#Train the neuralnet
nn <- neuralnet(
  G3~sex+age+studytime+failures+schoolsup+famsup+paid+activities+internet+romantic+famrel+freetime+goout+Dalc+Walc+health+absences+G1+G2, data=student_pre2, hidden=3, err.fct = "ce", linear.output = FALSE)

nn
names(nn)

nn$result.matrix
plot(nn)


#
pr.nn <- compute(nn,test_[,1:13])

pr.nn_ <- pr.nn$net.result*(max(data$medv)-min(data$medv))+min(data$medv)
test.r <- (test_$medv)*(max(data$medv)-min(data$medv))+min(data$medv)

MSE.nn <- sum((test.r - pr.nn_)^2)/nrow(test_)
