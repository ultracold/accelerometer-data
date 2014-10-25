# README for run_analysis.R

#### Overview

run_analysis.R handles the Samsung accelerometer data that can be found at the address:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

More information about the raw data set can be found in the above .zip file.

The script run_analysis.R produces a tidy data set tidyAccelerometerData.txt.

#### Instructions

Download the acceleromter data from the above web address, placing the data in your working directory with the script run_analysis.R.

Run run_analysis.R


#### What the code does:

Takes the data and produces a tidy data set with the features that can be found in CodeBook.md.

As per the project brief, only the features that are a mean or standard deviations (std) of a measurement are retained, hence the raw data in the subfolders of the data set are ignored. From the project brief, which values are actually mean or std values can be debated, therefore, so that no required data is ommited, all features containing the text "mean" or "std" are retained.

The tidy data set can be found in tidyAccelerometerData.txt, which is the output of the run_analysis.R.

#### Details

The code uses the following libraries above {base}:

plyr

data.table

It then goes through the following steps:

1. import features.txt and activity_labels.txt:

For the train data set:

2. read in X_train.txt.

3. give X_train the column names of features.txt.

4. select only the column names in X_train that are associated with a mean or std.

5. read in y_train.txt

6. use "y" as column name for consistency with original data.

7. read in subject_train.txt.

8. use the activity_labels to add a column to y_train that indicates the activity (in words) that the factor "y" refers to.

9. create the trainDataSet from subject_train, y_train, and X_train_reduced

For the test data set:

10. read in X_test.txt.

11. give X_test the column names of features.txt.

12. select only the column names in X_test that
are associated with a mean or std.

13. now read in y_test.txt

14. use "y" as column name for consistency with original date

15. read in subject_test.txt and give column a name.

16. use the activity_labels to add a column to y_test that indicates the activity (in words) that the factor "y" refers to.

17. now create the testDataSet from subject_test, y_test, and X_test_reduced

Join train and test data sets together

18. add the test and train data frame together:

19. clean up row.names:

20. up to now, we have used the column "y" as the activity factor, since it was useful when working with the data. However, we can now remove it since the "activity"" column contains essentially the same data:

Finally, write the tidy data set simplifiedData to a .txt file named tidyAccelerometerData.txt.

#### Import tidyAccelerometerData.txt

To import the data into R, use the following command:

read.table("tidyAccelerometerData.txt",
            sep="\t", header = TRUE)
            
#### Notes on the original data set:

From documents provided wih the original data set:

Notes: 

- Features are normalized and bounded within [-1,1].

For more information about this dataset contact: activityrecognition@smartlab.ws

License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.



