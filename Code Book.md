
# Code Book
This document describes how the tidy data is produced

## Data Origin
The data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself can be obtainined here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The README.txt provides information about the data. The file features_info.txt provides a good description of the measurements.

For this project, raw inertial signal data was not used (data in `./test/Inertial Signals` and
`.train/Inertial Signals`).

## Tidy Data Transformations
The following transformations where performed:
- The training and testing sets where merged in a single data frame called "merged" ("merged" also contains the subject and the activity). Only the columns that contain either `mean` or `std` where retained.
- The activity identifier was replaced by the corresponding activity label as specified in the file `activity_labels.txt`
- a new data frame "tidy" has been created by averaging all variables grouped by activity and subject
- "tidy" is the output of the process
