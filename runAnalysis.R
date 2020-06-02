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