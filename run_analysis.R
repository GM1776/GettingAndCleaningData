# Load necessary libraries
library(dplyr)

# Read feature names and activity labels
features <- read.table("features.txt", col.names = c("index", "feature"))
activity_labels <- read.table("activity_labels.txt", col.names = c("code", "activity"))

# Read training data
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$feature)
y_train <- read.table("train/y_train.txt", col.names = "code")

# Read test data
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features$feature)
y_test <- read.table("test/y_test.txt", col.names = "code")

# Combine training and test data
subject <- rbind(subject_train, subject_test)
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)

# Merge all data into one dataset
merged_data <- cbind(subject, Y, X)

# Select only mean and standard deviation columns
tidy_data <- merged_data %>%
    select(subject, code, contains("mean"), contains("std"))

# Replace activity codes with descriptive labels
tidy_data$code <- activity_labels[tidy_data$code, 2]
names(tidy_data)[2] <- "activity"

# Rename columns for better readability
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# Create final tidy dataset by averaging variables per subject and activity
final_data <- tidy_data %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

# Save final dataset to a file
write.table(final_data, "tidy_dataset.txt", row.names = FALSE)

# Inspect final dataset
View(final_data)
head(final_data)

