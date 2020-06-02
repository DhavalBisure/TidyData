---
title: "TidyData"
author: "DBisure"
date: "02/06/2020"
output: html_document
---


The goal of this Project is to present one tidy dataset. We will be reading applying transformation on the UCI HAR Dataset which can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

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
