### Load Mplus scripts and run LPA models automatically
### and save outputs in csv files


packagetoload <- c("tidyverse","psych","Hmisc","lavaan","lm.beta","stringr")
sapply(packagetoload,library, character.only = T, quietly = T)
library(dplyr)
library(MplusAutomation)
library(here)
library(beepr)
# library(plyr)
# currentpath <- getwd()
# currentpath
loc <- paste(here::here(),"Mplus R Automation",sep = "/")

# loc <- paste(here::here(),"Mplus R Automation","Tech14",sep = "/")
loc 

runModels(paste(loc, "model_1_class_1.inp", sep = "/")) -> c1
runModels(paste(loc, "model_1_class_2.inp", sep = "/")) -> c2
runModels(paste(loc, "model_1_class_3.inp", sep = "/")) -> c3
runModels(paste(loc, "model_1_class_4.inp", sep = "/")) -> c4
runModels(paste(loc, "model_1_class_5.inp", sep = "/")) -> c5
runModels(paste(loc, "model_1_class_6.inp", sep = "/")) -> c6


allOutput<-readModels(paste(loc,"Output", sep = "/"), recursive=F)
justSummaries <- do.call("rbind.fill",sapply(allOutput,"[", "summaries"))
write.csv(justSummaries,paste(paste(loc,"Output", sep = "/"), 
                              "output_indices.csv",
                              sep = "/"))

#################################################



# just to get Tech14 output
# number of boostrap draws requested (5)
# 0 start
runModels(paste(loc, "Tech14", "model_1_class_1.inp", sep = "/")) -> c1.14
beep()
runModels(paste(loc, "Tech14", "model_1_class_2.inp", sep = "/")) -> c2.14
beep()
runModels(paste(loc, "Tech14", "model_1_class_3.inp", sep = "/")) -> c3.14
beep()
runModels(paste(loc, "Tech14", "model_1_class_4.inp", sep = "/")) -> c4.14
beep()
runModels(paste(loc, "Tech14", "model_1_class_5.inp", sep = "/")) -> c5.14
beep()
runModels(paste(loc, "Tech14", "model_1_class_6.inp", sep = "/")) -> c6.14
beep()
beep()


allOutput<-readModels(paste(loc,"Output", sep = "/"), recursive=F)
justSummaries <- do.call("rbind.fill",sapply(allOutput,"[", "summaries"))
write.csv(justSummaries,paste(paste(loc,"Output", sep = "/"), 
                              "output.csv",
                              sep = "/"))