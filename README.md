Getting and Cleaning Data Course Project
========================================

### Project ReadMe for the Course Getting and Cleaning Data

# Data Source


I downloaded the file from the Coursera Web site using [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# Input Files

The downloaded zip file has been extracted to its contents.

I have used the following extracted files:

- X_test.txt.

- X_train.txt.

- y_test.txt.

- y_train.txt.

- subject_test.txt.

- subject_train.txt.

- features.txt.

- activity_labels.txt.

# Processing

- The R script **run_analysis.R** is used to process the input data. 
- This R script **run_analysis.R** contains informative comments before each step. These comments explain the code that is responsible to process each step in the project.

# Output Files

The R script **run_analysis.R** is used to output two data sets:

- **data_set.txt**: data set that merges all the data (training + testing + subjects + activities).

- **average_variables.txt**: independent tidy data set that contains the averages of every feature for each subject and each activity. This is uploaded to Coursera using the assignment Web page. 

# Dependencies

The code in the R script **run_analysis.R** depends on the **reshape2** and **plyr** libraries, which are loaded into R using the script. 


