# Importamos nuestros datos
data <- read.csv("/home/armd22a/Desktop/BEDU/modulo2/Programacion-R-Santander-2021-main/proyecto/heart.csv")
data <- as.data.frame(data)
head(data)
str(data)

# como los nombres de las columnas están en inglés, los vamos a recomnbrar
library(dplyr)

data <- rename(data, Chest_Pain_Type= ChestPainType,  Resting_BP = RestingBP,
               Fasting_BS= FastingBS,
               Resting_ECG = RestingECG,
               Max_HR = MaxHR,
               Exercise_Angina = ExerciseAngina,
               Heart_Disease = HeartDisease )
# Comprobamos que los cambias se hayan efectuado

names(data)
str(data)
attach(data)
# Para poder hacer un mejor analisis, vamos a convertir algunos datos de tipo char a factor. 

data <- mutate(data, Heart_Disease = as.logical(Heart_Disease), 
               Chest_Pain_Type = as.factor(Chest_Pain_Type),
               Resting_ECG = as.factor(Resting_ECG),
               Exercise_Angina = as.factor(Exercise_Angina),
               ST_Slope = as.factor(ST_Slope)
               ) 
str(data)
# importamos la libreria ggplot2 para hacer nuestros gráficos

library(ggplot2)

# histograma de edades (Age)
data %>%
  ggplot() +
  aes(data$Age) + 
  geom_histogram(binwidth = 5,col="black", fill="red") +
  ggtitle("Histograma de edades") +
  geom_vline(xintercept = mean(data$Age,linetype="dashed",color = "black")) +
  xlab("Age") + ylab("Frecuencia")

# histograma de Colesterol (cholesterol) 
data %>%
  ggplot() +
    aes(data$Cholesterol) + 
  geom_histogram(binwidth = 5,col="black", fill="blue") +
  ggtitle("Histograma de colesterol (cholesterol)") +
  geom_vline(xintercept = mean(data$Cholesterol,linetype="dashed",color = "black")) +
  xlab("Cholesterol[mm/dl]") + ylab("Frecuencia")
# boxplot de colesterol 
ggplot(data, aes(x = Cholesterol, fill = Sex)) + geom_boxplot() +
  ggtitle("Boxplots de colesterol por sexo") +
  xlab("Cholesterol") 

# histograma de presión arterial en reposo (Resting_BP)

data %>%
  ggplot() +
  aes(data$Resting_BP) + 
  geom_histogram(binwidth = 5,col="black", fill="green") +
  ggtitle("Histograma de los valores de presión arterial en reposo(Resting_BP)") +
  geom_vline(xintercept = mean(data$Resting_BP,linetype="dashed",color = "black")) +
  xlab("Presion arterial en reposo [mm Hg] ")+
  ylab("Frecuencia")

# histograma de Max_HR 

data %>%
  ggplot() +
  aes(Max_HR) + 
  geom_histogram(binwidth = 5,col="black", fill="yellow") +
  ggtitle("Histograma de los máximos de frecuencias cardiacas (Max_HR)") +
  geom_vline(xintercept = mean(data$Max_HR,linetype="dashed",color = "black")) +
  xlab("Max HR") + ylab("Frecuencia")

# boxplot de Max_HR por sexo

ggplot(data, aes(x = Max_HR, fill = Sex)) + 
  geom_boxplot() + 
  ggtitle("Boxplots de los máximos de frecuencias cardiacas por sexo ") +  
  xlab("Max_HR") 

# grafico de barras de 

ggplot(data, aes(x=Cholesterol,y=Max_HR),color=Default) + 
  geom_point() + theme_light()+ facet_wrap("Heart_Disease")
  ggtitle("Tipo de dolor de pecho y Colesterol, divididos por sexo.") +
  xlab("ChestTA: angina típica, ATA: angina atípica, NAP: dolor no anginal, ASY: asintomático")

# Importamos una paquetería que nos va a ayudar a ajustar una normal a nuestros datos

install.packages("fitdistrplus") 
library(fitdistrplus)

# Ajuste normal de los máximos valores de la frecuencia cardiaca. (Max_HR) 

FIT <- fitdist(data$Max_HR, "norm")    ## note: it is "norm" not "normal"
class(FIT)
plot(FIT) 

# Ajuste normal de la variable edad. (Age)  
FIT <- fitdist(data$Age, "norm")    ## note: it is "norm" not "normal"
class(FIT)
plot(FIT) 
# Ajuste normal de la variable Colesterol (Cholesterol).  
FIT <- fitdist(data$Cholesterol, "norm")    ## note: it is "norm" not "normal"
class(FIT)
plot(FIT) 

# Ajuste normal de la variable presión arterial en reposo (Resting_BP)¨.  
FIT <- fitdist(data$Resting_BP, "norm")    ## note: it is "norm" not "normal"
class(FIT)
plot(FIT) 

# Correlación entre variables numéricas

pairs( ~ Age + Cholesterol + Max_HR + Resting_BP, data = data, gap = 0.4, cex.labels = 1.5)

# Matriz de correlación
cor(data[,-c(2,3,6,7,9,10,11,12)])

# Llevamos a cabo el ajuste de un modelo
# Y = beta0 + beta1*Age + beta2*Cholesterol + beta3*Max_HR + beta4*Resting_BP + 
#     beta5*Fasting_BS + e

m1 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Resting_BP + Fasting_BS)
summary(m1)

# Realizamos el mismo ajuste pero quitanto la variable Resintg_BP, que es la que tuvo
# menos relevancia.
# Y = beta0 + beta1*Age + beta2*Cholesterol + beta3*Max_HR + beta4*Fasting_BS + e

m2 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Fasting_BS)
summary(m2)

# El modelo no tuvo una mejora sifnificativa, por lo que realiozamos los siguientes ajustes

mfull1 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Resting_BP +Age*Max_HR +
              Cholesterol*Max_HR + Resting_BP*Max_HR)
summary(mfull1)

mfull2 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Resting_BP +Age*Max_HR +
              Cholesterol*Age + Resting_BP*Age)
summary(mfull2)

mfull3 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Resting_BP +Age*Cholesterol +
               Cholesterol*Max_HR + Resting_BP*Cholesterol)

summary(mfull3)

mfull4 <- lm(Heart_Disease ~ Age + Cholesterol + Max_HR + Resting_BP +Age*Resting_BP +
               Cholesterol*Resting_BP + Resting_BP*Max_HR)

summary(mfull4)
# Como el valor de Adjusted R squared de mfull4 fue el mayor de todos los anterios, lo comparon con
# m1

# La prueba de si el efecto de los predictores depende de la variable Resting_BP
# puede lograrse usando la siguiente prueba-F parcial.

anova(m1,mfull2)

# la anova no fue exitosa, porque no arrojó un P-value

