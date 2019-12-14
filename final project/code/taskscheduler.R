
#### 17:05���� ���� 10�о� �����ٷ� ���� ####

#install.packages("taskscheduleR")
library(taskscheduleR)

dir = "C:/search/top20.R"

taskscheduler_create(taskname = "searching", rscript = dir,
                     schedule = "MINUTE", starttime = '17:05', 
                     modifier = 10,
                     startdate = format(Sys.Date(), "%Y/%m/%d"))

taskscheduler_delete(taskname = "searching")