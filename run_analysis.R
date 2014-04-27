# The purpose of this script is to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis

# Task 1 : Merge the training and the test sets to create one data set.
# Task 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
# Task 3 : Uses descriptive activity names to name the activities in the data set
# Task 4 : Appropriately labels the data set with descriptive activity names. 
# Task 5 : Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

setwd("~/RWorkspace/UCI HAR Dataset")

#Load subject data from test and train and combine 
subjecttest <- read.table("test/subject_test.txt")
subjecttrain <- read.table("train/subject_train.txt")
combinetesttrain <- rbind(subjecttest, subjecttrain)
colnames(combinetesttrain) <- "Subject"


# read labels from test and train and combine 
labelstest <- read.table("test/y_test.txt")
labelstrain <- read.table("train/y_train.txt")
labels  <- rbind(labelstest, labelstrain)
colnames(labels) <- c("ActivityID")
str(labels)
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels) <- c("ActivityID", "ActivityName")

#Replace id with name
labels[,1] <- as.vector(activitylabels[match(labels$ActivityID, activitylabels$ActivityID),2])
colnames(labels) <- c("ActivityName")

# combine input data
xtest <- read.table("test/X_test.txt")
xtrain <- read.table("train/X_train.txt")
allinput <- rbind(xtest, xtrain)

# assign feature names to input
features = read.table("features.txt")
names(allinput) = features[,2]

tidyData = cbind(combinetesttrain, labels, allinput[,c(grep("mean", features[,2], ignore.case=TRUE), grep(c("std"), features[,2]))])

library(reshape2)
melteddata <- melt(tidyData, id=c("Subject", "ActivityName"))
tidydatamean <- dcast(melteddata, Subject + ActivityName ~ variable, mean)
# recast
dcast(melteddata, ActivityName + Subject ~variable, mean)

write.table(tidydatamean, file = "tidy_data.txt",row.names = F,col.names = F)
