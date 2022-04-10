
-------- ##### Factor Analysis ##### ---------

#import from azure data set - ins_account_data_account_lv
attach(inst_acc_lv)
names(inst_acc_lv)

-------- ##### Data Pre-processing ##### ---------

# Drop null values
inst_acc_lv_1 <- na.omit(inst_acc_lv)
inst_acc_lv_1

# Remove missing values 
inst_acc_lv_2 = inst_acc_lv_1[complete.cases(inst_acc_lv_1),]

# Drop labels, target variable and zero value columns
inst_acc_lv_3 = subset(inst_acc_lv_2, select = -c(`User Name`,
                                                  `Description_subjective - sum`,
                                                  Description_subjective_pct,
                                                  `Followers at Posting - last`,
                                                  `Followers at Posting - max`,
                                                  `Followers at Posting - var`))

# Normalize data set
st_insta_data <-  as.data.frame(scale(inst_acc_lv_3, center = TRUE, scale = TRUE))

# Correlation matrix
res <- cor(st_insta_data)
round(res, 2)

-------- ##### Principal Component Analysis w/o Text Analysis #####---------

# PCA - without rotation
library(psych)
pca_ig = principal(st_insta_data,nfactors = 22, rotate='none')
pca_ig

# Number of factors = SS loading > 1 which gives us 9 factors
# PCA with rotation and 9 selected factors
pca_ig_rot = principal(st_insta_data,nfactors = 9)
pca_ig_rot

# Factor scores
pca_ig_rot$scores

-------- ##### Factor Clustering ##### ---------
# Run a cluster analysis to interpret the factor scores and group them under 'general factors'

### Elbow method (look at the knee)
#install.packages("factoextra")
library(factoextra)

# Elbow method for k-means
fviz_nbclust(pca_ig_rot$scores, kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)

# It can be seen a bend (or "elbow") at k = 3. 
# This bend indicates that additional clusters beyond the third have little value.

set.seed(42)
factor_clusters = kmeans(pca_ig_rot$scores,3,nstart=25)
factor_clusters

# Cluster number for each of the observations
factor_clusters$cluster
head(factor_clusters$cluster, 4)

# Cluster size
factor_clusters$size

# Cluster means
factor_clusters$centers

# Visualize k-means clustering
fviz_cluster(factor_clusters,pca_ig_rot$scores, ellipse.type = "norm")

# Use repel = TRUE to avoid overplotting
fviz_cluster(factor_clusters,pca_ig_rot$scores, ellipse.type = "norm",repel = TRUE)

-------- ##### Linear Regression with Factor Scores ##### ---------

# Target - Followers
# Variables - Factor Scores

-------- ##### Principal Component Analysis with Text Analysis #####---------

#import from azure data set - ins_account_data_account_lv_text

attach(ins_account_data_account_lv_text)
inst_acc_lv_both <- merge(inst_acc_lv,ins_account_data_account_lv_text,by="User Name")
inst_acc_lv_both

-------- ##### Data Pre-processing ##### ---------

# Drop null values
inst_acc_lv_both1 <- na.omit(inst_acc_lv_both)
inst_acc_lv_both1

# Remove missing values 
inst_acc_lv_both2 = inst_acc_lv_both1[complete.cases(inst_acc_lv_both1),]

# Drop labels, target variable and zero value columns
inst_acc_lv_both3 = subset(inst_acc_lv_both2, select = -c(`User Name`,
                                                  `Description_subjective - sum`,
                                                  Description_subjective_pct,
                                                  `Followers at Posting - last`,
                                                  `Followers at Posting - max`,
                                                  `Followers at Posting - var`))

# Normalize data set
std_insta_acc_lv_both <-  as.data.frame(scale(inst_acc_lv_both3, center = TRUE, scale = TRUE))

# Correlation matrix
res <- cor(std_insta_acc_lv_both)
round(res, 2)

-------- ##### PCA Analysis ##### ---------

# PCA - without rotation
library(psych)
pca_ig_both = principal(std_insta_acc_lv_both,nfactors = 115, rotate='none')
pca_ig_both

# Number of factors = SS loading > 1 which gives us 41 factors
# PCA with rotation and 9 selected factors
pca_ig_rot_both = principal(std_insta_acc_lv_both,nfactors = 41)
pca_ig_rot_both

# Factor scores
pca_ig_rot_both$scores

-------- ##### Linear Regression with Factor Scores incl Text Analysis ##### ---------

# Target - Followers
# Variables - Factor Scores

