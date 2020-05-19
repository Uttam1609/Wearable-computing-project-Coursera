### Problem #1
## reading the test data
# reading test set data from X_test.txt
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")

# reading test activity label data from y_test.txt
test_set_activity <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = " ")

# reading test subject data from subject_test.txt
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ")

# merging all the test data to create one complete test dataset
all_test_data <- data.frame(test_subject,test_set_activity,test_set)

## reading and extracting data from features dataset to assign names to complete test dataset
features_data <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
features_data <- as.character(features_data[, 2])

# assigning the field or variable names to the complete test data set
names_subject_activity <- c("subject","activity")
names(all_test_data) <- c(names_subject_activity, features_data)

## reading train data
# readining train set data from X_train.txt
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")

# reading subject train data from subject_train.txt
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ")

# reading train activity label data from y_train.txt
train_set_activity <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = " ")

# merging all the train datasets to create one complete train dataset
all_train_data <- data.frame(train_subject,train_set_activity,train_set)

# assigning appropriate names to the variables in the train dataset
names(all_train_data) <- c(names_subject_activity, features_data)

# merging both the test and train datasets to create one total dataset
# Solution to problem 1
total_data <- rbind(all_test_data,all_train_data)

### problem #2
## Extracting the measurements of mean and standard deviation
mean_std_index <- grep("mean|std", features_data)

# creating a subset dataset containing only variable names including "mean" and "standard deviation" in total dataset
# solution to problem #2
sub_total_data <- total_data[,c(1,2,mean_std_index + 2)]

### problem #3
## reading descriptive activity label names dataset
activity_label_names <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

# extracting names from second column of activity labels dataset
activity_label_names <- as.character(activity_label_names[,2])

# assigning the descriptive activity label names to activity column in subset data set
# solution to problem #3
sub_total_data$activity <- activity_label_names[sub_total_data$activity]

### problem #4
## extracting the names of variables of subset dataset to be simplified and written descriptively
sub_total_data_names <- names(sub_total_data)

# replacing 't' with 'Time_' and 'f' with "Frequency"
sub_total_data_names <- gsub("^t","Time_",sub_total_data_names)
sub_total_data_names <- gsub("^f","Frequency_",sub_total_data_names)

# replacing 'ACC' with '_Acceleration_', 'Gyro' with '_Gyroscope_', 'Mag' with '_Magnitude_'.....
sub_total_data_names <- gsub("Acc","Accelerometer_",sub_total_data_names)
sub_total_data_names <- gsub("Gyro","Gyroscope_",sub_total_data_names)
sub_total_data_names <- gsub("Mag","Magnitude_",sub_total_data_names)
sub_total_data_names <- gsub("Jerk","Jerk_",sub_total_data_names)
sub_total_data_names <- gsub("Freq","_Frequency",sub_total_data_names)
sub_total_data_names <- gsub("Body","Body_",sub_total_data_names)
sub_total_data_names <- gsub("Gravity","Gravity_",sub_total_data_names)
sub_total_data_names <- gsub("Frequencyuency","Frequency",sub_total_data_names)

# replacing 'mean' with '_Mean_' and 'std' with '_Standard_Deviation_'
sub_total_data_names <- gsub("mean","Mean",sub_total_data_names)
sub_total_data_names <- gsub("std","Standard_Deviation",sub_total_data_names)

# removing curl brackets and '-'
sub_total_data_names <- gsub("[(][)]","",sub_total_data_names)
sub_total_data_names <- gsub("-","",sub_total_data_names)
sub_total_data_names <- gsub("X","_X",sub_total_data_names)
sub_total_data_names <- gsub("Y","_Y",sub_total_data_names)
sub_total_data_names <- gsub("Z","_Z",sub_total_data_names)

# renaming the variables in the subset dataset
names(sub_total_data) <- sub_total_data_names

### problem #5
## creating a tidy dataset with average of each variable both activity and subject wise and arrangeing
tidy_data <- aggregate(sub_total_data[,3:81], by = list(activity = sub_total_data$activity, subject = sub_total_data$subject),FUN = mean)

# writing the resulting dataset into a text file 'TidyData.txt'
write.table(tidy_data, file = "TidyData.txt", row.names = FALSE)
