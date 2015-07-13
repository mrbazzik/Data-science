library(dplyr)
features_names <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
activity_labels <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")

d_train <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
subjects_train <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
activities_train <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")

d_test <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
subjects_test <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
activities_test <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")

d_full<-rbind(d_train, d_test)

means_sds <- filter(features_names, grepl("mean\\(\\)|std\\(\\)",V2))
d_full<-d_full[,means_sds$V1]
names(d_full) <- means_sds$V2

d_full$Subject <- c(subjects_train$V1,subjects_test$V1)

d_full$Activity <- c(activities_train$V1, activities_test$V1)
d_full$Activity <- factor(d_full$Activity)
levels(d_full$Activity) <- levels(activity_labels$V2)

d_fullg <- group_by(d_full, Activity, Subject)
d_fullg <- summarise_each(d_fullg, funs(mean))

