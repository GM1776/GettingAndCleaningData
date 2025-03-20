# CodeBook for Getting and Cleaning Data Project

## **1. Data Source**
This dataset is derived from the "Human Activity Recognition Using Smartphones" dataset available from the UCI Machine Learning Repository.

## **2. Data Description**
The dataset contains information from accelerometer and gyroscope readings collected from 30 volunteers performing daily activities.

## **3. Variables in the Tidy Dataset**
The tidy dataset contains the following key variables:

- `subject`: ID of the volunteer (1-30)
- `activity`: The type of physical activity performed
- `timeBodyAccelerometer-mean()-X`
- `timeBodyAccelerometer-mean()-Y`
- `timeBodyAccelerometer-mean()-Z`
- (List all relevant variables here)

## **4. Data Cleaning and Transformations**
The following transformations were performed:
1. Merged the training and test datasets.
2. Extracted only the **mean and standard deviation** measurements.
3. Used descriptive **activity names** instead of numerical labels.
4. Labeled the dataset with **meaningful variable names**.
5. Created a final **tidy dataset** with the **average of each variable per subject and activity**.

## **5. Output File**
The final cleaned dataset is saved as:
- `tidy_dataset.txt`
