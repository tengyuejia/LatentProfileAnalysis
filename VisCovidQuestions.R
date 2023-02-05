### code is to vidualize covid-19 impact by 4 typology (class), 
### and by 5 dimension scores * 4 typology

library(tidyverse)
library(ggthemes)
library(ggpubr)
library(dplyr)



### covid questions by profile
dim_by_demo %>% dplyr::select(cv1:cv4, Class) %>%
  mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  pivot_longer(., cols = c(cv1:cv4), 
               names_to = "Covid_question", values_to = "Value") %>%
  ggplot(aes(Value)) +
  facet_wrap(~Class+Covid_question) +
  geom_histogram(bins = 15) +
  theme_pubr() + #from ggthemes package
  xlab("Response") + 
  ylab("Frequency")

#covid questions
dim_by_demo %>% dplyr::select(cv1:cv4, Class) %>%
  mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  pivot_longer(., cols = c(cv1:cv4), 
               names_to = "Covid_question", values_to = "Value") %>%
  ggplot(aes(Value)) +
  facet_wrap(~Covid_question) +
  geom_histogram(bins = 15) +
  # theme_pubr() + #from ggthemes package
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Response") + 
  ylab("Frequency") + 
  scale_x_continuous(breaks = seq(1, 7, 1)) 

#covid question Q2
dim_by_demo %>% 
  ggplot(aes(cv2)) +
  geom_histogram(bins = 15) +
  # theme_pubr() + #from ggthemes package
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  xlab("Response") + 
  ylab("Frequency") + 
  scale_x_continuous(breaks = seq(1, 7, 1)) +
  scale_y_continuous(breaks = seq(0, 300, 50)) #+
# ylim(0,NA)

# scatterplot b/w 5 dimensions for each covid question for each profile
#Q1
dim_by_demo %>% dplyr::select(cv1, cv3, cv4, Class, AD:SS) %>%
  mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  # pivot_longer(., cols = c(cv1, cv3, cv4), 
  #              names_to = "Covid_question", values_to = "Covid_Value") %>%
  pivot_longer(., cols = c(AD:SS), 
               names_to = "Var", values_to = "Response") %>% 
  ggplot(aes(x = Response, y = cv1)) + 
  geom_point(aes(), size = 0.5) + 
  geom_smooth(method=lm, formula = y ~ x, na.rm = T, colour = "black", size = 0.5) + 
  facet_grid(Var ~ Class) + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Observed Score") +
  ylab("Covid-19's Impact on Employment") +
  scale_x_continuous(breaks = seq(1, 5, 1)) +
  # scale_y_continuous(breaks = seq(1, 5, 1)) + 
  ylim(1,5) +
  stat_cor(method = "pearson", label.x = 1, label.y = 1.5, size = 3,
           # digits = 2,
           p.accuracy = 0.001, r.accuracy = 0.01) 

#Q3
dim_by_demo %>% dplyr::select(cv1, cv3, cv4, Class, AD:SS) %>%
  mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  # pivot_longer(., cols = c(cv1, cv3, cv4), 
  #              names_to = "Covid_question", values_to = "Covid_Value") %>%
  pivot_longer(., cols = c( AD:SS), 
               names_to = "Var", values_to = "Response") %>% 
  ggplot(aes(x = Response, y = cv3)) + 
  geom_point(aes(), size = 0.5) + 
  geom_smooth(method=lm, formula = y ~ x, na.rm = T, colour = "black", size = 0.5) + 
  facet_grid(Var ~ Class) + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Observed Score") +
  ylab("Covid-19's Overall Impact") +
  scale_x_continuous(breaks = seq(1, 5, 1)) +
  # scale_y_continuous(breaks = seq(1, 5, 1)) + 
  ylim(1,5) +
  stat_cor(method = "pearson", label.x = 1, label.y = 1.5, size = 3,
           # digits = 2,
           p.accuracy = 0.001, r.accuracy = 0.01) 

#Q4
dim_by_demo %>% dplyr::select(cv1, cv3, cv4, Class, AD:SS) %>%
  mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  # pivot_longer(., cols = c(cv1, cv3, cv4), 
  #              names_to = "Covid_question", values_to = "Covid_Value") %>%
  pivot_longer(., cols = c( AD:SS), 
               names_to = "Var", values_to = "Response") %>% 
  ggplot(aes(x = Response, y = cv4)) + 
  geom_point(aes(), size = 0.5) + 
  geom_smooth(method=lm, formula = y ~ x, na.rm = T, colour = "black", size = 0.5) + 
  facet_grid(Var ~ Class) + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Observed Score") +
  ylab("Covid-19's Emotional Impact") +
  scale_x_continuous(breaks = seq(1, 5, 1)) +
  # scale_y_continuous(breaks = seq(1, 5, 1)) + 
  ylim(1,5) +
  stat_cor(method = "pearson", label.x = 1, label.y = 1.5, size = 3,
           # digits = 2,
           p.accuracy = 0.001, r.accuracy = 0.01) 


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
