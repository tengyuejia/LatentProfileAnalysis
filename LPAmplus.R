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


# Copyright 2023 Yuejia Teng, Ph.D.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
