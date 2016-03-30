#########################
######## SETUP ##########
#########################

# set it up
library(data.table)
library(readr)
setwd("D:/Kaggles/BNP")

# read data
train <- read_csv("train.csv")
test <- read_csv("test.csv")

train <- fread("train.csv")
test <- fread("test.csv")


# combine data for preproc
setDT(train)
setDT(test)
test[, target:= 3]
setcolorder(test, c(1, 133, 2:132))
train <- rbind(train, test)
rm(test)



###############################
######## MISSING DATA #########
###############################

# count NAs/N for all cols (see justfor script)
# convert char to int
# treat NAs using "missingmap.R" and impution.R"

# can use -1 or median for numeric and mode for alpha

# v52=NULL (fill it)

# try caret medianimopute for missing vvlaues



###############################
######## OUTLIERS #############
###############################

# check outliers using outlier package
# manually set outliers
guestlist <- c(26174, 33445, 109085, 119018, 120633, 139285, 156182, 184604)  
train <- train[!(ID %in% guestlist), ]                                                # try keeping these






####################################
######## FEATURE SELECTION #########
####################################

# Boruta package? see justfor script
#k-s test ala justfor
# corr plot
# run diffs of closely correlated vars before deleting
# also check v22, v112 and v125 with each other
# v91, v107 are same

# CHECK THESE VALUES FOR INSIGHT
# table(round(train$v50/0.00146724379,2))
# table(round(train$v40/0.0007235366152,2))
# table(round(train$v10/0.0218818357511,2))
# there are many more, but it might help you to understand what data we have and why chain dependencies are present :)




####################################
######## FEATURE CREATION #########
####################################

# count NAs/N as a feature (done earlier)
# set up flags for missing groups of variables (see miceplot)

# run diff of 112 & 125 and other closely correlated vars

 # encode categoricals using frequency or "mean target"



# reread posts: Feature Engineerng +122, Looks like a nice 
# challenge... +49,

# go back and check the data distribution script

# read back through Justfor's xgb script

# reread post of Analysis of duplicate/correlated variables

# Lasagne script is 0.498 - also see xgb hacK script
# caffe, Bayesian optimization



# should be able to get <0.45 with a single XGB                              
# 0.47 with h2o NN        


# read up on homesite conversion





####################################
######## CREATE MODELS #########
####################################



# calibrate results?
# try extreme trees or party package instead of rf
# use bagging as in JUstfor script
# 

