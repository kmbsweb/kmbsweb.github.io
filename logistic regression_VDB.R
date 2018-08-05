##retrieve data
target <- read.csv("base_data.csv", header=T, fileEncoding="Shift_JIS",as.is =T)
target <- na.omit(target)

##logistic regression
target <- target[,c(-1,-5)]
colnames(target)
output.lm <- lm(GR_MT0.5?., data=target)
summary(output.lm)

##�\���l�Ǝ��ۂ̒l�Ƃ��W�v����
predict.glm <- ifelse(output.lm$fitted.values>=0.5,1,0)
com.data <- cbind(target, predict.glm)
out.table.glm <- table(com.data$predict.glm,target$GR_MT0.5)

answer.glm<-sum(diag(out.table.glm))
sample.glm<-sum(out.table.glm)
answer.glm<-answer.glm/sample.glm
answer.glm
[1] 0.651446

##���d�������̊m�F
install.packages("car")
library(car) 
vif(output.lm)  

# stepwise�@��AIC���Ⴍ�Ȃ郂�f�����m�F
# �ϐ����X�e�b�v���Ƃɑ�����AIC��ŗǂ����f���I������
best.model.glm <- step(output.lm)
best.model.glm

#�\���l�Ǝ��ۂ̒l�Ƃ��W�v����
predict.best.glm<-ifelse(best.model.glm$fitted.values>=0.5,1,0)
com.data<-cbind(target, predict.best.glm)
out.table.best.glm<-table(com.data$predict.best.glm,com.data$GR_MT0.5)

answer.best.glm<-sum(diag(out.table.best.glm))
sample.best.glm<-sum(out.table.best.glm)
answer.best.glm<-answer.best.glm/sample.best.glm
answer.best.glm
[1] 0.6499239