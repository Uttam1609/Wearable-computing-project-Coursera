# Wearable-computing-project-Coursera
This repo contains the files relating to the wearable computing project of 'Getting and cleaning data' course on coursera

Problem 1

I read the test data and stored in a test data set using the following lines of code
Initially I read test set data from X_test.txt and stored in a data frame variable
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")

Then, I read test activity label data from y_test.txt and stored in a data frame variable
test_set_activity <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = " ")

Thereafter, I read test subject data from subject_test.txt and stored in a data frame variable
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ")

Then, I merged all the test data to create one complete test dataset and stored in a data frame variable
all_test_data <- data.frame(test_subject,test_set_activity,test_set)

I read read and extracted data from features dataset to assign names to complete test dataset and stored in a character vector
features_data <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
features_data <- as.character(features_data[, 2])

I assigned the field or variable names to the complete test data set
names_subject_activity <- c("subject","activity")
names(all_test_data) <- c(names_subject_activity, features_data)

Then, I read training data
I, first read train set data from X_train.txt and stored in a data frame variable
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")

Thereafter, I read subject train data from subject_train.txt and stored in a data frame variable
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ")

Finally, I read train activity label data from y_train.txt and stored in a data frame variable
train_set_activity <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = " ")

I then merged all the train datasets to create one complete train dataset and stored in a data frame variable
all_train_data <- data.frame(train_subject,train_set_activity,train_set)

I assigned appropriate names to the variables in the train dataset which can be obtained from features dataset
names(all_train_data) <- c(names_subject_activity, features_data)

Lastly, I merged both the test and train datasets to create one total dataset and stored in a data frame variable
total_data <- rbind(all_test_data,all_train_data)
Thus, solution to problem 1 was obtained

Problem 2

I Extracted only the measurements of indices mean and standard deviation by using grep function on features dataset
mean_std_index <- grep("mean|std", features_data)

Then, I created a subset dataset containing only variable names including "mean" and "standard deviation" in total dataset
sub_total_data <- total_data[,c(1,2,mean_std_index + 2)]
Thus, solution to problem 2 was obtained

Problem 3
First, I read the descriptive activity label names dataset provided in the downloaded file and stored in a dataframe
activity_label_names <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

Then, I extracted names from second column of activity labels dataset and stored in a character vector
activity_label_names <- as.character(activity_label_names[,2])

Finally, I assigned the descriptive activity label names to activity column in subset data set
sub_total_data$activity <- activity_label_names[sub_total_data$activity]
Thus, solution to problem 3 was obtained

Problem 4
First, I extracted the names of variables of subset dataset to be simplified and written descriptively and stored in a vector
sub_total_data_names <- names(sub_total_data)

Then I applied gsub function iteratively to modify and simplify the names
sub_total_data_names <- gsub("^t","Time_",sub_total_data_names)
sub_total_data_names <- gsub("^f","Frequency_",sub_total_data_names)
sub_total_data_names <- gsub("Acc","Accelerometer_",sub_total_data_names)
sub_total_data_names <- gsub("Gyro","Gyroscope_",sub_total_data_names)
sub_total_data_names <- gsub("Mag","Magnitude_",sub_total_data_names)
sub_total_data_names <- gsub("Jerk","Jerk_",sub_total_data_names)
sub_total_data_names <- gsub("Freq","_Frequency",sub_total_data_names)
sub_total_data_names <- gsub("Body","Body_",sub_total_data_names)
sub_total_data_names <- gsub("Gravity","Gravity_",sub_total_data_names)
sub_total_data_names <- gsub("Frequencyuency","Frequency",sub_total_data_names)
sub_total_data_names <- gsub("mean","Mean",sub_total_data_names)
sub_total_data_names <- gsub("std","Standard_Deviation",sub_total_data_names)
sub_total_data_names <- gsub("[(][)]","",sub_total_data_names)
sub_total_data_names <- gsub("-","",sub_total_data_names)
sub_total_data_names <- gsub("X","_X",sub_total_data_names)
sub_total_data_names <- gsub("Y","_Y",sub_total_data_names)
sub_total_data_names <- gsub("Z","_Z",sub_total_data_names)

I then renamed the variables in the subset dataset
names(sub_total_data) <- sub_total_data_names
Thus, solution to problem 5 was obtained

problem 5
I created a tidy dataset with average of each variable both activity and subject wise and arrangeing using aggregate function
tidy_data <- aggregate(sub_total_data[,3:81], by = list(activity = sub_total_data$activity, subject = sub_total_data$subject),FUN = mean)
Thus, solution to problem 5 was obtained

I wrote the resulting dataset into a text file 'TidyData.txt' using write.table command
write.table(tidy_data, file = "TidyData.txt", row.names = FALSE)
