##Reading Data
features <- read.csv(".\\UCI HAR Dataset\\features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])

##Creating one data frame consisting of all the training data
train.X<- read.table('.\\UCI HAR Dataset\\train\\X_train.txt')
subject.X <- read.csv('.\\UCI HAR Dataset\\train/subject_train.txt',header = FALSE, sep = ' ')
activity.X <- read.csv('.\\UCI HAR Dataset\\train/y_train.txt', header = FALSE, sep = ' ')


train_set <-  data.frame(subject.X, activity.X, train.X)
names(train_set) <- c(c('subject', 'activity'), features)

##Creating one data frame consisting of all the test data
test.X<- read.table('.\\UCI HAR Dataset\\test\\X_test.txt')
subject.X <- read.csv('.\\UCI HAR Dataset\\test\\subject_test.txt',header = FALSE, sep = ' ')
activity.X <- read.csv('.\\UCI HAR Dataset\\test\\y_test.txt', header = FALSE, sep = ' ')


test_set <-  data.frame(subject.X, activity.X, test.X)
names(test_set) <- c(c('subject', 'activity'), features)

##1. Merging test and training data 
data <- rbind(train_set, test_set)

##2 Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- grep('mean|std', features)
data_sub <- data[,c(1,2,mean_std + 2)]

##3 Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('.\\UCI HAR Dataset\\activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_sub$activity <- activity_labels(data_sub$activity)

##4 Appropriately labels the data set with descriptive variable names.
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

##5  From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.

tidy_dataset <- aggregate(data_sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)