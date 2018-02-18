# Coursera Module 3: Getting and Cleaning Data Course Project Assignment (Coursera-TidyData)

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This readme file explains how the main script work.

This submission is composed of the following:  
1. **run_analysis.R** - main R script in this Github repository that is used in performing the analysis  
2. **accTidy.txt** - a tidy data set with the average of each variable for each activity and each subject
3. **CodeBook.md** - code book that describes the variables, the data, and any transformations performed to clean up the data

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is where the data is that is used for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There is only one R script that performs the analysis as follows:
1. Load the test and training data along with the relevant reference files.  Please note that the script assumes that the data files are saved and located in the working directory.  
  
2. Assign descriptive activity names to name the activities in the data set as well as appropriately labels the subject and measurement data sets with descriptive variable names  
```
y_test <- data.frame(activity = activity_labels$V2[y_test$V1])  
y_train <- data.frame(activity = activity_labels$V2[y_train$V1])  
colnames(subject_train) <- c("subject")  
colnames(subject_test) <- c("subject")  
colnames(x_test) <- features$V2  
colnames(x_train) <- features$V2
```  
3. Merge the test and training sets to create one data set
```
ds_test  <- bind_cols(subject_test, y_test, x_test)
ds_train <- bind_cols(subject_train, y_train, x_train)
acc_data  <- rbind(ds_test, ds_train)
```  
4. Extract only the measurements on the mean and standard deviation for each measurement  
```
colnums <- c(1,2, grep("(mean|std)\\(\\)", colnames(acc_data)))
acc_tidy <- acc_data[colnums]
```  
5. From the data set in #4, a second, independent tidy data set is created with the average of each variable for each activity and each subject.
``` 
acc_tidy %>%
        group_by(subject,activity) %>%
        summarise_all(funs(mean))  %>%
        write.table(file="accTidy.txt", row.name=FALSE) 
``` 

