### Create one R script called run_analysis.R that does the following:
#1.- Merges the training and the test sets to create one data set.

#set the working directory to where the data has been downloaded and extracted
setwd("C:/Users/Ahmad/Documents/R/TidyDataProject")

#Load required packages
require("plyr")
require("reshape2")

#Read data files
subject_test  <- read.table("subject_test.txt", sep="\n", strip.white=TRUE)
subject_train  <- read.table("subject_train.txt", sep="\n", strip.white=TRUE)
feature_names <- read.table("features.txt", sep="\n", strip.white=TRUE)
feature_names <- gsub("^[0-9]+ ", "", feature_names$V1)
train_y <- read.table("y_train.txt", sep="\n", strip.white=TRUE)
test_y  <- read.table("y_test.txt", sep="\n", strip.white=TRUE)
train_x <- read.table("x_train.txt", sep="\n", strip.white=TRUE)
test_x  <- read.table("x_test.txt", sep="\n", strip.white=TRUE)

#2.- Extracts only the measurements on the mean and standard deviation for each measurement.

# Keep only features involving mean or std values
keep_features <- grepl("mean|std", feature_names)

# Break single column into features
train_x <- ldply(strsplit(gsub(" {2,}", " ", train_x$V1), " "))
test_x  <- ldply(strsplit(gsub(" {2,}", " ", test_x$V1), " "))

# Column-Bind the y-values with the subject IDs and the features
train <- cbind(train_y, subject_train, train_x)
test  <- cbind(test_y, subject_test, test_x)

# Row-Bind train and test data sets
combined <- rbind(train, test)

# Keep only the y-values, subject IDs, and features involving mean or std values data 
combined <- combined[,c(TRUE, TRUE, keep_features)]

#3.- Uses descriptive activity names to name the activities in the data set
#4.- Appropriately labels the data set with descriptive variable names.

###I WILL DO STEP NO.4 First### 
#STEP 4:
# Create column headers
column_headers <- c("activity", "subject", feature_names[keep_features])
# Label data set columns with column headers
colnames(combined) <- column_headers

#STEP 3:
# Read the activity labels into a data frame
activity_labels <- read.table("activity_labels.txt", sep="\n", strip.white=TRUE)
# Remove the leading numbers
activity_labels <- gsub("^[0-9]+ ", "", activity_labels$V1)
# Replace the numbers in the y-values with the activity labels
for (i in 1:nrow(combined)){ 
    combined[i,"activity"] <- activity_labels[as.numeric(combined[i,"activity"])]
}

# Convert features data types to numeric
for (i in 3:ncol(combined)){
    combined[,i] <- as.numeric(combined[,i])
}

# write the data set into a file
write.table(combined, file="data_set.txt", row.names = FALSE, col.names = TRUE)

#5.- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# create data frame that has the subject ID, the activity, and the average of the first feature for each subject and each activity
means <- aggregate(combined[,3] ~ combined$subject + combined$activity, data = combined, FUN = mean)
# add the average of all the remaining 78 features for each subject and each activity
for (i in 4:ncol(combined)){
    means[,i] <- aggregate( combined[,i] ~ combined$subject + combined$activity, data = combined, FUN = mean )[,3]
}
# Create column headers
column_headers <- c("subject", "activity", feature_names[keep_features])
# Label data set columns with column headers
colnames(means) <- column_headers

# write the averages data set into a file
write.table(means, file="average_variables.txt", row.names = FALSE, col.names = TRUE)
