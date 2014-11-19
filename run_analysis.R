## assumes that data is in the folder ./UCI HAR Dataset

## library dplyr needed for group operations
library(dplyr)

run_analysis <- function(){
	# read training and testing data. Also read features names
	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, comment.char="")
	x_train <- read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE, comment.char="")
	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, comment.char="")
	
	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, comment.char="")
	x_test  <- read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE, comment.char="")
	y_test  <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, comment.char="")
	
	features  <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, comment.char="")
	featureNames <- features[,ncol(features)]

	
	# Merges the training and the test sets to create one data set and sets name variables
	# Extracts only the measurements on the mean and standard deviation for each measurement
	# "merged" contains the merged data (training + testing) of only the measurements on the mean and 
	# standard deviation
	# It works by using the function grepl.
	# It is noticed that the measurements on the mean contain "mean" in the feature name
	# of the feature. It is also noted that the measurements of the standard
	# deviation contains "std" in the feature name.
	# the function grepl is used to find which column names contain either "std" or "mean"

	subject_merged <- rbind(subject_train, subject_test)
	names(subject_merged) <- "subject"
	
	x_merged <- rbind(x_train, x_test)
	names(x_merged) <- featureNames
	x_merged_filtered <- x_merged[, grepl("(std|mean)", names(x_merged))]
	
	y_merged <- rbind(y_train, y_test)
	names(y_merged) <- "activity" 
	
	merged <- cbind(subject_merged, x_merged_filtered, y_merged)
	
	# The function "match" is used to make the connection between the activity_labels
	# and the activities identifiers
	# it results in "merged" having the "activity" variable in descriptive form
	activity_labels  <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, comment.char="")
	names(activity_labels) <- c("id", "label")
	merged$activity <- activity_labels[match(merged$activity, activity_labels$id), 2]
	
	# Create an independent tidy data set with the average of each variable for each activity and each subject. 
	tidy <- merged %>% group_by(activity, subject) %>% summarise_each(funs(mean))
	
	# return tidy
	tidy
}
