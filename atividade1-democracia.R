## Atividade Pratica 1

library(tidyverse)

democracy <- as.tibble(read.csv2(file = "democracy_index.csv", dec = ".", stringsAsFactors = FALSE))
corruption <- as.tibble(read.csv2(file = "corruption_index.csv", dec = ".", stringsAsFactors = FALSE))
human <- as.tibble(read.csv2(file = "human_development_index.csv", dec = ".", stringsAsFactors = FALSE))
press <- as.tibble(read.csv2(file = "press_freedom.csv", dec = ".", stringsAsFactors = FALSE))


# Ajusta observacoes com NA e nomes de colunas ----------------------------
democracy  <- democracy[complete.cases(democracy), ]
colnames(democracy) <- c("Country", 2006, 2008, 2010:2016)

corruption <- corruption[complete.cases(corruption), ]
colnames(corruption) <- c("Country", 2006:2016)

human <- human[complete.cases(human), ]
colnames(human) <- c("Country", 2006:2015)

press <- press[complete.cases(press), ]
colnames(press) <- c("Country", 2006:2017)

# Transforma em Tidy ------------------------------------------------------
democracy_tidy <- democracy %>% 
  gather(key = Ano, value = Valor, -Country)

corruption_tidy <- corruption %>% 
  gather(key = Ano, value = Valor, -Country)

human_tidy <- human %>% 
  gather(key = Ano, value = Valor, -Country)

press_tidy <- press %>% 
  gather(key = Ano, value = Valor, -Country)


# Junta todos os data frames ----------------------------------------------
big_data <- democracy_tidy %>% 
  inner_join(corruption_tidy, by = c("Country", "Ano")) %>% 
  inner_join(human_tidy, by = c("Country", "Ano")) %>% 
  inner_join(press_tidy, by = c("Country", "Ano"))
colnames(big_data) <- c("Country", "Ano", "Democracia", "Corrupcao", "IDH", "Imprensa")

# Visualizacao ------------------------------------------------------------
# x = valor do indice de corrupcao
# y =  valor do indice de democracia
plot <- ggplot(big_data, aes(x = Imprensa, y = Democracia))+
  geom_point()+
  geom_smooth(method = "lm")
plot
