# Getting and Cleaning Data - Course Project

## Code Book

### Source Files

The files used to create the tidy dataset were extracted from “Human Activity Recognition Using Smartphones Data Set” experience:
* features.txt: List of all features.
* activity_labels.txt: List of the class labels with their activity name.
* train/X_train.txt: Training set for the measures.
* train/y_train.txt: Training labels.
* train/subject_train.txt: Training set with identification of the subject who performed the activity.
* test/X_test.txt: Test set for the measures.
* test/y_test.txt: Test labels.
* test/subject_train.txt: Test set with identification of the subject who performed the activity.

### Variable’s Description

Variables used to define TidyData.txt are:
* activity: activity name for the six activities performed from each person. 
  Labels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* subjectid: integer between 1 and 30 that represent each person who participated on the experience.

Each pair activity/subjectid are unique and measure by the average of each variable (in floating point numbers):
* Time domain body acceleration mean along X, Y, and Z axis:
  * avgtbodyaccmeanx 
  * avgtbodyaccmeany 
  * avgtbodyaccmeanz 
* Time domain body acceleration standard deviation along X, Y, and Z axis:
  * avgtbodyaccstdx 
  * avgtbodyaccstdy 
  * avgtbodyaccstdz 
* Time domain gravity acceleration mean along X, Y, and Z axis:
  * avgtgravityaccmeanx 
  * avgtgravityaccmeany 
  * avgtgravityaccmeanz 
* Time domain gravity acceleration standard deviation along X, Y, and Z axis:
  * avgtgravityaccstdx 
  * avgtgravityaccstdy 
  * avgtgravityaccstdz 
* Time domain body acceleration of Jerk signals mean along X, Y, and Z axis:
  * avgtbodyaccjerkmeanx 
  * avgtbodyaccjerkmeany 
  * avgtbodyaccjerkmeanz 
* Time domain body acceleration of Jerk signals standard deviation along X, Y, and Z axis:
  * avgtbodyaccjerkstdx 
  * avgtbodyaccjerkstdy 
  * avgtbodyaccjerkstdz 
* Time domain body gyroscope mean along X, Y, and Z axis:
  * avgtbodygyromeanx 
  * avgtbodygyromeany
  * avgtbodygyromeanz 
* Time domain body gyroscope standard deviation along X, Y, and Z axis:
  * avgtbodygyrostdx 
  * avgtbodygyrostdy 
  * avgtbodygyrostdz 
* Time domain body gyroscope of Jerk signals mean along X, Y, and Z axis:
  * avgtbodygyrojerkmeanx 
  * avgtbodygyrojerkmeany 
  * avgtbodygyrojerkmeanz 
* Time domain body gyroscope of Jerk signals standard deviation along X, Y, and Z axis:
  * avgtbodygyrojerkstdx 
  * avgtbodygyrojerkstdy 
  * avgtbodygyrojerkstdz
* Time domain body acceleration magnitude mean and standard deviation:
  * avgtbodyaccmagmean 
  * avgtbodyaccmagstd 
* Time domain gravity acceleration magnitude mean and standard deviation:
  * avgtgravityaccmagmean 
  * avgtgravityaccmagstd 
* Time domain body acceleration of Jerk signals magnitude mean and standard deviation:
  * avgtbodyaccjerkmagmean 
  * avgtbodyaccjerkmagstd 
* Time domain body gyroscope magnitude mean and standard deviation:
  * avgtbodygyromagmean 
  * avgtbodygyromagstd 
* Time domain body gyroscope of Jerk signals magnitude mean and standard deviation:
  * avgtbodygyrojerkmagmean 
  * avgtbodygyrojerkmagstd 

### Transformations

The Tidy DataSet were obtained by following instructions given on the assignment:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Process:

##### STEP 1: 
1. Read all the files identified on “Source Files” using read.table command.
2. Using the dim command to determine the dimension of each file.
3. To merge the training dataset into unique object use the cbind command, because the number of rows of each training file are the same (7352 records).
4. Do the same procedure on the test dataset (number of rows/records - 2947).
5. To merge the training and test dataset into a unique dataset use rbind command, because the number of columns of each dataset are the same (563 variables - 1 for activity, 1 for subject id and 561 for all features).

##### STEP 2: 
1. Subset the features data with mean measurement.
2. Subset the features data with standard deviation measurement.
3. Merge the previous two subsets to find the features which have simultaneously both measurements mean and standard deviation, using the merge command with options type=“inner” for FeaturesCode.
 
##### STEP 3: 
1. Use the merge command to use class labels names for activity.
2. Reorder the variables to have activity and subjected on the two first columns.

##### STEP 4:
1. Rename the variables of the dataset to have more readable dataset. Use the commands strsplit for the string “-“, sapply and tolower. Define also a function that concatened the index 1,2 and 3 of the strsplit result.

##### STEP 5:
1. Use the aggregate command to define a data frame with the average (FUN=mean) of each variable group by activity and subjectid (option by=list(activity,subjectid).
2. Use the write.table command to create the TidyData.txt file with the final result.
