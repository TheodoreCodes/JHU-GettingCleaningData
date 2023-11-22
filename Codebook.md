# CodeBook for the tidy dataset

### Data source
This dataset relies entirely on the "Human Activity Recognition Using 
Smartphones Data Set", which was originally made available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**NOTE**: The reasoning behind the result of this script is: "Extracts only the
measurements on the mean and standard deviation for each measurement" (in line
with the the task of the course project)

### Feature selection
The following is an altered excerpt from the README.txt and features_info.txt files
that came with the original dataset, which you should check for a complete
description (can be found in the `data/` folder)

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeDomainAcc[XYZ] and timeDomainGyro[XYZ]. These time domain signals (prefixed with *timeDomain*) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (marked by the presence of *Acc*) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (denoted by the presence of *Jerk*). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing the frequency domain signals (denoted by the prefix *freqDomain*)

##### For each record it is provided:
* An identifier of the subject who carried out the experiment.
* Its activity label. 
* The mean and standard deviation of the following signals, measured on 3 axis:
    * timeDomainBodyAcc
    * timeDomainGravityAcc
    * timeDomainBodyAccJerk
    * timeDomainBodyGyro
    * timeDomainBodyGyroJerk
    * timeDomainBodyAccMagnitude
    * timeDomainGravityAccMagnitude
    * timeDomainBodyAccJerkMagnitude
    * timeDomainBodyGyroMagnitude
    * timeDomainBodyGyroJerkMagnitude
    * freqDomainBodyAcc
    * freqDomainBodyAccJerk
    * freqDomainBodyGyro
    * freqDomainBodyAccMagnitude
    * freqDomainBodyAccJerkMagnitude
    * freqDomainBodyGyroMagnitude
    * freqDomainBodyGyroJerkMagnitude

*NOTE*: Pattern `<signal_name>.<function>.<axis>` is used to denote the result
of the function applied on the signal on the axis (e.g timeDomainBodyAcc.mean.X
represents the mean of the body acceleration on the X-axis)

