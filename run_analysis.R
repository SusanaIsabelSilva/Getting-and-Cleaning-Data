library(plyr)
library(dplyr)


## Raw Data - Reaading Files
## Labels - Dim 6 x 2
activity_data <- read.table("UCI HAR Dataset/activity_labels.txt",sep=" "
                            ,col.names=c("ActivityCode","Activity"))
## Features - Dim 561 x 2
features_data <- read.table("UCI HAR Dataset/features.txt",sep=" "
                            ,col.names=c("FeaturesCode","Features"))
## Creating Variable VariablesNames to match with column names - to STEP 4.
features_data$VariableNames<-paste("V",as.character(features_data$FeaturesCode),sep="")

## Training 
## X - Dim 7352 x 561
x_train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
## Y - Dim 7352 x 1
y_train_data <- read.table("UCI HAR Dataset/train/Y_train.txt"
                           ,col.names="ActivityCode") 
## Subject - Dim 7352 x 1
subject_train_data <- read.table("UCI HAR Dataset/train/subject_train.txt"
                                 ,col.names="SubjectId")
## Test
## X - Dim 2947 x 561
x_test_data <- read.table("UCI HAR Dataset/test/X_test.txt") 
## Y - Dim 2947 x 1
y_test_data <- read.table("UCI HAR Dataset/test/Y_test.txt"
                           ,col.names="ActivityCode") 
## Subject - Dim 2947 x 1
subject_test_data <- read.table("UCI HAR Dataset/test/subject_test.txt"
                                 ,col.names="SubjectId")


## Tidy Data
## STEP 1: Merge Dataset
train_data <- cbind(subject_train_data,y_train_data,x_train_data)
test_data <- cbind(subject_test_data,y_test_data,x_test_data)
data <- rbind(train_data,test_data)
## Remove auxiliar objects from environment
rm(x_train_data,y_train_data,subject_train_data,train_data
   ,x_test_data,y_test_data,subject_test_data,test_data)

## STEP 2: Extract the measurement with mean and the standard deviation for each one
features_mean <- subset(features_data,grepl("mean\\()"
                                            ,tolower(features_data$Features)))
features_std <- subset(features_data,grepl("std\\()"
                                            ,tolower(features_data$Features)))
features_mean$Features <- sub("-mean()","",features_mean$Features,fixed=TRUE)
features_std$Features <- sub("-std()","",features_std$Features,fixed=TRUE)
subset_features <- merge(features_mean,features_std,by="Features",type="inner")
subset_features <- data.frame(as.vector(cbind(subset_features$FeaturesCode.x
                                              ,subset_features$FeaturesCode.y)))
names(subset_features) <- "FeaturesCode"
features_data <- merge(features_data,subset_features,type="inner")
data <- data[,which(names(data) %in% c("SubjectId","ActivityCode") 
                    | names(data) %in% features_data$VariableNames)]
## Remove auxiliar objects from environment
rm(features_mean,features_std,subset_features)

## STEP 3: Use descriptive activity names to name the activities in the data set
data <- merge(data,activity_data,type="inner")
data <- data[,c(69,2:68)]

## STEP 4: Descriptive variable names
variablesnames <- function(x){
  t<-paste(x[2],x[1],sep="")
  if(!is.na(x[3])){
    t<-paste(t,x[3],sep="")
  }
  return(t)
}
splitfeaturesnames <- strsplit(as.vector(sub("()","",features_data$Features,fixed=TRUE)),"-")
newfeaturesnames <- tolower(sapply(splitfeaturesnames,variablesnames))
names(data)[1:2] <- tolower(names(data)[1:2])
names(data)[3:68] <- as.vector(newfeaturesnames)
## Remove auxiliar objects from environment
rm(splitfeaturesnames,newfeaturesnames,variablesnames)

## STEP 5: Define tidy data set with the average of each variable 
## for each activity and each subject
new_data <- aggregate(data[3:68], by=list(data$activity,data$subjectid), FUN=mean)
names(new_data)[1:2] <- names(data)[1:2]
write.table(new_data,file="TidyData.txt",row.names=FALSE)