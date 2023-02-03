#### clean and create datasets to further analysis

packagetoload <- c("tidyverse","psych","Hmisc","lavaan","lm.beta","here")
sapply(packagetoload,library, character.only = T, quietly = T)
library(dplyr)


# scale all variables and combine datasets
dat.obsscore.all.scaled <- dat.obsscore.all %>% 
  dplyr::select(PA:age, AD:SS) %>% 
  mutate_all(scale) %>% 
  mutate_all(as.numeric) %>%
  mutate_all(~round(.,digits=2)) %>%
  # rename(AD_obs = AD, ER_obs = ER, OP_obs = OP, SE_obs = SE, SS_obs = SS) %>% 
  bind_cols(
    dat.obsscore.all %>% dplyr::select(sex:cv4),
    dat.obsscore.all %>% dplyr::select(AD:SS) %>% 
      rename(AD_raw = AD, 
             ER_raw = ER, 
             OP_raw = OP, 
             SE_raw = SE, 
             SS_raw = SS),
    dat.esemfscore.class %>% dplyr::select(Class))
glimpse(dat.obsscore.all.scaled)

# 
dim_by_outcome <-  dat.obsscore.all.scaled %>% 
  dplyr::select(AD:SS, LifeSat:jobburnout,DASS.stress, PA:Big5.open) %>%
  bind_cols(
    dat.esemfscore.class %>% dplyr::select(Class)
  )  %>%
  mutate(Class = factor(Class))


### create summary/descriptive statistics
dim_by_outcome %>% select(PA:Class) %>%
  group_by(Class) %>%
  summarise_all(funs(mean(., na.rm = T), 
                     sd(., na.rm = T),
                     sd(., na.rm = T)/sqrt(length(.)))) -> dat_summary

#convert to long format for vidualization
dat_summary_long <- dat_summary %>% 
  pivot_longer(cols = c(-Class), names_to = "Var", values_to = "Value") %>%
  separate("Var", into = c("Variable","descriptive"), sep = "_") %>%
  pivot_wider(names_from = "descriptive",values_from = "Value")  

dat_summary_long %>%
  ggplot(aes(x=Variable, y=mean,fill=Class )) + 
  geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean - stderr, ymax=mean + stderr), width=.1,
                position=position_dodge(.9)) +
  # facet_grid(~Class) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle=45)) +
  scale_fill_grey(start = 0.3, end = 0.8) +
  xlab("Personality") +
  ylab("Mean Score") 


