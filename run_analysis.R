# run_analysis.R
# Course project for Getting and Cleaning Data course from
# John Hopkins University via Coursera.
#
# script reads in data from the UCI HAR Dataset, to finally
# produce a tidy data set with mean and std values from the
# original data set for each subject and each activity.

library(plyr)
library(data.table)

# import features.txt and activity_labels.txt:
features <- read.table(file.path("UCI HAR Dataset", 
                                 "features.txt"), 
                       header = FALSE)

activity_labels <- read.table(file.path("UCI HAR Dataset", 
                                        "activity_labels.txt"), 
                              header = FALSE)

## The train data set.

# read in X_train.txt.
X_train <- read.table(file.path("UCI HAR Dataset/train", 
                                "X_train.txt"), 
                       header = FALSE)
# give X_train the column names of features.
colnames(X_train) <- features[,2] 

# now select only the column names in X_train that
# are associated with a mean or std.
selection <- grepl("mean|std" , names(X_train))
X_train_reduced <- X_train[selection]

# now read in y_train.txt
y_train <- read.table(file.path("UCI HAR Dataset/train", 
                                "y_train.txt"), 
                      header = FALSE)
# use "y" as column name for consistency with original data.
colnames(y_train) <- "y"  

# read in subject_train.txt and give column a name.
subject_train <- read.table(file.path("UCI HAR Dataset/train", 
                                      "subject_train.txt"), 
                      header = FALSE)
colnames(subject_train) <- "subject"

# use the activity_labels to add a column to y_train that
# indicates the activity (in words) that the factor "y"
# refers to.
y_train$activity <- activity_labels[y_train$y, 2]

# now create the trainDataSet from
# subject_train, y_train, and X_train_reduced
trainDataSet <-  cbind(subject_train, y_train, X_train_reduced)


## The test data set.

# read in X_train.txt.
X_test <- read.table(file.path("UCI HAR Dataset/test", 
                                "X_test.txt"), 
                      header = FALSE)
# give X_train the column names of features.
colnames(X_test) <- features[,2] 

# now select only the column names in X_test that
# are associated with a mean or std.
selection <- grepl("mean|std" , names(X_test))
X_test_reduced <- X_test[selection]

# now read in y_test.txt
y_test <- read.table(file.path("UCI HAR Dataset/test", 
                                "y_test.txt"), 
                      header = FALSE)
# use "y" as column name for consistency with original date
colnames(y_test) <- "y"  

# read in subject_test.txt and give column a name.
subject_test <- read.table(file.path("UCI HAR Dataset/test", 
                                      "subject_test.txt"), 
                            header = FALSE)
colnames(subject_test) <- "subject"

# use the activity_labels to add a column to y_test that
# indicates the activity (in words) that the factor "y"
# refers to.
y_test$activity <- activity_labels[y_test$y, 2]

# now create the testDataSet from
# subject_test, y_test, and X_test_reduced
testDataSet <-  cbind(subject_test, y_test, X_test_reduced)

# Now add the test and train data frame together:
combinedDataSet <- rbind(trainDataSet, testDataSet)
combinedDataSet <- combinedDataSet[order(combinedDataSet$subject, 
                                         combinedDataSet$y),]
# now need to clean up row.names:
row.names(combinedDataSet) <- seq(nrow(combinedDataSet))

combinedDataSet <- data.table(combinedDataSet)
# simplifiedData <- by(combinedDataSet, 
#                      list(combinedDataSet$subject, combinedDataSet$y), 
#                      colMeans)
simplifiedData <- combinedDataSet[, lapply(.SD,mean), 
                                  by = list(subject, 
                                            y, 
                                            activity)]

# up to now, we have used the column "y" as the activity factor,
# since it was useful when working with the data. However,
# we can now remove it since the activity column contains
# essentially the same data:
simplifiedData[, y:=NULL]

# Write the tidy data set simplifiedData to a .txt file.
write.table(simplifiedData, "tidyAccelerometerData.txt",
            sep="\t", 
            row.name=FALSE)


