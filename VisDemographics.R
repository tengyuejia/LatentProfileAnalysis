### code is to vidualize demographic information by typology (class)

library(tidyverse)
library(ggthemes)
library(ggpubr)
library(dplyr)

#### US Regions
with(dim_by_demo, table(Q95, Class))
#freq barplot
dim_by_demo %>% ggplot(aes(x=factor(Q95))) +
  geom_bar(stat="count", width=0.7) + 
  facet_grid(~Class) +
  coord_flip() +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  ylab("Frequency") + 
  xlab("US States")

#perc barplot
dim_by_demo %>% ggplot(aes(x=factor(Q95))) +
  geom_bar(aes(y = (..count..)/sum(..count..)*100), width=0.7) + 
  facet_grid(~Class) +
  coord_flip() +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  ylab("Percentage(%)") + 
  xlab("US States")

ggplot(dim_by_demo, aes(Q95, group = Class)) +
          geom_bar(aes(y = ..prop..,
                       fill = factor(..x..)), stat="count") +
          scale_y_continuous(labels=scales::percent) +
          ylab("relative frequencies") +
          facet_grid(~Class) +
  coord_flip()


#### age
dim_by_demo %>% dplyr::select(age:employment_status, Class) %>%
  ggplot(aes(age)) +
  facet_wrap(~Class) +
  geom_histogram(bins = 15) +
  # theme_pubr() + #from ggthemes package
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Age") + 
  ylab("Frequency") + 
  scale_x_continuous(breaks = seq(18, 80,10 ))


#### education background

dim_by_demo %>% dplyr::select(age:employment_status, Class) %>%
  group_by(Class, edu) %>%
  summarise(edu_freq = n()) %>% ungroup() %>% 
  ggplot(aes(x = factor(edu), y = edu_freq)) +
  geom_bar(stat="identity") + 
  geom_text(aes(label=edu_freq), vjust=-0.5, color="Black", size=3) +
  facet_wrap(~Class) +
  # geom_histogram(bins = 10,binwidth = 0.6,boundary = 0) +
  # theme_pubr() + #from ggthemes package
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Education") + 
  ylab("Frequency") #+
# scale_y_continuous(breaks = seq(0, 10, 1)) 

# barplot for counts
dim_by_demo %>% ggplot(aes(x=factor(edu))) +
  geom_bar(stat="count", width=0.7) + 
  facet_wrap(~Class) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  xlab("Education") + 
  ylab("Frequency") 
