#### Conduct EFA and CFA (correlated, high-order, and bi-factor models)

packagetoload <- c("tidyverse","psych","Hmisc","lavaan","lm.beta","here")
sapply(packagetoload,library, character.only = T, quietly = T)


############ EFA on 5by5 RS ############
# library(psych)
## 
psych::scree(dat.RS5by5,factors = F,pc=F,hline=NULL)
efa.ml.oblimin<-psych::fa(dat.RS5by5,nfactors = 5,rotate = "oblimin",fm="ml")
efa.ml.oblimin
print(efa.ml.oblimin$loadings, cut = .30)


############ CFA on 5by5 RS ############
# library(lavaan)

### correlated factor model
cfa.correlated<-'
F1 =~ X5by5_1 + X5by5_2 + X5by5_3 + X5by5_4 + X5by5_5
F2 =~ X5by5_6 + X5by5_7 + X5by5_8 + X5by5_9 + X5by5_10
F3 =~ X5by5_11 + X5by5_12 + X5by5_13 + X5by5_14 + X5by5_15
F4 =~ X5by5_16 + X5by5_17 + X5by5_19 + X5by5_20
F5 =~ X5by5_21 + X5by5_24 
'
cfa.correlated.fit<-cfa(cfa.correlated,fmi = TRUE,  data = dat.RS5by5 %>% select(X5by5_1:X5by5_25))
summary(cfa.correlated.fit, fit.measures=T, standardized=T, rsquare=T)

### high-order model
cfa.higherorder<-'
F1 =~ X5by5_1 + X5by5_2 + X5by5_3 + X5by5_4 + X5by5_5
F2 =~ X5by5_6 + X5by5_7 + X5by5_8 + X5by5_9 + X5by5_10
F3 =~ X5by5_11 + X5by5_12 + X5by5_13 + X5by5_14 + X5by5_15
F4 =~ X5by5_16 + X5by5_17 + X5by5_19 + X5by5_20
F5 =~ X5by5_21 + X5by5_24

Res =~ F1 + F2 + F3 + F4 + F5
'
cfa.higherorder.fit<-lavaan::cfa(cfa.higherorder,fmi = TRUE, data = dat.RS5by5 %>% select(X5by5_1:X5by5_25))
summary(cfa.higherorder.fit, fit.measures=T, standardized=T, rsquare=T)


### bi-order model
cfa.bifactor<-'
F1 =~ X5by5_1 + X5by5_2 + X5by5_3 + X5by5_4 + X5by5_5
F2 =~ X5by5_6 + X5by5_7 + X5by5_8 + X5by5_9 + X5by5_10
F3 =~ X5by5_11 + X5by5_12 + X5by5_13 + X5by5_14 + X5by5_15
F4 =~ X5by5_16 + X5by5_17 + X5by5_19 + X5by5_20
F5 =~ X5by5_21 + X5by5_24 + X5by5_25

Res =~ X5by5_1 + X5by5_2 + X5by5_3 + X5by5_4 + X5by5_5
+ X5by5_6 + X5by5_7 + X5by5_8 + X5by5_9 + X5by5_10
+ X5by5_11 + X5by5_12 + X5by5_13 + X5by5_14 + X5by5_15
+ X5by5_16 + X5by5_17 + X5by5_19 + X5by5_20
+ X5by5_21 + X5by5_24 + X5by5_25

Res  ~~ 0*F1 + 0*F2 + 0*F3 + 0*F4 + 0*F5
F1 ~~ 0*F2 + 0*F3 + 0*F4 + 0*F5
F2 ~~ 0*F3 + 0*F4 + 0*F5
F3 ~~ 0*F4 + 0*F5
F4 ~~ 0*F5
'
cfa.bifactor.fit<-lavaan::cfa(cfa.bifactor,fmi = TRUE, data = dat.RS5by5 %>% select(X5by5_1:X5by5_25))
summary(cfa.bifactor.fit, fit.measures=T, standardized=T, rsquare=T)

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
