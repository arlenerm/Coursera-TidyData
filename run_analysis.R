# The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.
# One of the most exciting areas in all of data science right now is wearable computing - 
# Companies like Fitbit, Nike, and Jawbone Up are racing 
# to develop the most advanced algorithms to attract new users. The data linked to 
# from the course website represent data collected from the accelerometers from the 
# Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# ==================================================================
# Human Activity Recognition Using Smartphones Dataset
# Version 1.0
# ==================================================================
# Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
# Smartlab - Non Linear Complex Systems Laboratory
# DITEN - Universit‡ degli Studi di Genova.
# Via Opera Pia 11A, I-16145, Genoa, Italy.
# activityrecognition@smartlab.ws
# www.smartlab.ws
# ==================================================================

# The steps below outlines the analysis steps taken to come up with tidy data at the end:
# Step 1: Use descriptive activity names to name the activities in the data set.
# Step 2: Appropriately label the subject, activity and measurements data sets with descriptive variable names.
# Step 3: Extract only the measurements on the mean and standard deviation for each measurement.
# Step 4: Merge the training and the test sets to create one data set.
# Step 5: From the data set in step 4, create a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.
        
#######################
#    Initialization   #
#######################
# this part takes care of loading datasets and libraries prior to processing
# it is assumed that the data files are located in the working directory

# load relevant R libraries
library(dplyr)

# Load general info
activity_labels <- read.table ("activity_labels.txt")
features <- read.table ("features.txt")

# Load the Test Data
# note that data sets in inertial signals Test data folder were not used
# because there are no mean and standard deviation values involved
subject_test <- read.table ("subject_test.txt")
x_test <- read.table ("x_test.txt")
y_test <- read.table ("y_test.txt")

# Load the Training Data
# note that data sets in inertial signals for Training data folder were not used
# because there are no mean and standard deviation values involved
subject_train <- read.table ("subject_train.txt")
x_train <- read.table ("x_train.txt")
y_train <- read.table ("y_train.txt")

##################################
#   Data Analysis / Processing   #
##################################

# Assigns descriptive activity names to name the activities in the data set
y_test <- data.frame(activity = activity_labels$V2[y_test$V1])
y_train <- data.frame(activity = activity_labels$V2[y_train$V1])

# Appropriately labels the subject data sets with descriptive variable names
colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")

# Appropriately labels the measurements data sets with descriptive variable names
colnames(x_test) <- features$V2
colnames(x_train) <- features$V2

# Merge the training and the test sets to create one data set
# Step 1: Merge respective (subject, activity and measurements) data 
#         to form each of the test and training data sets
ds_test  <- bind_cols(subject_test, y_test, x_test)
ds_train <- bind_cols(subject_train, y_train, x_train)
# Step 2: Merge the rows of test and training data sets to create one data set
acc_data  <- rbind(ds_test, ds_train)

# Extract only the measurements on the mean and standard deviation for each measurement
colnums <- c(1,2, grep("(mean|std)\\(\\)", colnames(acc_data)))
acc_tidy <- acc_data[colnums]

# Create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
# output the final data set to a file
acc_tidy %>%
        group_by(subject,activity) %>%
        summarise_all(funs(mean))  %>%
        write.table(file="accTidy.txt", row.name=FALSE) 






