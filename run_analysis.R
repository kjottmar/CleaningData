## This script will take two separate data files (Test and Train) and combine them 
## into a single data set.

library(plyr)

## This first step creates a vector with all of the names of the variables from the
## Test and Train data sets

Features <- read.table("features.txt", header=FALSE,
                       colClasses = c("NULL", "character"))
Variables <- as.matrix(Features, "character")

## This next step creates a vector containing the names of the activities.

ActivityLabels <- read.table("activity_labels.txt", header=FALSE,
                        colClasses = c("NULL", "character"))
Activities <- as.matrix(ActivityLabels, "character")

## These next steps read the data from the three different Test files. The 
## for loop converts the activity number to its description.

TestPersonID <- read.table("test/subject_test.txt", header=FALSE,
                           col.names="PersonID")
TestData <- read.table("test/X_test.txt", header=FALSE,
                        col.names=Variables)
TestActivity <- read.table("test/Y_test.txt", header=FALSE,
                           col.names="Activity")
TestActivity2 <- as.matrix(TestActivity)
for(i in seq_along(TestActivity2)) {
      Value <- TestActivity2[i]
      Test <- Activities[Value]
      TestActivity[i,] <- Test
}

## TestLabel is a vector that will identify the data as being part of the test
## group. The Test Data is grouped together with a column bind.

TestLabel <- matrix("Test",nrow=2947, ncol=1, dimnames = list(c(),c("Test/Train")))
TestTotal <- cbind(TestPersonID, TestActivity, TestLabel,TestData)

## These next steps read the data from the three different Train files. The 
## for loop converts the activity number to its description.

TrainPersonID <- read.table("train/subject_train.txt", header=FALSE,
                            col.names="PersonID")
TrainData <- read.table("train/X_train.txt", header=FALSE,
                        col.names=Variables)
TrainActivity <- read.table("train/Y_train.txt", header=FALSE,
                            col.names="Activity")
TrainActivity2 <- as.matrix(TrainActivity)
for(i in seq_along(TrainActivity2)) {
      Value <- TrainActivity2[i]
      Train <- Activities[Value]
      TrainActivity[i,] <- Train
}

## TrainLabel is a vector that will identify the data as being part of the test
## group. The Train Data is grouped together with a column bind.

TrainLabel <- matrix("Train",nrow=7352, ncol=1,dimnames = list(c(),c("Test/Train")))
TrainTotal <- cbind(TrainPersonID, TrainActivity, TrainLabel, TrainData)

## The two sets of data are combined with a row bind. And then only the values
## which represent means and standard deviations are subsetted for the tidy
## (refined) data set.

CombinedData <- rbind(TestTotal,TrainTotal)
MeansSDs <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,
              227,228,240,241,253,254,266:271,294:296,345:350,
              373:375,424:429,452:454,503,504,513,516,517,526,
              529,530,539,542,543,552,555:561)
RefinedData <- CombinedData[c(1:3,MeansSDs+3)]
write.table(RefinedData, file="tidyData.txt", row.name=FALSE)