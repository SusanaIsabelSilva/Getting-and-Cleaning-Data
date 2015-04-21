# Getting and Cleaning Data - Course Project

### Main Purpose
The goal of this project is to prepare tidy dataset by collecting, working in, and cleaning a raw dataset.

### Data Source
This project use the "Human Activity Recognition Using Smartphones Dataset" downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

See more information about the experience in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

### Raw Data
The data set were partitioned into two sets - training and test dataset. Each one, training and test dataset, had a subject_(train/test).txt file with the ID of each volunteer, a y_(train/test).txt file with the activity data, and a x_(train/test).txt file with 561 features. The identification of the features were in features.txt file and the activity_labels.txt file had the identification of the six activities that each volunteer performed.

### Steps performed to obtained Tidy Data
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

See more details in CodeBook.md.
