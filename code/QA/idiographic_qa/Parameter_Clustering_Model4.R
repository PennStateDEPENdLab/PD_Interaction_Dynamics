pars <- read.csv("~/Box Sync/DEPENd/Projects/PD_Interaction_Dynamics/output/icsVBA/parameters_model4_feb2017.csv")
pars <- dplyr::rename(pars, a1 = V1, a2 = V2, b1 = V3, b2 = V4)
pars_outliers <- subset(pars, abs(a1) > 1 | abs(a2) > 1 | abs(b1) > 1 | abs(b2) > 1 | F < -70000)
pars <- subset(pars, abs(a1) < 1 & abs(a2) < 1 & abs(b1) < 1 & abs(b2) < 1 & F > -70000)
hist(pars$a1)
hist(pars$a2)
hist(pars$b1)
hist(pars$b2)
hist(pars$F)
pars <- dplyr::filter(pars, PTNUM != 8052, PTNUM != 8063, PTNUM != 8066)
#tocluster <- scale(pars[,c("a1", "a2", "b1")])
tocluster <- pars[,c("a1", "a2", "b1", "b2")]

cor(tocluster)

pr <- prcomp(tocluster)
sum(pr$sdev)
cumvariance <- (cumsum((pr$sdev)^2) / sum(pr$sdev^2))
cumvariance
pr$rotation #varimax or promax rotation if you need to interpret this

library(psych)
psych::principal(tocluster, nfactors=4, rotate="varimax")

fit <- kmeans(tocluster, 4)

# Cluster Plot against 1st 2 principal components

# vary parameters for most readable graph
library(cluster) 
clusplot(tocluster, fit$cluster, color=TRUE, shade=TRUE, 
         
         labels=2, lines=0)

aggregate(tocluster,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(mydata, fit$cluster)


#number of clusters
wss <- (nrow(tocluster)-1)*sum(apply(tocluster,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(tocluster, 
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

library(mclust)
fit <- Mclust(tocluster)
plot(fit) # plot results 
summary(fit) # display the best model

pars$mclust2 <- fit$classification
aggregate(pars,by=list(pars$mclust2),FUN=mean)
subset(pars, mclust2==2)
cor(tocluster)

library(ggplot2)
pdf(file.path(getBoxDir(), "DEPENd/Projects/PD_Interaction_Dynamics/figures", "m5_param_correlations.pdf"), width=10, height=8)
ggplot(tocluster, aes(x=a1, y=b1, color=a2)) + geom_point(size=2) + theme_bw(base_size=15)
dev.off()