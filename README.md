# Getting and Cleaning Data: Course Project


### Introduction
`run_analysis.R` script will perform the following:
        1. Downloads the zip file containing the data sets
        2. Unzips the downloaded files, and renames the directory to 
        a "spaceless" name
        3. Renames the data sets' variables to a more intuitive convention
        4. Extracts only the variables that reflect either the *mean* or 
        *standard deviation* of one of the signals
        5. Joins the signal data (found in `X_[train/test].txt` with
        `y_[train/test].txt` (reflects what activity generated aforementioned 
        signal measurements) and `subject_[tran/test].txt` (which subject 
        performed the aforementioned activity).
        6. Replaces activity index with its corresponding label
        7. Creates a second, independent tidy data set with the average of 
        each variable for each activity and each subject.
        8. Produces 2 csvs, each corresponding to one of the tidy datasets
        mentioned above (`out/tidy.csv` and `out/averageTidy.csv`)
        
        
        
### Prerequisites
* Have `tidyverse` installed



### About the Code Book
This repo also contains a CodeBook.md file that explains the data in detail.
