#### use item response theory (IRT) modeling and aberrant responding detection
packagetoload <- c("tidyverse","psych","Hmisc","lavaan","lm.beta","here")
sapply(packagetoload,library, character.only = T, quietly = T)
library(dplyr)

library(mirt)
library(ltm)
library(PerFit)

# bi-factor multidimensional IRT
bfmodel <- mirt.model('
                      G = 1-25,
                      F1 = 1-5,
                      F2 = 6-10,
                      F3 = 11-15,
                      F4 = 16-20,
                      F5 = 21-25
                      ')
gmodelbf <- mirt(dat_resilience, bfmodel, itemtype="graded")
gmodelbf <- mirt(data = dat_resilience,
               # model = 5,
               model = bfmodel,
               itemtype="graded",
               # method = 'QMCEM', # quasi-Monte Carlo EM estimation
               #SE.type = "SEM", # the supplemented EM
               # methods such as the 'QMCEM', 'MCEM', 'SEM', or 'MHRM' should be used when the dimensions are 3 or mor
               verbose = TRUE,
               SE = TRUE
               # technical = list(NCYCLES = 1000)
)
gmodelbf
summary(gmodelbf)
anova(gmodelbf)
print(gmodelbf)
# model fit
wald(gmodelbf) #Test and Statistics for Model fit
M2(gmodelbf,na.rm = T, QMC = T) #Global fit statistics


gmodelbf.fs <- fscores(gmodelbf,method = 'EAPsum',full.scores = TRUE, full.scores.SE = TRUE)
gmodelbf.fs

# item fit
gmodel.itemfit <- itemfit(gmodel,
                          fit_stats = c('S_X2','Zh'),
                          # S_X2.tables = TRUE,
                          method = 'MAP',
                          QMC=TRUE) #item fit info
gmodel.itemfit

# person fit
gmodel.personfit <- personfit(gmodel,
                              method = 'MAP',
                              stats.only = T,
                              QMC=TRUE) #person fit
gmodel.personfit

# cut off lower 10% quantile value of lz values 
gmodel.personfit.Zh.low10 <- quantile(gmodel.personfit$Zh, probs = c(0.10))
gmodel.personfit.Zh.low10.idx <- which(gmodel.personfit$Zh < gmodel.personfit.Zh.low10)
gmodel.personfit.Zh.low10.idx
length(gmodel.personfit.Zh.low10.idx)
dat_resilience_new <- dat_resilience[-gmodel.personfit.Zh.low10.idx,]


# vidualize the distrubtion of lz statistic (index to detect aberrant responses)
# add the cutoff score to eliminate aberrant responses
ggplot(gmodel.personfit, aes(x = Zh)) +
  geom_density() + 
  scale_x_continuous(name = "lz Value",
                     breaks = seq(-15,5,5),
                     limits=c(-15,5)) +
  scale_y_continuous(name = "Density") +
  geom_vline(xintercept = -8.7, size = 0.5, linetype = "dashed") + 
  theme_classic() + 
  theme( axis.text.x=element_text(colour="black", size = 9),
         axis.text.y=element_text(colour="black", size = 9))



