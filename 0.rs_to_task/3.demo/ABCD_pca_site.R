###### load mri info #####
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/connectome21/2021-1/project/GAN/data")
mri <- read.csv("mri_info.csv")
names(mri) <- gsub("mri_info_", "", names(mri))
mri <- mri[,-c(2,3,4,7)]

'''
###### load brain data #####
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/abcd final/Brain")
df <- read.csv("final.mor.csv")
#df <- read.csv("final.ct.csv")
#df <- read.csv("final.morct.csv")
'''

###### load fmri data #####
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/connectome21/2021-1/project/GAN/data")
df <- read.csv("midaparc03_pre.csv")
df.x <- df[-1,] #exclude explanation of variable

library(dplyr)
df.xx <- df %>% filter(eventname == 'baseline_year_1_arm_1')
locs.redundant <- c(which(names(df.xx) == 'collection_id'), which(names(df.xx) == 'midaparc03_id'), 
                    which(names(df.xx) == 'dataset_id'), which(names(df.xx) == 'src_subject_id'), which(names(df.xx) == 'interview_date'), 
                    which(names(df.xx) == 'eventname'), which(names(df.xx) == 'tfmri_mid_all_b_visitid'), 
                    which(names(df.xx) == 'tfmri_mid_all_b_tr'), which(names(df.xx) == 'tfmri_mid_all_b_numtrs'),
                    which(names(df.xx) == 'tfmri_mid_all_b_dof'), which(names(df.xx) == 'tfmri_mid_all_b_nvols'), 
                    which(names(df.xx) == 'tfmri_mid_all_b_subthreshnvols'), which(names(df.xx) == 'tfmri_mid_all_b_meanmotion'),
                    which(names(df.xx) == 'tfmri_mid_all_b_maxmotion'), which(names(df.xx) == 'tfmri_mid_all_b_meantrans'),
                    which(names(df.xx) == 'tfmri_mid_all_b_maxtrans'), which(names(df.xx) == 'tfmri_mid_all_b_meanrot'), 
                    which(names(df.xx) == 'tfmri_mid_all_b_maxrot'), 
                    which(names(df.xx) == 'collection_title'), which(names(df.xx) == 'study_cohort_name'))
df.xxx <- df.xx[,-locs.redundant]

###### load demo data #####
setwd('/Users/bettybetty3k/Library/Mobile Documents/com~apple~CloudDocs/abcd final/Phenotype')
demo <- read.csv("demo.nih.cbcl.11875.csv")
demo$subjectkey <- gsub("NDAR", "NDAR_", demo$subjectkey)
demo %>% filter(abcd_site != 22)

##### data preparation #####
'''
#### merge data1
dfmri <- merge(mri, df.xxx, by ='subjectkey')

dfmri <- lapply(dfmri, as.numeric)
dfmri <- as.data.frame(dfmri)

#dfmri$manufacturer <- as.factor(dfmri$manufacturer)
dfmri$manufacturersmn <- as.factor(dfmri$manufacturersmn)
dfmri$deviceserialnumber <- as.factor(dfmri$deviceserialnumber)
#dfmri$magneticfieldstrength <- as.factor(dfmri$magneticfieldstrength)
dfmri$softwareversion <- as.factor(dfmri$softwareversion)

dfmri$sex <- as.factor(dfmri$sex)
#dfmri$race.ethnicity <- as.factor(dfmri$race.ethnicity)
#dfmri$abcd_site <- as.factor(dfmri$abcd_site)
'''
#### merge data2
demo.df <- merge(demo, df.xxx, by = 'subjectkey')
demo.df <- lapply(demo.df, as.numeric)
demo.df <- as.data.frame(demo.df)

demo.df$female <- as.factor(demo.df$female)
demo.df$race.ethnicity <- as.factor(demo.df$race.ethnicity)
demo.df$abcd_site <- as.factor(demo.df$abcd_site)
head(str(demo.df))

##########################33
demo.df.prep <- demo.df[,c(34, 39, 46:length(demo.df))]
demo.df.prep <- na.omit(demo.df.prep)
brain <- demo.df.prep[,c(3:length(demo.df.prep))] #from 'tfmri_ma_acdn_b_scs_cbwmlh'

### 
library(dplyr)
library(tidyr)

brain.gather<- gather(demo.df,prep, female, abcd_site, female:abcd_site)
brain.prep <- na.omit(brain)

head(names(brain.prep), n = 10)

### debugging is needed
brain.prep2 <- merge(demo.df.prep[,c(1,2)], brain.prep, by = )
site <- brain.prep[, 1]
brain <- dfmri.prep[, -1]

# PCA analysis
pca.brain <- prcomp(brain.prep, center = T, scale. = T)
pca.summary <- summary(pca.brain)$importance
View(t(pca.summary))

# drawing the screeplot to identify the poper number of components: eigenvalue > 1
screeplot(pca.brain, type = 'l', npcs = 20)
abline(h = 1, col = 'red')

library(factoextra)
fviz_pca_ind(pca.brain, geom.ind = "point", pointshape = 21, 
             pointsize = 2, 
             fill.ind = demo.df$abcd_site, 
             col.ind = "black", 
             palette = "jco", 
             addEllipses = TRUE,
             label = "var",
             col.var = "black",
             repel = TRUE,
             legend.title = "21 Sites") +
  ggtitle("2D PCA-plot from MID fMRI") +
  theme(plot.title = element_text(hjust = 0.5))
