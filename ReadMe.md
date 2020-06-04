---
title: "TidyData"
author: "DBisure"
date: "02/06/2020"
output: html_document
---


The goal of this Project is to present one tidy dataset. We will be applying transformation on the UCI HAR Dataset which can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Creating a training dataframe 

The features.txt files contains the list of features(column names) for the dataset, both training and test data have the same features. Since reading the file give 2 column names, we need to subset only the 2nd column, as the first one is just index. The features class is factor hence should be converted to character.

#Read the column names present in features.txt 
```{r}
features <- read.csv(".\\UCI HAR Dataset\\features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])
```
#Combining and creating 1 training dataset

Read the subject_train.txt and Y_train.txt for subject(ranging from 1-30) and activity performed(ranging from 1-6). Also X_train.txt consists of the values for the features which were read in the previous code chunk

```{r}
train.X<- read.table('.\\UCI HAR Dataset\\train\\X_train.txt')
subject.X <- read.csv('.\\UCI HAR Dataset\\train\\subject_train.txt',header = FALSE, sep = ' ')
activity.X <- read.csv('.\\UCI HAR Dataset\\train\\y_train.txt', header = FALSE, sep = ' ')
```
The names are changed for easier merging of test and training data

```{r}
train_set <-  data.frame(subject.X, activity.X, train.X)
names(train_set) <- c(c('subject', 'activity'), features)
```
#Combining and creating 1 test dataset
Read the subject_test.txt and Y_test.txt for subject(ranging from 1-30) and activity performed(ranging from 1-6). Also X_test.txt consists of the values for the features which were read in the previous code chunk

```{r}
test.X<- read.table('.\\UCI HAR Dataset\\test\\X_test.txt')
subject.X <- read.csv('.\\UCI HAR Dataset\\test\\subject_test.txt',header = FALSE, sep = ' ')
activity.X <- read.csv('.\\UCI HAR Dataset\\test\\y_test.txt', header = FALSE, sep = ' ')
```
The names are changed for easier merging of test and training data

```{r}
test_set <-  data.frame(subject.X, activity.X, test.X)
names(test_set) <- c(c('subject', 'activity'), features)
```

##1. Merging test and training data
```{r}
data <- rbind(train_set,test_set)
```

##2 Extracts only the measurements on the mean and standard deviation for each measurement.
```{r}
mean_std <- grep('mean|std', features)
data_sub <- data[,c(1,2,mean_std + 2)]
```
We added 2 to mean_std as mean_std is a vector made by finding search results for 'mean' or 'std' on the features vector. In our data frame 'data' there are 2 extra columns in the start namely 'subject' and 'activity'

##3 Uses descriptive activity names to name the activities in the data set
Activity_labels.txt contains the activity names for the given label(1-6). We extract this data and convert into character. Then we change the labels with the activity name in the subsetted data frame

```{r}
activity_labels <- read.table('.\\UCI HAR Dataset\\activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_sub$activity <- activity_labels[data_sub$activity]
```
##4 Appropriately labels the data set with descriptive variable names.
Change the names like column names starting 'f' to 'FrequencyDomain'. Removing '()', etc. We will use regular expressions for this.

```{r}
name_new <- names(data_sub)
name_new <- gsub("[(][)]", "", name_new)
name_new <- gsub("^t", "TimeDomain_", name_new)
name_new <- gsub("^f", "FrequencyDomain_", name_new)
name_new <- gsub("Freq$", "_Frequency", name_new)
name_new <- gsub("Acc", "Accelerometer", name_new)
name_new <- gsub("Gyro", "Gyroscope", name_new)
name_new <- gsub("Mag", "Magnitude", name_new)
name_new <- gsub("mean", "Mean", name_new)
name_new <- gsub("std", "StandardDeviation", name_new)
name_new <- gsub("-", "_", name_new)
names(data_sub) <- name_new
```
###5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Using the aggregate function, we can list the dataset by activity and subject and find the mean for each feature
```{r}
tidy_dataset <- aggregate(data_sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
```