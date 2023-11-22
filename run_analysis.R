library(tidyverse)

run <- function() {
        downloadData()
        
        tidyTibble <- tidyData()
        writeTidyCsv(tidyTibble, "tidy")
        
        meanTidyTibble <- meanBySubjectAndActivity(tidyTibble)
        writeTidyCsv(meanTidyTibble, "averageTidy")
}

downloadData <- function() {
        datasetsZipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        if (!file.exists("./data")) {
                dir.create("./data")
        }
        
        
        if (!file.exists("./data/datasets")) {
                datasetsZipFilePath <- "./data/datasets.zip"
                
                # Download .zip file
                download.file(
                        url = datasetsZipFileUrl,
                        destfile = datasetsZipFilePath
                )
                
                # Unzip archive
                unzip(
                        zipfile = datasetsZipFilePath,
                        exdir = "./data"
                )
                
                # Rename un-zipped folder for ease of use
                file.rename(
                        from = "./data/UCI HAR Dataset",
                        to = "./data/datasets"
                )
        }
}


tidyData <- function() {
        datasetsRoot <- "./data/datasets/%s"
        
        # Import features
        features <- read_table(
                file = sprintf(datasetsRoot, "features.txt"),
                col_names = c("index", "feature")
        ) %>% filter(grepl('mean\\(\\)|std\\(\\)', feature))
        
        features$feature <- str_replace_all(features$feature, "^t", "timeDomain")
        features$feature <- str_replace_all(features$feature, "^f", "freqDomain")
        features$feature <- str_replace_all(features$feature, "\\(\\)", "")
        features$feature <- str_replace_all(features$feature, "Mag", "Magnitude")
        features$feature <- str_replace_all(features$feature, "-", ".")
        
        # Import activity labels and their respective indices
        activities <- read_table(
                file = sprintf(datasetsRoot, "activity_labels.txt"),
                col_names = c("index", "activity")
        )
        
        
        # IMPORT TRAINING DATA
        
        # Import training activities column
        trainingActivities <- read_table2(
                file = sprintf(datasetsRoot, "train/y_train.txt"),
                col_names = c("index")
        ) %>% left_join(activities)
        
        # Import training test subjects column
        trainingSubjects <- read_table2(
                file = sprintf(datasetsRoot, "train/subject_train.txt"),
                col_names = c("subject")
        )
        
        # Import training data, and only keep the variables that
        # represent either a `mean` or a `standard deviation` variable
        trainingData <- read_table2(
                file = sprintf(datasetsRoot, "train/X_train.txt"),
                col_names = FALSE
        ) %>%
                select(features$index) %>% 
                setNames(features$feature) %>% 
                # Column-bind to the left of the tibble the `activity` label
                cbind(activity = trainingActivities$activity, .) %>% 
                cbind(subject = trainingSubjects$subject, .)
        
        
        # IMPORT TEST DATA
        
        # Import test activities column
        testActivities <- read_table2(
                file = sprintf(datasetsRoot, "test/y_test.txt"),
                col_names = c("index")
        ) %>% 
                left_join(activities)
        
        # Import test test subjects
        testSubjects <- read_table2(
                file = sprintf(datasetsRoot, "test/subject_test.txt"),
                col_names = c("subject")
        )
        
        # Import test data, and only keep the variables that
        # represent either a `mean` or a `standard deviation` variable
        testData <- read_table2(
                file = sprintf(datasetsRoot, "test/X_test.txt"),
                col_names = FALSE
        ) %>%
                select(features$index) %>% 
                setNames(features$feature) %>% 
                # Column-bind to the left of the tibble the `activity` label
                cbind(activity = testActivities$activity, .) %>% 
                cbind(subject = testSubjects$subject, .)
        
        
        bind_rows(trainingData, testData)
}


meanBySubjectAndActivity <- function(tidyTibble) {
        tidyTibble %>% 
                group_by(subject, activity) %>% 
                summarise_all("mean")
}  


writeTidyCsv <- function(outputTibble, filename) {
        if (!file.exists("./out")) {
                dir.create("./out")
        }
        
        
        write_csv(outputTibble, file = sprintf("./out/%s.csv", filename))
}