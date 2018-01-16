#################################
### binary calibration #####
#################################                            # CORElearn package may do this with one line

truths <- data.frame(val=val$target)


valpreds <- xgbpreds

testpreds <- read_csv("sub1ens01.csv")

calibrator <- data.frame(cbind(truths, valpreds))    # 2 columns in original
colnames(calibrator) <- c("y", "x")


  model <- glm (y ~ x, calibrator, family=binomial)
  calibratorpart <- data.frame(testpreds[, 2])           # this changes for each class
  colnames(calibratorpart) <- c("x")
  newtestpreds1 <- predict(model, newdata=calibratorpart, type="response")
  
  
  
  
  calibrated <- data.frame(ID=testpreds$ID, PredictedProb=newtestpreds1)
  
  
 write_csv (calibrated, "calpreds001.csv")



#################################
### multi-class calibration #####
#################################

truths <- data.table(val=val$fault_severity, p0=0, p1=0, p2=0)
truths[val == 0, p0 := 1]
truths[val == 1, p1 := 1]
truths[val == 2, p2 := 1]
setDF(truths)

valpreds <- xgbprobavg

testpreds <- read_csv("ens010.csv")

calibrator <- data.frame(cbind(truths, valpreds))    # 2 columns in original
colnames(calibrator)[5:7] <- c("x0", "x1", "x2")



model <- glm (p0 ~ x0, calibrator, family=binomial)
calibratorpart <- data.frame(testpreds[, 2])           # this changes for each class
colnames(calibratorpart) <- c("x0")
newtestpreds0 <- predict(model, newdata=calibratorpart, type="response")

model <- glm (p1 ~ x1, calibrator, family=binomial)
calibratorpart <- data.frame(testpreds[, 3])           # this changes for each class
colnames(calibratorpart) <- c("x1")
newtestpreds1 <- predict(model, newdata=calibratorpart, type="response")

model <- glm (p2 ~ x2, calibrator, family=binomial)
calibratorpart <- data.frame(testpreds[, 4])           # this changes for each class
colnames(calibratorpart) <- c("x2")
newtestpreds2 <- predict(model, newdata=calibratorpart, type="response")

calibrated <- data.frame(id=testpreds$id, predict_0=newtestpreds0, predict_1=newtestpreds1, predict_2=newtestpreds2)
rowtotal <- rowSums(calibrated[, 2:4])
calibrated[, 2:4] <- calibrated[, 2:4]/rowtotal



write_csv (calibrated, "calpreds.csv")
