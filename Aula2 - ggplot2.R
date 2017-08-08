###########################################################################################################
## Aula 2
## ggplot2
###########################################################################################################
library(tidyverse)

dados <- tibble(x = 1:100, y = x*0.5+rnorm(100, 25, 5))
ggplot(data = dados, mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm")
  
amostras100 <- as.tibble(read.csv2(file = "100_amostras.csv", header = TRUE, dec = "."))
sexo <- as.tibble(read.csv2("sexo.csv"))
