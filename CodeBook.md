# CODE BOOK

1.  Load the raw data sets with the following references listed below.  Note that the data sets in the inertial signals were not used because there are no mean and standard deviation values involved.  
  
* **activity_labels** <- read.table ("activity_labels.txt")  
* **features** <- read.table ("features.txt")  
* **subject_test** <- read.table ("subject_test.txt")  
* **x_test** <- read.table ("x_test.txt")  
* **y_test** <- read.table ("y_test.txt")  
* **subject_train** <- read.table ("subject_train.txt")  
* **x_train** <- read.table ("x_train.txt")  
* **y_train** <- read.table ("y_train.txt")  
  
2.  Use the **activity_labels** data set to assign descriptive activity names to name the activities in the data set.  Also used "activity" to appropriately label the activity variable in the test and train label data sets (**y_test** and **y_train**)  
  
```
y_test <- data.frame(activity = activity_labels$V2[y_test$V1])  
y_train <- data.frame(activity = activity_labels$V2[y_train$V1])
```  
  
3.  Use "subject" to rename the variable / column in the subject data sets (**subject_test** and **subject_train**)  
  
```
colnames(subject_train) <- c("subject")  
colnames(subject_test) <- c("subject")
```  
  
4.  Use the **features** data set to appropriately label variables in the measurements data sets (**x_test** and **y_test**) with descriptive variable names.  This step is important to prior to being able to extract only the mean and standard deviation variables needed.  
  
```
colnames(x_test) <- features$V2  
colnames(x_train) <- features$V2
```  
  
5.  There are 2 steps followed in merging the test and train data sets.   
  
* First, bind the columns / variables together composing of subject (**subject_test** and **subject_train**), activity(**y_test** and **y_train**), and measurements (**x_test** and **y_test**).  
  
```
ds_test  <- bind_cols(subject_test, y_test, x_test)  
ds_train <- bind_cols(subject_train, y_train, x_train)
```  
  
* Second, bind the resulting merged test and train data sets from the first step 
  
```
acc_data  <- rbind(ds_test, ds_train)
```  
  
6.  Extract only the mean and standard deviation for each measurement  
  
```
colnums <- c(1,2, grep("(mean|std)\\(\\)", colnames(acc_data)))  
acc_tidy <- acc_data[colnums]
```  
  
7.  As a final step to the tidy data analysis, compute the average of each of the mean and standard deviation measurement variables grouped by the subject and the activity performed while wearing the sensor  
  
```
acc_tidy %>%  
        group_by(subject,activity) %>%  
        summarise_all(funs(mean))  %>%  
        write.table(file="accTidy.txt", row.name=FALSE)  
```  
   
The resulting tidy data set is saved in the file called accTidy.txt described here.

## accTidy.txt

This contains the description of the data in accTidy.txt indicating all the variables and calculations done. A total of 68 variables are desribed:  
* 1 - variable shows the **subject** who volunteered to perform the activities while wearing a smart phone  
* 1 - variable shows the **activity** performed by the subject  
* 66 - variables show the **average of each of the mean and SD / measurements** from the features vector (features.txt) grouped by the subject and activity variables 

**subject**  
  
Identifies the 30 volunteers within the age bracket 19-48 years.  Each person is identified with a number from 1 to 30 and the list of values and their meaning shown below:  
* 1 - subject or person number 1  
* 2 - subject or person number 2  
* 3 - subject or person number 3  
* 4 - subject or person number 4  
* 5 - subject or person number 5  
* 6 - subject or person number 6  
* 7 - subject or person number 7  
* 8 - subject or person number 8  
* 9 - subject or person number 9  
* 10 - subject or person number 10  
* 11 - subject or person number 11  
* 12 - subject or person number 12  
* 13 - subject or person number 13  
* 14 - subject or person number 14  
* 15 - subject or person number 15  
* 16 - subject or person number 16  
* 17 - subject or person number 17  
* 18 - subject or person number 18  
* 19 - subject or person number 19  
* 20 - subject or person number 20  
* 21 - subject or person number 21  
* 22 - subject or person number 22  
* 23 - subject or person number 23  
* 24 - subject or person number 24  
* 25 - subject or person number 25  
* 26 - subject or person number 26  
* 27 - subject or person number 27  
* 28 - subject or person number 28  
* 29 - subject or person number 29  
* 30 - subject or person number 30  

**activity**  
  
Identifies 6 activities performed by the subject during the experiments while wearing a smartphone (Samsung Galaxy S II) on the waist. List of values below (meaning is self explanatory):  
* WALKING  
* WALKING_UPSTAIRS  
* WALKING_DOWNSTAIRS  
* SITTING  
* STANDING  
* LAYING  
  
The following lists a subset (66 out of 561) of the features vector as variables including only the measurements on the mean and standard deviation (SD) for each measurement (see features.txt).  The features vector are obtained by calculating variables from the time and frequency domain (see features_info.txt for more details).  
	
The value of each mean and SD variable is the summary or calculated mean / average for each of the mean and SD variables grouped by subject and activity.  
  
**tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean()  
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()**
