getwd()
[1] "/Users/gm/First"
> setwd("/Users/gm/First/Accelerometer")
> getwd()
[1] "/Users/gm/First/Accelerometer"
> library(dplyr)

######################### Warning from 'xts' package ##########################
#                                                                             #
# The dplyr lag() function breaks how base R's lag() function is supposed to  #
# work, which breaks lag(my_xts). Calls to lag(my_xts) that you type or       #
# source() into this session won't work correctly.                            #
#                                                                             #
# Use stats::lag() to make sure you're not using dplyr::lag(), or you can add #
# conflictRules('dplyr', exclude = 'lag') to your .Rprofile to stop           #
# dplyr from breaking base R's lag() function.                                #
#                                                                             #
# Code in packages is not affected. It's protected by R's namespace mechanism #
# Set `options(xts.warn_dplyr_breaks_lag = FALSE)` to suppress this warning.  #
#                                                                             #
###############################################################################

Attaching package: ‘dplyr’

The following objects are masked from ‘package:xts’:
    
    first, last

The following objects are masked from ‘package:stats’:
    
    filter, lag

The following objects are masked from ‘package:base’:
    
    intersect, setdiff, setequal, union

> features <- read.table("features.txt", col.names = c("index", "feature"))
> activity_labels <- read.table("activity_labels.txt", col.names = c("code", "activity"))
> 
    > subject_train <- read.table("train/subject_train.txt", col.names = "subject")
> x_train <- read.table("train/X_train.txt", col.names = features$feature)
> y_train <- read.table("train/y_train.txt", col.names = "code")
> 
    > subject_test <- read.table("test/subject_test.txt", col.names = "subject")
> x_test <- read.table("test/X_test.txt", col.names = features$feature)
> y_test <- read.table("test/y_test.txt", col.names = "code")
> 
    > subject <- rbind(subject_train, subject_test)
> X <- rbind(x_train, x_test)
> Y <- rbind(y_train, y_test)
> 
    > # Combine all into one dataset
    > merged_data <- cbind(subject, Y, X)
> 
    > tidy_data <- merged_data %>%
    +     select(subject, code, contains("mean"), contains("std"))
> 
    > tidy_data$code <- activity_labels[tidy_data$code, 2]
> names(tidy_data)[2] <- "activity"
> 
    > names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
> names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
> names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
> names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
> names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
> names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
> 
    > final_data <- tidy_data %>%
    +     group_by(subject, activity) %>%
    +     summarise_all(mean)
> 
    > write.table(final_data, "tidy_dataset.txt", row.name=FALSE)
> 
    > View(final_data)  # Opens it in RStudio
> head(final_data)  # Shows first few rows
# A tibble: 6 × 88
# Groups:   subject [1]
subject activity           TimeBodyAccelerometer.mean…¹ TimeBodyAcceleromete…² TimeBodyAcceleromete…³
<int> <chr>                                     <dbl>                  <dbl>                  <dbl>
    1       1 LAYING                                    0.222               -0.0405                 -0.113 
2       1 SITTING                                   0.261               -0.00131                -0.105 
3       1 STANDING                                  0.279               -0.0161                 -0.111 
4       1 WALKING                                   0.277               -0.0174                 -0.111 
5       1 WALKING_DOWNSTAIRS                        0.289               -0.00992                -0.108 
6       1 WALKING_UPSTAIRS                          0.255               -0.0240                 -0.0973
# ℹ abbreviated names: ¹​TimeBodyAccelerometer.mean...X, ²​TimeBodyAccelerometer.mean...Y,
#   ³​TimeBodyAccelerometer.mean...Z
# ℹ 83 more variables: TimeGravityAccelerometer.mean...X <dbl>,
#   TimeGravityAccelerometer.mean...Y <dbl>, TimeGravityAccelerometer.mean...Z <dbl>,
#   TimeBodyAccelerometerJerk.mean...X <dbl>, TimeBodyAccelerometerJerk.mean...Y <dbl>,
#   TimeBodyAccelerometerJerk.mean...Z <dbl>, TimeBodyGyroscope.mean...X <dbl>,
#   TimeBodyGyroscope.mean...Y <dbl>, TimeBodyGyroscope.mean...Z <dbl>, …
> 
    > tidy_data <- read.table("tidy_dataset.txt", header = TRUE)
> View(tidy_data)
> 