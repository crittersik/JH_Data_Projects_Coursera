#Variables, data, and data transformations.

## Data
I read and clean the data from the Human Activity Recognition Using Smartphones Dataset and follow the instruction from the coursera course Getting and Cleaning Data, the Peer Assesment Project.

Data source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##1. Read the data and merge to a data frame
The data are given in the following files:
Main data:
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

List of features and activity labels:
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

The data are read separately for test, subject and label (activity), for both train and test case. They are merged all together to a data frame 'all_data' with 563 and 10299 rows. The variables are described in detais in 'features.info'

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
I read the data frame 'features' with given feature names from "features.txt". I use the grepl function to see which potentail columns names has a mean or std phrase in them. I filter the data only taking such columns, and create 'all_data_filtered' data frame. 

## 3. Use descriptive activity names to name the activities in the data set
I read activity labels from 'activity_labels.txt'. I use the mapvalues from the plyr package to map numbers with their corresponding activity labels (second column of the 'all_data_filtered' dataframe).

## 4. Appropriately label the data set with descriptive variable names.
The first 2 columns are later labeled 'Subject','Label', while the remaining 561 columns are labelled according to the given 'features.txt' file.

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
I use the ddply function to evaluate the mean for each 'Subject' and 'Label' (activity label) pair. I reshape the data using the melt function from reshape2 package. I write the data to a 'tidy_data.txt' file using write.table with row.name=FALSE specification (as requested in the assignment).
