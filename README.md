###Coursera - Getting and Cleaning Data
======================================
 #### Objective : 
 The purpose of this script is to clean the data set for further analaysis. 
File to run_analysis.R

 #### Requirements:
 - Download the dataset from this URL (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip
 - Set Working directory to this folder to run_anlaysis.R script

####Script flow :

-Data from test and train files are loaded and combined (Subject,Labels)

-The features labels are input from features.txt. The indices containing the mean() or the std() measures are stored in a vector (indices), and the the features corresponding tto those indices are stored in a vector(features).

-The test and train features are concatenated and all columns are removed that do not have an index in the indices vector; only the columns with a mean() or std() remain.

-A new data set,tidydata, is created by aggregating the merged dataset based on the mean of all numeric columns by the subject and activity.

-tidydata is output to a file named tidydata.txt

####Output:

After being run, run_analysis.R ,output of the tidy data set in a text file named tidydata.txt in the directory it was run from.