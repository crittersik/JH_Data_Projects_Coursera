#install.packages("plyr")
#install.packages("reshape2")

## Load packages
library(plyr)
library(reshape2)

## Read the data
test_set_labels <- read.table("test/y_test.txt")
test_set_subjects <- read.table("test/subject_test.txt")
test_set_data <- read.table("test/X_test.txt")
train_set_labels <- read.table("train/y_train.txt")
train_set_subjects <- read.table("train/subject_train.txt")
train_set_data <- read.table("train/X_train.txt")

## 1. Merge the training and the test sets 
## to create one data set.
train_set <- cbind(train_set_subjects, train_set_labels, train_set_data)
test_set <- cbind(test_set_subjects, test_set_labels, test_set_data)
all_data <- rbind(train_set, test_set)


## 2. Extract only the measurements on the mean and 
## standard deviation for each measurement. 

# Read feature names
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# Extract measurements on the mean and standard deviation.
# I add 2xTRUE for subject and labels
mean_std_filter <- grepl("mean|std", features[,2])
all_data_filtered <- all_data [,c(TRUE, TRUE, mean_std_filter)]

#filter features
features_filtered <- features[mean_std_filter,]

## 3. Uses descriptive activity names to name 
## the activities in the data set

# Read activity labels
activity_names <- read.table("activity_labels.txt", stringsAsFactors=FALSE)

# Map labels to descriptions using plyr package
all_data_filtered[,2] <- mapvalues(all_data_filtered[,2], 1:6, activity_names$V2)


## 4. Appropriately label the data set 
## with descriptive variable names. 

# bind first 2 column names with feature names
all_features <- c("Subject","Label", features_filtered[,2])
colnames(all_data_filtered) <- all_features


## 5. Create a second, independent tidy data set 
## with the average of each variable for each activity
## and each subject.

mean_data <- ddply(all_data_filtered, c("Subject","Label"), numcolwise(mean))
tidy_mean_data <- melt(mean_data, id.vars=c("Subject","Label"))
tidy_mean_data <- tidy_mean_data[order(tidy_mean_data$Subject,tidy_mean_data$Label),]

# Save final tidy dataset to file
write.table(tidy_mean_data, file="tidy_data.txt", row.name=FALSE)