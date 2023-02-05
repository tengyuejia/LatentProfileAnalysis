### code is to vidualize the correlations between outcome variables 
### by and dimensions of resilience  by 4 typology (class), 
### and by 5 dimension scores * 4 typology
### correlation coefficients are added to the plots


library(tidyverse)
library(ggthemes)
library(ggpubr)
library(dplyr)


### life satisfaction
#LifeSat
fig.lifesat <- dim_by_outcome %>% mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  pivot_longer(., cols = c(AD, ER, OP, SE, SS), 
               names_to = "Var", values_to = "Value") %>% 
  ggplot(aes(x = Value, y = LifeSat)) +
  geom_point(aes(), size = 0.5) + 
  geom_smooth(method=lm, formula = y ~ x, na.rm = T, colour = "black", size = 0.5) +
  # stat_summary(fun.y = mean, geom="line") +
  # stat_summary(aes(x = Value, y = LifeSat), fun = "mean", geom = "line")+
  facet_grid(Var ~ Class) +
  # stat_function(fun=mean,geom = "line") +
  # stat_summary(fun.y="mean", geom="line", size=1.1, aes(x = Value, y = LifeSat))+
  # geom_line(aes(linetype=Value), size = 1, stat="summary", fun.y=mean, linetype = "dotted") +
  # stat_summary(fun.y="mean", geom="line", size=1.1, aes(linetype = Value), show.legend=FALSE)+
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Observed Score") +
  ylab("Life Satisfaction") +
  scale_x_continuous(breaks = seq(1, 5, 1)) #+
# scale_y_continuous(breaks = seq(1, 7, 1))

fig.lifesat + ggpubr::stat_cor(method = "pearson", label.x = 1, label.y = 0, size = 3,
                               # digits = 2,
                               p.accuracy = 0.001, r.accuracy = 0.01) #+
# stat_mean(aes(LifeSat), geom="line")






### stress (part of psychological distress)
fig.stress <- dim_by_outcome %>% mutate(id = seq(1:nrow(dim_by_outcome))) %>% 
  pivot_longer(., cols = c(AD, ER, OP, SE, SS), 
               names_to = "Var", values_to = "Value") %>% 
  ggplot(aes(x = Value, y = DASS.stress)) +
  geom_point(aes(), size = 0.5) + 
  geom_smooth(method=lm, formula = y ~ x, na.rm = T, colour = "black", size = 0.5) +
  # stat_summary(fun.y = mean, geom="line") +
  # stat_summary(aes(x = Value, y = LifeSat), fun = "mean", geom = "line")+
  facet_grid(Var ~ Class) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Observed Score") +
  ylab("Stress") +
  scale_x_continuous(breaks = seq(1, 5, 1)) #+
# scale_y_continuous(breaks = seq(1, 7, 1))

fig.stress + stat_cor(method = "pearson", label.x = 1, label.y = -0.5, size = 3,
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
